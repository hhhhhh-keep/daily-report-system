package com.company.daily.statistics;

import jakarta.validation.Valid;
import org.quartz.SchedulerException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/configuration/report-statistics")
public class ReportStatisticsConfigurationController {
  private final ReportStatisticsConfigurationService configurationService;
  private final ReportStatisticsScheduleManager scheduleManager;

  public ReportStatisticsConfigurationController(
      ReportStatisticsConfigurationService configurationService,
      ReportStatisticsScheduleManager scheduleManager) {
    this.configurationService = configurationService;
    this.scheduleManager = scheduleManager;
  }

  @GetMapping
  public ReportStatisticsConfiguration get() {
    return configurationService.get();
  }

  @PutMapping
  public ReportStatisticsConfiguration update(
      @Valid @RequestBody ReportStatisticsConfigurationRequest request) throws SchedulerException {
    ReportStatisticsConfiguration updated = configurationService.update(request);
    scheduleManager.reschedule();
    return updated;
  }
}
