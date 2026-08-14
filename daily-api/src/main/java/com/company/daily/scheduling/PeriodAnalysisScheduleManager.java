package com.company.daily.scheduling;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodConfiguration;
import com.company.daily.analysis.AnalysisPeriodConfigurationService;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDataMap;
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
public class PeriodAnalysisScheduleManager implements ApplicationRunner {
  private final Scheduler scheduler;
  private final AnalysisPeriodConfigurationService configurationService;

  public PeriodAnalysisScheduleManager(
      Scheduler scheduler, AnalysisPeriodConfigurationService configurationService) {
    this.scheduler = scheduler;
    this.configurationService = configurationService;
  }

  @Override
  public void run(ApplicationArguments args) throws SchedulerException {
    reschedule();
  }

  public synchronized void reschedule() throws SchedulerException {
    for (AnalysisPeriodConfiguration configuration : configurationService.list()) {
      AnalysisPeriod period = configuration.period();
      JobKey jobKey = new JobKey("analysis-" + period.name().toLowerCase());
      TriggerKey triggerKey = new TriggerKey("analysis-" + period.name().toLowerCase() + "-trigger");
      if (!configuration.enabled()) {
        if (scheduler.checkExists(triggerKey)) {
          scheduler.unscheduleJob(triggerKey);
        }
        continue;
      }
      if (!scheduler.checkExists(jobKey)) {
        JobDetail job = JobBuilder.newJob(PeriodAnalysisJob.class).withIdentity(jobKey)
            .usingJobData(new JobDataMap(java.util.Map.of("period", period.name())))
            .storeDurably().build();
        scheduler.addJob(job, false);
      }
      CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(triggerKey).forJob(jobKey)
          .withSchedule(CronScheduleBuilder.cronSchedule(configuration.cronExpression())
              .inTimeZone(TimeZone.getTimeZone("Asia/Shanghai"))
              .withMisfireHandlingInstructionDoNothing()).build();
      if (scheduler.checkExists(triggerKey)) {
        scheduler.rescheduleJob(triggerKey, trigger);
      } else {
        scheduler.scheduleJob(trigger);
      }
    }
  }
}
