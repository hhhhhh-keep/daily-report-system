package com.company.daily.masterdata.service;

import static org.assertj.core.api.Assertions.assertThat;

import java.time.LocalDate;
import java.util.List;
import org.junit.jupiter.api.Test;

class ProjectActivitySummaryTest {
  @Test
  void aggregatesAllTaskStatusesForTheSelectedPeriod() {
    ProjectActivitySummary summary = ProjectActivitySummary.from(List.of(
        new ProjectActivitySummary.Item(1L, LocalDate.of(2026, 8, 1), "completed"),
        new ProjectActivitySummary.Item(1L, LocalDate.of(2026, 8, 2), "in-progress"),
        new ProjectActivitySummary.Item(2L, LocalDate.of(2026, 8, 3), "blocked"),
        new ProjectActivitySummary.Item(2L, LocalDate.of(2026, 8, 4), "paused")));

    assertThat(summary.participantCount()).isEqualTo(2);
    assertThat(summary.latestReportDate()).isEqualTo(LocalDate.of(2026, 8, 4));
    assertThat(summary.completedCount()).isEqualTo(1);
    assertThat(summary.inProgressCount()).isEqualTo(1);
    assertThat(summary.blockedOrPausedCount()).isEqualTo(2);
  }
}
