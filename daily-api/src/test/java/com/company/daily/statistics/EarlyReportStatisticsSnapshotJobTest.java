package com.company.daily.statistics;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;

import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.quartz.JobExecutionContext;

class EarlyReportStatisticsSnapshotJobTest {
  private final ReportStatisticsService statisticsService = mock(ReportStatisticsService.class);
  private final EarlyReportStatisticsSnapshotJob job = new EarlyReportStatisticsSnapshotJob(statisticsService);

  @Test
  void progressSnapshotOnlyCapturesThe1730Snapshot() {
    job.execute(mock(JobExecutionContext.class));

    verify(statisticsService).capture(any(LocalDate.class), eq(ReportStatisticsSnapshotType.PROGRESS_1730));
    verifyNoMoreInteractions(statisticsService);
  }
}
