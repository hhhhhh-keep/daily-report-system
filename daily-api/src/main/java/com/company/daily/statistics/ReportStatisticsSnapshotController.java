package com.company.daily.statistics;

import java.time.LocalDate;
import java.util.List;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/report-statistics-snapshots")
public class ReportStatisticsSnapshotController {
  private final ReportStatisticsService service;

  public ReportStatisticsSnapshotController(ReportStatisticsService service) {
    this.service = service;
  }

  @GetMapping
  public List<ReportStatisticsSnapshotResponse> list(
      @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
      @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
    return service.list(startDate, endDate);
  }
}
