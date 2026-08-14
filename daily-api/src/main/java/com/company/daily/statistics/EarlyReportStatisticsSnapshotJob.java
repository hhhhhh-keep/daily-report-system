package com.company.daily.statistics;

import java.time.LocalDate;
import java.time.ZoneId;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.stereotype.Component;

@Component
@DisallowConcurrentExecution
public class EarlyReportStatisticsSnapshotJob implements Job {
  private final ReportStatisticsService service;

  public EarlyReportStatisticsSnapshotJob(ReportStatisticsService service) {
    this.service = service;
  }

  @Override
  public void execute(JobExecutionContext context) {
    service.capture(LocalDate.now(ZoneId.of("Asia/Shanghai")), ReportStatisticsSnapshotType.PROGRESS_1730);
  }
}
