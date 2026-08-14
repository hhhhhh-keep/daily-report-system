package com.company.daily.workday;

public enum WorkdaySource {
  ADMIN_OVERRIDE(2),
  LEGAL_HOLIDAY(1),
  MAKE_UP_WORKDAY(1),
  COMPANY_WORKDAY(1),
  COMPANY_REST_DAY(1);

  private final int priority;

  WorkdaySource(int priority) {
    this.priority = priority;
  }

  int priority() {
    return priority;
  }
}
