package com.company.daily.report.domain;

import java.util.Arrays;

public enum ParticipationRole {
  OWNER("owner"),
  COLLABORATOR("collaborator"),
  TEMPORARY_SUPPORT("temporary-support");

  private final String value;

  ParticipationRole(String value) {
    this.value = value;
  }

  public String value() {
    return value;
  }

  public static ParticipationRole fromValue(String value) {
    return Arrays.stream(values())
        .filter(candidate -> candidate.value.equals(value))
        .findFirst()
        .orElseThrow(() -> new IllegalArgumentException("无效的参与角色: " + value));
  }
}
