package com.company.daily.scheduling;

import com.company.daily.workday.WorkdayService;
import java.time.LocalDate;
import java.time.ZoneId;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.stereotype.Component;

@Component
@DisallowConcurrentExecution
public class AnalysisJob implements Job {
  private final AnalysisOrchestrator orchestrator;
  private final WorkdayService workdayService;

  public AnalysisJob(AnalysisOrchestrator orchestrator, WorkdayService workdayService) {
    this.orchestrator = orchestrator;
    this.workdayService = workdayService;
  }

  @Override
  public void execute(JobExecutionContext context) {
    LocalDate date = LocalDate.now(ZoneId.of("Asia/Shanghai"));
    if (workdayService.isWorkday(date)) {
      orchestrator.run(date, "scheduled");
    }
  }
}
