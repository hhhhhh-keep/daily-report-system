package com.company.daily.report.domain;

import java.util.Arrays;

public enum CurrentStatus {
  COMPLETED("completed"),
  STARTED("started"),
  IN_PROGRESS("in-progress"),
  BLOCKED("blocked"),
  PAUSED("paused");

  private final String value;

  CurrentStatus(String value) {
    this.value = value;
  }

  public String value() {
    return value;
  }

  public boolean requiresIssueDetails() {
    return this == BLOCKED;
  }

  public static CurrentStatus fromValue(String value) {
    return Arrays.stream(values())
        .filter(candidate -> candidate.value.equals(value))
        .findFirst()
        .orElseThrow(() -> new IllegalArgumentException("无效的当前状态: " + value));
  }
}
