package com.company.daily.report.domain;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.masterdata.domain.Employee;
import com.company.daily.report.repository.DailyReportRepository;
import com.company.daily.report.service.DailyReportLockService;
import com.company.daily.statistics.ReportStatisticsSnapshotRepository;
import com.company.daily.statistics.ReportStatisticsSnapshotType;
import java.time.Instant;
import java.time.LocalDate;
import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

class DailyReportLockTest {
  @Test
  void becomesLockedAtFinalStatisticsTime() {
    DailyReport report = DailyReport.create(
        new Employee("Tester", "Team", "Consultant", true),
        LocalDate.of(2026, 8, 12), "present", null);

    report.lock(Instant.parse("2026-08-12T14:00:00Z"));

    assertThat(report.isLocked()).isTrue();
  }

  @Test
  void rejectsEditsAfterFinalSnapshot() {
    DailyReportRepository reports = Mockito.mock(DailyReportRepository.class);
    ReportStatisticsSnapshotRepository snapshots = Mockito.mock(ReportStatisticsSnapshotRepository.class);
    Mockito.when(snapshots.findBySnapshotTypeAndSnapshotDate(
            ReportStatisticsSnapshotType.FINAL, LocalDate.of(2026, 8, 12)))
        .thenReturn(Optional.of(Mockito.mock(com.company.daily.statistics.ReportStatisticsSnapshot.class)));

    DailyReportLockService service = new DailyReportLockService(reports, snapshots);

    org.assertj.core.api.Assertions.assertThatThrownBy(
            () -> service.requireOpen(LocalDate.of(2026, 8, 12)))
        .isInstanceOf(IllegalStateException.class);
  }
}
