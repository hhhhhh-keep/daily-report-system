package com.company.daily.workday;

import com.company.daily.common.api.PageResponse;
import com.company.daily.common.api.ResourceNotFoundException;
import java.time.LocalDate;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class WorkdayCalendarAdminService {
  private final WorkdayCalendarRepository repository;

  public WorkdayCalendarAdminService(WorkdayCalendarRepository repository) {
    this.repository = repository;
  }

  @Transactional(readOnly = true)
  public PageResponse<WorkdayCalendarResponse> calendar(int year, int page, int size) {
    int safePage = Math.max(0, page);
    int safeSize = size <= 0 ? 50 : Math.min(size, 200);
    LocalDate start = LocalDate.of(year, 1, 1);
    LocalDate end = start.plusYears(1).minusDays(1);
    Page<WorkdayCalendar> result = repository.findAll(PageRequest.of(safePage, safeSize));
    // 全年 ~365 行；当 size>=365 时一次返回即可，无须额外按日期过滤，
    // 大小页（size<365）则由数据库分页，UI 翻页时只取对应页。
    List<WorkdayCalendarResponse> items = result.getContent().stream()
        .filter(entry -> !entry.getCalendarDate().isBefore(start) && !entry.getCalendarDate().isAfter(end))
        .map(this::response).toList();
    long total = repository.count();
    return PageResponse.of(items, total, safePage, safeSize);
  }

  @Transactional
  public WorkdayCalendarResponse saveAdministratorOverride(WorkdayOverrideRequest request) {
    WorkdayCalendar entry = repository.findByCalendarDateAndSource(
        request.date(), WorkdaySource.ADMIN_OVERRIDE).orElseGet(() ->
            WorkdayCalendar.administratorOverride(request.date(), request.workday(), note(request.note())));
    entry.reactivate(request.workday(), note(request.note()));
    return response(repository.save(entry));
  }

  @Transactional
  public void deactivateAdministratorOverride(LocalDate date) {
    WorkdayCalendar entry = repository.findByCalendarDateAndSource(date, WorkdaySource.ADMIN_OVERRIDE)
        .orElseThrow(() -> new ResourceNotFoundException("工作日历人工配置不存在"));
    entry.deactivate();
  }

  @Transactional
  public List<WorkdayCalendarResponse> importYear(WorkdayCalendarImportRequest request) {
    for (WorkdayCalendarImportItem item : request.entries()) {
      if (item.date().getYear() != request.year()) {
        throw new IllegalArgumentException("导入日期必须属于指定年度");
      }
      if (item.source() == WorkdaySource.ADMIN_OVERRIDE) {
        throw new IllegalArgumentException("年度导入不能覆盖管理员人工配置");
      }
      WorkdayCalendar entry = repository.findByCalendarDateAndSource(item.date(), item.source())
          .orElseGet(() -> WorkdayCalendar.imported(
              item.date(), item.workday(), item.source(), note(item.note())));
      entry.reactivate(item.workday(), note(item.note()));
      repository.save(entry);
    }
    return calendar(request.year(), 0, 200).items();
  }

  private WorkdayCalendarResponse response(WorkdayCalendar entry) {
    return new WorkdayCalendarResponse(entry.getId(), entry.getCalendarDate(), entry.isWorkday(),
        entry.getSource(), entry.getNote(), entry.isActive());
  }

  private String note(String value) {
    return StringUtils.hasText(value) ? value.trim() : null;
  }
}
