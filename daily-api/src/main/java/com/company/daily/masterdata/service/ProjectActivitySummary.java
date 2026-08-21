package com.company.daily.masterdata.service;

import java.time.LocalDate;
import java.util.List;

record ProjectActivitySummary(
    int participantCount,
    LocalDate latestReportDate,
    int completedCount,
    int inProgressCount,
    int blockedOrPausedCount) {

  record Item(long employeeId, LocalDate reportDate, String currentStatus) {}

  static ProjectActivitySummary from(List<Item> items) {
    int completed = 0;
    int inProgress = 0;
    int blockedOrPaused = 0;
    for (Item item : items) {
      switch (item.currentStatus()) {
        case "completed" -> completed++;
        case "blocked", "paused" -> blockedOrPaused++;
        default -> inProgress++;
      }
    }
    return new ProjectActivitySummary(
        (int) items.stream().map(Item::employeeId).distinct().count(),
        items.stream().map(Item::reportDate).max(LocalDate::compareTo).orElse(null),
        completed, inProgress, blockedOrPaused);
  }
}
