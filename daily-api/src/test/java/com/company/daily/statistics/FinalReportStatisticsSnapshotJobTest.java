package com.company.daily.statistics;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.company.daily.masterdata.state.ProjectDerivedStateService;
import com.company.daily.masterdata.state.ProjectStateSnapshotService;
import com.company.daily.report.service.DailyReportLockService;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.quartz.JobExecutionContext;

class FinalReportStatisticsSnapshotJobTest {
  private final ReportStatisticsService statisticsService = mock(ReportStatisticsService.class);
  private final DailyReportLockService reportLockService = mock(DailyReportLockService.class);
  private final ProjectDerivedStateService derivedStateService = mock(ProjectDerivedStateService.class);
  private final ProjectStateSnapshotService projectSnapshotService = mock(ProjectStateSnapshotService.class);
  private final FinalReportStatisticsSnapshotJob job = new FinalReportStatisticsSnapshotJob(
      statisticsService, reportLockService, derivedStateService, projectSnapshotService);

  @Test
  void finalSnapshotDoesNotTriggerDailyAnalysis() {
    when(statisticsService.capture(any(LocalDate.class), eq(ReportStatisticsSnapshotType.FINAL)))
        .thenReturn(Optional.of(new ReportStatisticsSnapshotResponse(
            1L, ReportStatisticsSnapshotType.FINAL, LocalDate.of(2026, 8, 20), Instant.EPOCH,
            0, 0, 0, BigDecimal.ZERO, List.of(), List.of(), List.of(), List.of())));

    job.execute(mock(JobExecutionContext.class));

    verify(reportLockService).lockDate(any(LocalDate.class));
    verify(derivedStateService).recalculateProjectsForDate(any(LocalDate.class));
    verify(projectSnapshotService).capture(any(LocalDate.class));
  }
}
