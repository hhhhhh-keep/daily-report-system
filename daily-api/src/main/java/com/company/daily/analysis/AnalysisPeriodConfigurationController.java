package com.company.daily.analysis;

import jakarta.validation.Valid;
import java.util.List;
import org.quartz.SchedulerException;
import com.company.daily.scheduling.PeriodAnalysisScheduleManager;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/configuration/analysis-periods")
public class AnalysisPeriodConfigurationController {
  private final AnalysisPeriodConfigurationService configurationService;
  private final PeriodAnalysisScheduleManager scheduleManager;

  public AnalysisPeriodConfigurationController(
      AnalysisPeriodConfigurationService configurationService,
      PeriodAnalysisScheduleManager scheduleManager) {
    this.configurationService = configurationService;
    this.scheduleManager = scheduleManager;
  }

  @GetMapping
  public List<AnalysisPeriodConfiguration> list() {
    return configurationService.list();
  }

  @PutMapping("/{period}")
  public AnalysisPeriodConfiguration update(
      @PathVariable AnalysisPeriod period,
      @Valid @RequestBody AnalysisPeriodConfigurationRequest request) throws SchedulerException {
    AnalysisPeriodConfiguration updated = configurationService.update(new AnalysisPeriodConfiguration(
        period, request.enabled(), request.cronExpression(), request.enabledModules(),
        request.retentionMonths(), request.includeEvidenceInDelivery()));
    scheduleManager.reschedule();
    return updated;
  }
}
