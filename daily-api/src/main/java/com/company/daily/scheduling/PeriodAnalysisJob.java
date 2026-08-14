package com.company.daily.scheduling;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodWindowService;
import java.time.LocalDate;
import java.time.ZoneId;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.stereotype.Component;

@Component
@DisallowConcurrentExecution
public class PeriodAnalysisJob implements Job {
  private final AnalysisOrchestrator orchestrator;
  private final AnalysisPeriodWindowService windowService;

  public PeriodAnalysisJob(
      AnalysisOrchestrator orchestrator, AnalysisPeriodWindowService windowService) {
    this.orchestrator = orchestrator;
    this.windowService = windowService;
  }

  @Override
  public void execute(JobExecutionContext context) {
    AnalysisPeriod period = AnalysisPeriod.valueOf(context.getMergedJobDataMap().getString("period"));
    LocalDate date = LocalDate.now(ZoneId.of("Asia/Shanghai"));
    if (windowService.isScheduledEnd(period, date)) {
      orchestrator.run(windowService.resolve(period, date), "scheduled");
    }
  }
}
