package com.company.daily.report.api;

import com.company.daily.common.api.PageResponse;
import com.company.daily.report.api.dto.AdminReportSummaryResponse;
import com.company.daily.report.api.dto.CurrentReportResponse;
import com.company.daily.report.api.dto.ReportPeriodStatisticsResponse;
import com.company.daily.report.service.AdminReportQueryService;
import com.company.daily.report.service.ReportPeriodStatisticsExcelExporter;
import com.company.daily.report.service.ReportPeriodStatisticsService;
import java.time.LocalDate;
import java.util.List;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/reports")
public class AdminReportController {
  private final AdminReportQueryService service;
  private final ReportPeriodStatisticsService periodStatisticsService;
  private final ReportPeriodStatisticsExcelExporter periodStatisticsExcelExporter;

  public AdminReportController(
      AdminReportQueryService service, ReportPeriodStatisticsService periodStatisticsService,
      ReportPeriodStatisticsExcelExporter periodStatisticsExcelExporter) {
    this.service = service;
    this.periodStatisticsService = periodStatisticsService;
    this.periodStatisticsExcelExporter = periodStatisticsExcelExporter;
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

  @GetMapping("/period-statistics")
  public ReportPeriodStatisticsResponse periodStatistics(
      @RequestParam(required = false) String period,
      @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate anchor,
      @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate start,
      @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate end) {
    if (start != null || end != null) {
      return periodStatisticsService.statistics(start, end);
    }
    if (period == null || anchor == null) {
      throw new IllegalArgumentException("请提供统计周期及结束日期，或同时提供统计开始日期和结束日期");
    }
    return periodStatisticsService.statistics(period, anchor);
  }

  @GetMapping("/period-statistics/export")
  public ResponseEntity<byte[]> exportPeriodStatistics(
      @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate start,
      @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate end) {
    ReportPeriodStatisticsResponse statistics = periodStatisticsService.statistics(start, end);
    String fileName = "填报累计统计_" + statistics.periodStart() + "至" + statistics.periodEnd() + ".xlsx";
    return ResponseEntity.ok()
        .contentType(MediaType.parseMediaType(
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
        .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
            .filename(fileName, java.nio.charset.StandardCharsets.UTF_8).build().toString())
        .body(periodStatisticsExcelExporter.export(statistics));
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
