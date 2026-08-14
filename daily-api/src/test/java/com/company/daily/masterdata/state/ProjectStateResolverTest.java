package com.company.daily.masterdata.state;

import static org.assertj.core.api.Assertions.assertThat;

import java.time.LocalDate;
import org.junit.jupiter.api.Test;

class ProjectStateResolverTest {
  private final ProjectStateResolver resolver = new ProjectStateResolver();

  @Test
  void mapsPresalesStageToPresalesInProgress() {
    ProjectDerivedStateValue state = resolver.resolve(
        new ProjectStateFact(1L, LocalDate.of(2026, 8, 12), "project-support",
            "solution-design", "in-progress"));

    assertThat(state).isEqualTo(ProjectDerivedStateValue.PRESALES_IN_PROGRESS);
  }

  @Test
  void givesBlockedStatusPriority() {
    ProjectDerivedStateValue state = resolver.resolve(
        new ProjectStateFact(1L, LocalDate.of(2026, 8, 12), "project-support",
            "solution-design", "blocked"));

    assertThat(state).isEqualTo(ProjectDerivedStateValue.BLOCKED);
  }

  @Test
  void mapsSpecialWorkToGenericInProgress() {
    ProjectDerivedStateValue state = resolver.resolve(
        new ProjectStateFact(1L, LocalDate.of(2026, 8, 12), "special-work", null, "in-progress"));

    assertThat(state).isEqualTo(ProjectDerivedStateValue.IN_PROGRESS);
  }
}
