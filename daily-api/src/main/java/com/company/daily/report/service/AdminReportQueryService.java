package com.company.daily.report.service;

import com.company.daily.common.api.PageResponse;
import com.company.daily.common.api.ResourceNotFoundException;
import com.company.daily.report.api.dto.AdminReportSummaryResponse;
import com.company.daily.report.api.dto.CurrentReportResponse;
import com.company.daily.report.api.dto.CurrentTaskResponse;
import com.company.daily.report.domain.DailyReport;
import com.company.daily.report.domain.DailyTask;
import com.company.daily.report.repository.DailyReportRepository;
import com.company.daily.report.repository.DailyTaskRepository;
import com.company.daily.report.repository.DailyTaskRepository.ReportTaskCount;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AdminReportQueryService {
  private final DailyReportRepository reportRepository;
  private final DailyTaskRepository taskRepository;

  public AdminReportQueryService(
      DailyReportRepository reportRepository, DailyTaskRepository taskRepository) {
    this.reportRepository = reportRepository;
    this.taskRepository = taskRepository;
  }

  /**
   * 报表列表（分页）。三个关键优化：
   * <ol>
   *   <li>Repository 用 {@code Page<DailyReport>}，DB 端 LIMIT/OFFSET</li>
   *   <li>taskCount 通过单条 {@code GROUP BY report_id} 批量算，把 N+1 压成 1 次</li>
   *   <li>Pageable 的 Sort 由数据库完成，前端只关心 items / totalItems</li>
   * </ol>
   */
  @Transactional(readOnly = true)
  public PageResponse<AdminReportSummaryResponse> list(LocalDate date, Long employeeId,
      List<String> attendances, String keyword, int page, int size) {
    List<String> normalizedAttendances = (attendances == null || attendances.isEmpty())
        ? null : attendances;
    String normalizedKeyword = normalize(keyword);
    PageRequest pageRequest = PageRequest.of(
        Math.max(0, page), clampSize(size),
        Sort.by(Sort.Direction.DESC, "report.reportDate").and(Sort.by("employee.name")));
    Page<DailyReport> result = reportRepository.searchForAdministration(date, employeeId,
        normalizedAttendances, normalizedAttendances == null ? 0 : normalizedAttendances.size(),
        normalizedKeyword, normalizedKeyword != null, pageRequest);

    List<Long> reportIds = result.getContent().stream().map(DailyReport::getId).toList();
    Map<Long, Long> taskCounts = reportIds.isEmpty()
        ? Map.of()
        : taskRepository.countByReportIdIn(reportIds).stream()
            .collect(Collectors.toMap(ReportTaskCount::getReportId, ReportTaskCount::getTaskCount,
                (a, b) -> a, java.util.LinkedHashMap::new));

    List<AdminReportSummaryResponse> items = result.getContent().stream()
        .map(report -> new AdminReportSummaryResponse(
            report.getId(), report.getReportDate(), report.getEmployee().getId(),
            report.getEmployee().getName(), report.getAttendanceStatus(), report.getStatus(),
            taskCounts.getOrDefault(report.getId(), 0L).intValue(),
            report.getSubmittedAt(), report.getUpdatedAt()))
        .toList();
    return PageResponse.of(items, result.getTotalElements(),
        pageRequest.getPageNumber(), pageRequest.getPageSize());
  }

  private static int clampSize(int size) {
    if (size <= 0) {
      return 20;
    }
    return Math.min(size, 200);
  }

  private static String normalize(String value) {
    if (value == null) {
      return null;
    }
    String trimmed = value.trim();
    return trimmed.isEmpty() ? null : trimmed;
  }

  @Transactional(readOnly = true)
  public CurrentReportResponse detail(Long id) {
    DailyReport report = reportRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("日报不存在"));
    List<CurrentTaskResponse> tasks = taskRepository.findAllByReportIdOrderById(id).stream()
        .map(this::task)
        .toList();
    return new CurrentReportResponse(
        report.getId(), report.getEmployee().getId(), report.getEmployee().getName(),
        report.getReportDate(), report.getAttendanceStatus(), report.getNote(), report.getStatus(),
        report.getSubmittedAt(), report.getUpdatedAt(), tasks);
  }

  private CurrentTaskResponse task(DailyTask task) {
    return new CurrentTaskResponse(
        task.getId(), task.getTimePeriod().value(), task.getProject().getId(),
        task.getProject().getName(), task.getWorkType(), task.getWorkStage(), task.getParticipationRole().value(),
        task.getProgressResult(), task.getCurrentStatus().value(), task.getIssueType(),
        task.getCollaborationRole(), task.getCollaborationRequirement());
  }
}
