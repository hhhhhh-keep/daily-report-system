package com.company.daily.report.api;

import com.company.daily.report.api.dto.ReportOptionsResponse;
import com.company.daily.report.service.ReportOptionsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/report/options")
public class ReportOptionsController {
  private final ReportOptionsService reportOptionsService;

  public ReportOptionsController(ReportOptionsService reportOptionsService) {
    this.reportOptionsService = reportOptionsService;
  }

  @GetMapping
  public ReportOptionsResponse options() {
    return reportOptionsService.getOptions();
  }
}
