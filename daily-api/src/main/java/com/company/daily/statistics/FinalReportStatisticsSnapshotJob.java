package com.company.daily.statistics;

import com.company.daily.report.service.DailyReportLockService;
import com.company.daily.masterdata.state.ProjectDerivedStateService;
import com.company.daily.masterdata.state.ProjectStateSnapshotService;
import java.time.LocalDate;
import java.time.ZoneId;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.stereotype.Component;

@Component
@DisallowConcurrentExecution
public class FinalReportStatisticsSnapshotJob implements Job {
  private final ReportStatisticsService statisticsService;
  private final DailyReportLockService reportLockService;
  private final ProjectDerivedStateService derivedStateService;
  private final ProjectStateSnapshotService projectSnapshotService;

  public FinalReportStatisticsSnapshotJob(
      ReportStatisticsService statisticsService,
      DailyReportLockService reportLockService,
      ProjectDerivedStateService derivedStateService,
      ProjectStateSnapshotService projectSnapshotService) {
    this.statisticsService = statisticsService;
    this.reportLockService = reportLockService;
    this.derivedStateService = derivedStateService;
    this.projectSnapshotService = projectSnapshotService;
  }

  @Override
  public void execute(JobExecutionContext context) {
    LocalDate date = LocalDate.now(ZoneId.of("Asia/Shanghai"));
    reportLockService.lockDate(date);
    if (statisticsService.capture(date, ReportStatisticsSnapshotType.FINAL).isPresent()) {
      derivedStateService.recalculateProjectsForDate(date);
      projectSnapshotService.capture(date);
    }
  }
}
