package com.company.daily.scheduling;

import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.TriggerKey;
import org.springframework.stereotype.Component;

@Component
public class AnalysisScheduleManager {
  private static final JobKey JOB_KEY = new JobKey("daily-analysis");
  private static final TriggerKey TRIGGER_KEY = new TriggerKey("daily-analysis-trigger");
  private final Scheduler scheduler;
  private final PeriodAnalysisScheduleManager periodScheduleManager;

  public AnalysisScheduleManager(
      Scheduler scheduler, PeriodAnalysisScheduleManager periodScheduleManager) {
    this.scheduler = scheduler;
    this.periodScheduleManager = periodScheduleManager;
  }

  public synchronized void reschedule() throws SchedulerException {
    if (scheduler.checkExists(TRIGGER_KEY)) {
      scheduler.unscheduleJob(TRIGGER_KEY);
    }
    if (scheduler.checkExists(JOB_KEY)) {
      scheduler.deleteJob(JOB_KEY);
    }
    periodScheduleManager.reschedule();
  }
}
