package com.company.daily.statistics;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.company.daily.workday.WorkdayService;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.Test;
import tools.jackson.databind.ObjectMapper;

class ReportStatisticsServiceTest {
  private final WorkdayService workdayService = mock(WorkdayService.class);
  private final ReportStatisticsSnapshotRepository snapshotRepository =
      mock(ReportStatisticsSnapshotRepository.class);
  private final ReportStatisticsQueryRepository queryRepository =
      mock(ReportStatisticsQueryRepository.class);
  private final ReportStatisticsService service = new ReportStatisticsService(
      workdayService, snapshotRepository, queryRepository, new ObjectMapper(),
      java.time.Clock.fixed(Instant.parse("2026-08-12T09:30:00Z"), ZoneOffset.UTC));

  @Test
  void savesEarlySnapshotWithSubmissionTimesAndTeamStatistics() {
    LocalDate date = LocalDate.of(2026, 8, 12);
    when(workdayService.isWorkday(date)).thenReturn(true);
    when(snapshotRepository.findBySnapshotTypeAndSnapshotDate(
        ReportStatisticsSnapshotType.PROGRESS_1730, date)).thenReturn(Optional.empty());
    when(queryRepository.activeEmployees()).thenReturn(List.of(
        new StatisticsEmployee(1L, "A", "Delivery"),
        new StatisticsEmployee(2L, "B", "Delivery"),
        new StatisticsEmployee(3L, "C", "Presales")));
    when(queryRepository.submittedReports(date)).thenReturn(List.of(
        new StatisticsSubmission(1L, Instant.parse("2026-08-12T08:10:00Z")),
        new StatisticsSubmission(3L, Instant.parse("2026-08-12T09:00:00Z"))));
    when(snapshotRepository.save(org.mockito.ArgumentMatchers.any()))
        .thenAnswer(invocation -> invocation.getArgument(0));

    Optional<ReportStatisticsSnapshotResponse> result = service.capture(
        date, ReportStatisticsSnapshotType.PROGRESS_1730);

    assertThat(result).hasValueSatisfying(snapshot -> {
      assertThat(snapshot.expectedCount()).isEqualTo(3);
      assertThat(snapshot.submittedCount()).isEqualTo(2);
      assertThat(snapshot.missingCount()).isEqualTo(1);
      assertThat(snapshot.submissionRate()).isEqualByComparingTo("0.6667");
      assertThat(snapshot.submittedEmployees()).extracting(SnapshotEmployee::employeeId)
          .containsExactly(1L, 3L);
      assertThat(snapshot.teamStatistics()).anySatisfy(team -> {
        assertThat(team.teamName()).isEqualTo("Delivery");
        assertThat(team.expectedCount()).isEqualTo(2);
        assertThat(team.submittedCount()).isEqualTo(1);
      });
    });
  }

  @Test
  void finalSnapshotCapturesFinalProgressIndependentlyFromThe1730Snapshot() {
    LocalDate date = LocalDate.of(2026, 8, 12);
    when(workdayService.isWorkday(date)).thenReturn(true);
    ReportStatisticsSnapshot early = ReportStatisticsSnapshot.capture(
        ReportStatisticsSnapshotType.PROGRESS_1730, date, Instant.parse("2026-08-12T09:30:00Z"),
        3, 1, 2, new BigDecimal("0.3333"),
        "[{\"employeeId\":1,\"name\":\"A\",\"teamName\":\"Delivery\","
            + "\"submittedAt\":\"2026-08-12T08:10:00Z\"}]",
        "[]", "[]", "[]");
    when(snapshotRepository.findBySnapshotTypeAndSnapshotDate(
        ReportStatisticsSnapshotType.FINAL, date)).thenReturn(Optional.empty());
    when(queryRepository.activeEmployees()).thenReturn(List.of(
        new StatisticsEmployee(1L, "A", "Delivery"),
        new StatisticsEmployee(2L, "B", "Delivery"),
        new StatisticsEmployee(3L, "C", "Presales")));
    when(queryRepository.submittedReports(date)).thenReturn(List.of(
        new StatisticsSubmission(1L, Instant.parse("2026-08-12T08:10:00Z")),
        new StatisticsSubmission(2L, Instant.parse("2026-08-12T12:00:00Z"))));
    when(snapshotRepository.save(org.mockito.ArgumentMatchers.any()))
        .thenAnswer(invocation -> invocation.getArgument(0));

    ReportStatisticsService finalService = new ReportStatisticsService(
        workdayService, snapshotRepository, queryRepository, new ObjectMapper(),
        java.time.Clock.fixed(Instant.parse("2026-08-12T22:00:00Z"), ZoneOffset.UTC));
    Optional<ReportStatisticsSnapshotResponse> result = finalService.capture(
        date, ReportStatisticsSnapshotType.FINAL);

    assertThat(result).hasValueSatisfying(snapshot -> {
      assertThat(snapshot.submittedCount()).isEqualTo(2);
      assertThat(snapshot.missingEmployees()).extracting(SnapshotEmployee::employeeId)
          .containsExactly(3L);
      assertThat(snapshot.snapshotType()).isEqualTo(ReportStatisticsSnapshotType.FINAL);
    });
  }

  @Test
  void doesNotCaptureOnNonWorkdays() {
    LocalDate sunday = LocalDate.of(2026, 8, 16);
    when(workdayService.isWorkday(sunday)).thenReturn(false);

    Optional<ReportStatisticsSnapshotResponse> result = service.capture(
        sunday, ReportStatisticsSnapshotType.PROGRESS_1730);

    assertThat(result).isEmpty();
    verifyNoInteractions(snapshotRepository, queryRepository);
  }
}
