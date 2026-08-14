package com.company.daily.masterdata.service;

import java.time.LocalDate;
import java.util.Set;

record ProjectActivityWindow(LocalDate startDate, LocalDate endDate) {
  private static final Set<Integer> SUPPORTED_DAYS = Set.of(0, 7, 30, 90);

  static ProjectActivityWindow of(LocalDate endDate, int days) {
    if (!SUPPORTED_DAYS.contains(days)) {
      throw new IllegalArgumentException("Activity window must be 7, 30, 90, or 0");
    }
    return new ProjectActivityWindow(days == 0 ? null : endDate.minusDays(days - 1), endDate);
  }
}
