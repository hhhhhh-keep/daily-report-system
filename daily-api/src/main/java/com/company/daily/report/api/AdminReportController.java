package com.company.daily.report.api;

import com.company.daily.common.api.PageResponse;
import com.company.daily.report.api.dto.AdminReportSummaryResponse;
import com.company.daily.report.api.dto.CurrentReportResponse;
import com.company.daily.report.service.AdminReportQueryService;
import java.time.LocalDate;
import java.util.List;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/reports")
public class AdminReportController {
  private final AdminReportQueryService service;

  public AdminReportController(AdminReportQueryService service) {
    this.service = service;
  }

  @GetMapping
  public PageResponse<AdminReportSummaryResponse> list(
      @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
      @RequestParam(required = false) Long employeeId,
      @RequestParam(required = false) String attendance,
      @RequestParam(required = false) String keyword,
      @RequestParam(required = false, defaultValue = "0") int page,
      @RequestParam(required = false, defaultValue = "20") int size) {
    return service.list(date, employeeId, parseAttendances(attendance), keyword, page, size);
  }

  private static List<String> parseAttendances(String raw) {
    if (raw == null || raw.isBlank()) {
      return List.of();
    }
    return java.util.Arrays.stream(raw.split(","))
        .map(String::trim)
        .filter((value) -> !value.isEmpty())
        .distinct()
        .toList();
  }

  @GetMapping("/{id}")
  public CurrentReportResponse detail(@PathVariable Long id) {
    return service.detail(id);
  }
}
