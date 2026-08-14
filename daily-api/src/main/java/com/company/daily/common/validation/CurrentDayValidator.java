package com.company.daily.common.validation;

import com.company.daily.workday.WorkdayService;
import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CurrentDayValidator {
  private final Clock clock;
  private final WorkdayService workdayService;

  @Autowired
  public CurrentDayValidator(WorkdayService workdayService) {
    this(Clock.system(ZoneId.of("Asia/Shanghai")), workdayService);
  }

  CurrentDayValidator(Clock clock) {
    this.clock = clock;
    this.workdayService = null;
  }

  CurrentDayValidator(Clock clock, WorkdayService workdayService) {
    this.clock = clock;
    this.workdayService = workdayService;
  }

  public void requireToday(LocalDate reportDate) {
    if (!LocalDate.now(clock).equals(reportDate)) {
      throw new IllegalArgumentException("仅允许提交或修改当天日报");
    }
  }

  public void requireSubmittableDate(LocalDate reportDate) {
    LocalDate today = LocalDate.now(clock);
    if (reportDate.isBefore(today)) {
      throw new IllegalArgumentException("Past daily reports cannot be changed");
    }
    if (workdayService == null || !workdayService.isWorkday(reportDate)) {
      throw new IllegalArgumentException("Daily reports can only be submitted for workdays");
    }
  }
}
