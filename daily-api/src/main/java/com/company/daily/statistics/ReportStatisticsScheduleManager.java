package com.company.daily.statistics;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import java.util.TimeZone;

@Component
public class ReportStatisticsScheduleManager implements ApplicationRunner {
  private static final JobKey EARLY_JOB_KEY = new JobKey("report-statistics-early");
  private static final JobKey FINAL_JOB_KEY = new JobKey("report-statistics-final");
  private static final TriggerKey EARLY_TRIGGER_KEY = new TriggerKey("report-statistics-early-trigger");
  private static final TriggerKey FINAL_TRIGGER_KEY = new TriggerKey("report-statistics-final-trigger");

  private final Scheduler scheduler;
  private final ReportStatisticsConfigurationService configurationService;

  public ReportStatisticsScheduleManager(
      Scheduler scheduler, ReportStatisticsConfigurationService configurationService) {
    this.scheduler = scheduler;
    this.configurationService = configurationService;
  }

  @Override
  public void run(ApplicationArguments args) throws SchedulerException {
    reschedule();
  }

  public synchronized void reschedule() throws SchedulerException {
    ReportStatisticsConfiguration configuration = configurationService.get();
    schedule(EARLY_JOB_KEY, EARLY_TRIGGER_KEY, EarlyReportStatisticsSnapshotJob.class,
        configuration.earlySnapshotEnabled(), configuration.earlySnapshotCronExpression());
    schedule(FINAL_JOB_KEY, FINAL_TRIGGER_KEY, FinalReportStatisticsSnapshotJob.class,
        configuration.finalSnapshotEnabled(), configuration.finalSnapshotCronExpression());
  }

  private void schedule(
      JobKey jobKey,
      TriggerKey triggerKey,
      Class<? extends Job> jobClass,
      boolean enabled,
      String cronExpression) throws SchedulerException {
    if (!enabled) {
      if (scheduler.checkExists(triggerKey)) {
        scheduler.unscheduleJob(triggerKey);
      }
      return;
    }
    if (!scheduler.checkExists(jobKey)) {
      JobDetail job = JobBuilder.newJob(jobClass).withIdentity(jobKey).storeDurably().build();
      scheduler.addJob(job, false);
    }
    CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(triggerKey).forJob(jobKey)
        .withSchedule(CronScheduleBuilder.cronSchedule(cronExpression)
            .inTimeZone(TimeZone.getTimeZone("Asia/Shanghai"))
            .withMisfireHandlingInstructionDoNothing()).build();
    if (scheduler.checkExists(triggerKey)) {
      scheduler.rescheduleJob(triggerKey, trigger);
    } else {
      scheduler.scheduleJob(trigger);
    }
  }
}
