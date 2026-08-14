package com.company.daily.report.api;

import com.company.daily.report.api.dto.CurrentReportRequest;
import com.company.daily.report.api.dto.CurrentReportResponse;
import com.company.daily.report.service.CurrentReportService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/api/reports")
public class ReportController {
  private final CurrentReportService currentReportService;

  public ReportController(CurrentReportService currentReportService) {
    this.currentReportService = currentReportService;
  }

  @GetMapping
  public CurrentReportResponse getCurrent(
      @RequestParam @NotNull Long employeeId,
      @RequestParam @NotNull @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
    return currentReportService.get(employeeId, date);
  }

  @PutMapping("/current")
  public CurrentReportResponse saveCurrent(@Valid @RequestBody CurrentReportRequest request) {
    return currentReportService.save(request);
  }
}
