package com.company.daily.report.domain;

import java.util.Arrays;

public enum TimePeriod {
  MORNING("morning"),
  AFTERNOON("afternoon"),
  FULL_DAY("full-day"),
  FRAGMENTED("fragmented");

  private final String value;

  TimePeriod(String value) {
    this.value = value;
  }

  public String value() {
    return value;
  }

  public static TimePeriod fromValue(String value) {
    return Arrays.stream(values())
        .filter(candidate -> candidate.value.equals(value))
        .findFirst()
        .orElseThrow(() -> new IllegalArgumentException("无效的工作时段: " + value));
  }
}
