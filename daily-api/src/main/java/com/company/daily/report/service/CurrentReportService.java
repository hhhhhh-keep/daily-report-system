package com.company.daily.report.service;

import com.company.daily.common.api.ResourceNotFoundException;
import com.company.daily.common.validation.CurrentDayValidator;
import com.company.daily.masterdata.domain.Employee;
import com.company.daily.masterdata.domain.Project;
import com.company.daily.masterdata.repository.BusinessDictionaryRepository;
import com.company.daily.masterdata.repository.EmployeeRepository;
import com.company.daily.masterdata.repository.ProjectRepository;
import com.company.daily.masterdata.state.ProjectDerivedStateService;
import com.company.daily.report.api.dto.CurrentReportRequest;
import com.company.daily.report.api.dto.CurrentReportResponse;
import com.company.daily.report.api.dto.CurrentTaskRequest;
import com.company.daily.report.api.dto.CurrentTaskResponse;
import com.company.daily.report.domain.CurrentStatus;
import com.company.daily.report.domain.DailyReport;
import com.company.daily.report.domain.DailyTask;
import com.company.daily.report.domain.ParticipationRole;
import com.company.daily.report.domain.TimePeriod;
import com.company.daily.report.repository.DailyReportRepository;
import com.company.daily.report.repository.DailyTaskRepository;
import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class CurrentReportService {
  private final CurrentDayValidator currentDayValidator;
  private final DailyReportRepository reportRepository;
  private final DailyTaskRepository taskRepository;
  private final EmployeeRepository employeeRepository;
  private final ProjectRepository projectRepository;
  private final BusinessDictionaryRepository dictionaryRepository;
  private final DailyReportLockService reportLockService;
  private final ProjectDerivedStateService derivedStateService;

  public CurrentReportService(
      CurrentDayValidator currentDayValidator,
      DailyReportRepository reportRepository,
      DailyTaskRepository taskRepository,
      EmployeeRepository employeeRepository,
      ProjectRepository projectRepository,
      BusinessDictionaryRepository dictionaryRepository,
      DailyReportLockService reportLockService,
      ProjectDerivedStateService derivedStateService) {
    this.currentDayValidator = currentDayValidator;
    this.reportRepository = reportRepository;
    this.taskRepository = taskRepository;
    this.employeeRepository = employeeRepository;
    this.projectRepository = projectRepository;
    this.dictionaryRepository = dictionaryRepository;
    this.reportLockService = reportLockService;
    this.derivedStateService = derivedStateService;
  }

  @Transactional
  public CurrentReportResponse save(CurrentReportRequest request) {
    currentDayValidator.requireSubmittableDate(request.date());
    reportLockService.requireOpen(request.date());
    Employee employee = activeEmployee(request.employeeId());
    String attendance = request.attendance().trim();
    if (!Set.of("present", "business-trip", "training", "leave", "leave-morning", "leave-afternoon")
        .contains(attendance)) {
      throw new IllegalArgumentException("Unsupported attendance status");
    }
    boolean fullDayLeave = "leave".equals(attendance);
    if (!fullDayLeave && (request.tasks() == null || request.tasks().isEmpty())) {
      throw new IllegalArgumentException("Work tasks are required unless attendance is leave");
    }
    List<ValidatedTask> tasks = fullDayLeave ? List.of()
        : request.tasks().stream().map(this::validateTask).toList();
    validateLeaveTimePeriods(attendance, tasks);

    DailyReport report = reportRepository
        .findByEmployeeIdAndReportDate(employee.getId(), request.date())
        .map(existing -> {
          existing.update(request.attendance().trim(), trimmedOrNull(request.note()));
          return existing;
        })
        .orElseGet(() -> DailyReport.create(
            employee, request.date(), request.attendance().trim(), trimmedOrNull(request.note())));
    DailyReport savedReport = reportRepository.saveAndFlush(report);

    Set<Long> affectedProjectIds = new LinkedHashSet<>();
    taskRepository.findAllByReportIdOrderById(savedReport.getId()).forEach(
        task -> affectedProjectIds.add(task.getProject().getId()));
    derivedStateService.removeTaskReferencesForReport(savedReport.getId());
    taskRepository.deleteByReportId(savedReport.getId());
    List<DailyTask> replacements = tasks.stream()
        .map(task -> task.toEntity(savedReport))
        .toList();
    taskRepository.saveAllAndFlush(replacements);
    tasks.forEach(task -> affectedProjectIds.add(task.project().getId()));
    affectedProjectIds.forEach(derivedStateService::recalculateProject);

    return toResponse(
        savedReport, taskRepository.findAllByReportIdOrderById(savedReport.getId()));
  }

  @Transactional(readOnly = true)
  public CurrentReportResponse get(Long employeeId, LocalDate date) {
    currentDayValidator.requireSubmittableDate(date);
    DailyReport report = reportRepository.findByEmployeeIdAndReportDate(employeeId, date)
        .orElseThrow(() -> new ResourceNotFoundException("未找到所选人员的当日日报"));
    return toResponse(report, taskRepository.findAllByReportIdOrderById(report.getId()));
  }

  private Employee activeEmployee(Long employeeId) {
    Employee employee = employeeRepository.findById(employeeId)
        .orElseThrow(() -> new IllegalArgumentException("人员不存在"));
    if (!employee.isActive()) {
      throw new IllegalArgumentException("人员已停用");
    }
    return employee;
  }

  private Project resolveProject(CurrentTaskRequest request, boolean formal) {
    Project project;
    if (request.projectId() != null) {
      project = projectRepository.findById(request.projectId())
          .orElseThrow(() -> new IllegalArgumentException("Project does not exist"));
    } else {
      String name = trimmedOrNull(request.projectName());
      if (name == null) {
        throw new IllegalArgumentException("Project name is required");
      }
      project = projectRepository.findFirstByNameAndActiveTrue(name).orElseGet(() ->
          projectRepository.save(new Project(
              name, null, null, null, null, null, "active", null, formal,
              formal ? null : "daily-special-" + UUID.randomUUID(), true)));
    }
    if (project.isFormal() != formal) {
      throw new IllegalArgumentException(formal
          ? "行业/项目支撑只能选择正式项目"
          : "专项工作只能选择专项工作");
    }
    return project;
  }

  private ValidatedTask validateTask(CurrentTaskRequest request) {
    requireDictionary("work_type", request.workType(), "工作类型不存在或已停用");
    boolean projectSupport = "project-support".equals(request.workType());
    boolean specialWork = "special-work".equals(request.workType());
    if (!projectSupport && !specialWork) {
      throw new IllegalArgumentException("工作类型必须为行业/项目支撑或专项工作");
    }
    Project project = resolveProject(request, projectSupport);
    if (!project.isActive()) {
      throw new IllegalArgumentException("项目或专项已停用");
    }

    String workStage = trimmedOrNull(request.workStage());
    if (projectSupport) {
      if (workStage == null) {
        throw new IllegalArgumentException("Project support requires a work stage");
      }
      requireDictionary("work_stage", workStage, "Work stage is unavailable");
    } else if (specialWork) {
      workStage = null;
    }
    TimePeriod timePeriod = TimePeriod.fromValue(request.timePeriod());
    ParticipationRole participationRole = ParticipationRole.fromValue(request.participationRole());
    if (timePeriod == TimePeriod.FRAGMENTED) {
      throw new IllegalArgumentException("Fragmented time period is no longer supported");
    }
    if (participationRole == ParticipationRole.TEMPORARY_SUPPORT) {
      throw new IllegalArgumentException("Temporary support role is no longer supported");
    }
    CurrentStatus currentStatus = CurrentStatus.fromValue(request.currentStatus());
    requireDictionary("participation_role", request.participationRole(), "Participation role is unavailable");
    requireDictionary("current_status", request.currentStatus(), "Current status is unavailable");
    String issueType = trimmedOrNull(request.issueType());
    String collaborationRole = trimmedOrNull(request.collaborationRole());
    String collaborationRequirement = trimmedOrNull(request.collaborationRequirement());

    if (currentStatus.requiresIssueDetails()) {
      if (issueType == null || collaborationRole == null || collaborationRequirement == null) {
        throw new IllegalArgumentException("风险或阻塞任务必须填写问题类型、协同角色和协同需求");
      }
      requireDictionary("risk_type", issueType, "问题类型不存在或已停用");
      requireDictionary("collaboration_role", collaborationRole, "协同角色不存在或已停用");
    }

    return new ValidatedTask(
        project,
        timePeriod,
        request.workType().trim(),
        workStage,
        participationRole,
        request.progressResult().trim(),
        currentStatus,
        issueType,
        collaborationRole,
        collaborationRequirement);
  }

  private void validateLeaveTimePeriods(String attendance, List<ValidatedTask> tasks) {
    if ("leave-morning".equals(attendance)
        && tasks.stream().anyMatch(task -> task.timePeriod() != TimePeriod.AFTERNOON)) {
      throw new IllegalArgumentException("Morning leave only accepts afternoon work tasks");
    }
    if ("leave-afternoon".equals(attendance)
        && tasks.stream().anyMatch(task -> task.timePeriod() != TimePeriod.MORNING)) {
      throw new IllegalArgumentException("Afternoon leave only accepts morning work tasks");
    }
  }

  private void requireDictionary(String category, String code, String message) {
    if (!dictionaryRepository.existsByCategoryAndCodeAndActiveTrue(category, code.trim())) {
      throw new IllegalArgumentException(message);
    }
  }

  private CurrentReportResponse toResponse(DailyReport report, List<DailyTask> tasks) {
    List<CurrentTaskResponse> taskResponses = tasks.stream()
        .map(task -> new CurrentTaskResponse(
            task.getId(),
            task.getTimePeriod().value(),
            task.getProject().getId(),
            task.getProject().getName(),
            task.getWorkType(),
            task.getWorkStage(),
            task.getParticipationRole().value(),
            task.getProgressResult(),
            task.getCurrentStatus().value(),
            task.getIssueType(),
            task.getCollaborationRole(),
            task.getCollaborationRequirement()))
        .toList();
    return new CurrentReportResponse(
        report.getId(),
        report.getEmployee().getId(),
        report.getEmployee().getName(),
        report.getReportDate(),
        report.getAttendanceStatus(),
        report.getNote(),
        report.getStatus(),
        report.getSubmittedAt(),
        report.getUpdatedAt(),
        taskResponses);
  }

  private static String trimmedOrNull(String value) {
    return StringUtils.hasText(value) ? value.trim() : null;
  }

  private record ValidatedTask(
      Project project,
      TimePeriod timePeriod,
      String workType,
      String workStage,
      ParticipationRole participationRole,
      String progressResult,
      CurrentStatus currentStatus,
      String issueType,
      String collaborationRole,
      String collaborationRequirement) {
    DailyTask toEntity(DailyReport report) {
      return DailyTask.create(
          report,
          project,
          timePeriod,
          workType,
          workStage,
          participationRole,
          progressResult,
          currentStatus,
          issueType,
          collaborationRole,
          collaborationRequirement);
    }
  }
}
