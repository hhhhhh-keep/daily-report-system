package com.company.daily.workday;

import com.company.daily.common.api.PageResponse;
import jakarta.validation.Valid;
import java.time.LocalDate;
import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/workday-calendar")
public class WorkdayCalendarController {
  private final WorkdayCalendarAdminService service;
  private final OfficialWorkdayCalendarNoticeService officialNoticeService;

  public WorkdayCalendarController(WorkdayCalendarAdminService service,
      OfficialWorkdayCalendarNoticeService officialNoticeService) {
    this.service = service;
    this.officialNoticeService = officialNoticeService;
  }

  @GetMapping
  public PageResponse<WorkdayCalendarResponse> calendar(
      @RequestParam int year,
      @RequestParam(required = false, defaultValue = "0") int page,
      @RequestParam(required = false, defaultValue = "50") int size) {
    return service.calendar(year, page, size);
  }

  @PutMapping("/override")
  public WorkdayCalendarResponse saveAdministratorOverride(
      @Valid @RequestBody WorkdayOverrideRequest request) {
    return service.saveAdministratorOverride(request);
  }

  @DeleteMapping("/override/{date}")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void deactivateAdministratorOverride(@PathVariable LocalDate date) {
    service.deactivateAdministratorOverride(date);
  }

  @PostMapping("/import")
  public List<WorkdayCalendarResponse> importYear(
      @Valid @RequestBody WorkdayCalendarImportRequest request) {
    return service.importYear(request);
  }

  @PostMapping("/official-preview")
  public OfficialWorkdayCalendarPreviewResponse previewOfficialNotice(
      @Valid @RequestBody OfficialWorkdayCalendarPreviewRequest request) {
    return officialNoticeService.preview(request);
  }
}
