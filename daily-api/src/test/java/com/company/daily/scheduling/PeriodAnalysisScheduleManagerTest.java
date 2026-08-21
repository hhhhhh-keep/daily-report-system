package com.company.daily.scheduling;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodConfiguration;
import com.company.daily.analysis.AnalysisPeriodConfigurationService;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;

class PeriodAnalysisScheduleManagerTest {
  @Test
  void schedulesDailyAnalysisWhenDailyAnalysisIsEnabled() throws Exception {
    Scheduler scheduler = mock(Scheduler.class);
    AnalysisPeriodConfigurationService configurationService =
        mock(AnalysisPeriodConfigurationService.class);
    when(configurationService.list()).thenReturn(List.of(new AnalysisPeriodConfiguration(
        AnalysisPeriod.DAILY, true, "0 10 22 ? * MON-FRI", List.of("workload"), 24, true)));

    new PeriodAnalysisScheduleManager(scheduler, configurationService).reschedule();

    verify(scheduler).scheduleJob(any(CronTrigger.class));
  }
}
