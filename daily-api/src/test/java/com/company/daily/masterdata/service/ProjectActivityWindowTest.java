package com.company.daily.masterdata.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.time.LocalDate;
import org.junit.jupiter.api.Test;

class ProjectActivityWindowTest {
  @Test
  void resolvesThirtyDaysEndingOnRequestedDate() {
    ProjectActivityWindow window = ProjectActivityWindow.of(LocalDate.of(2026, 8, 12), 30);

    assertThat(window.startDate()).isEqualTo(LocalDate.of(2026, 7, 14));
    assertThat(window.endDate()).isEqualTo(LocalDate.of(2026, 8, 12));
  }

  @Test
  void rejectsUnsupportedWindow() {
    assertThatThrownBy(() -> ProjectActivityWindow.of(LocalDate.of(2026, 8, 12), 14))
        .isInstanceOf(IllegalArgumentException.class);
  }
}
