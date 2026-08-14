package com.company.daily.analysis;

import com.company.daily.workday.WorkdayService;
import java.time.DayOfWeek;
import java.time.LocalDate;
import org.springframework.stereotype.Service;

@Service
public class AnalysisPeriodWindowService {
  private final WorkdayService workdayService;

  public AnalysisPeriodWindowService(WorkdayService workdayService) {
    this.workdayService = workdayService;
  }

  public AnalysisPeriodWindow resolve(AnalysisPeriod period, LocalDate date) {
    if (!workdayService.isWorkday(date)) {
      throw new IllegalArgumentException("Analysis windows can only end on workdays");
    }
    return switch (period) {
      case DAILY -> new AnalysisPeriodWindow(period, date, date);
      case WEEKLY -> weekly(date);
      case MONTHLY -> monthly(date);
    };
  }

  public boolean isScheduledEnd(AnalysisPeriod period, LocalDate date) {
    if (!workdayService.isWorkday(date)) {
      return false;
    }
    return switch (period) {
      case DAILY -> true;
      case WEEKLY -> date.equals(lastWorkday(date.with(DayOfWeek.SUNDAY)));
      case MONTHLY -> date.equals(lastWorkday(date.withDayOfMonth(date.lengthOfMonth())));
    };
  }

  private AnalysisPeriodWindow weekly(LocalDate date) {
    LocalDate start = date.with(DayOfWeek.MONDAY);
    return new AnalysisPeriodWindow(AnalysisPeriod.WEEKLY, start, date);
  }

  private AnalysisPeriodWindow monthly(LocalDate date) {
    return new AnalysisPeriodWindow(AnalysisPeriod.MONTHLY, date.withDayOfMonth(1), date);
  }

  private LocalDate lastWorkday(LocalDate date) {
    LocalDate candidate = date;
    while (!workdayService.isWorkday(candidate)) {
      candidate = candidate.minusDays(1);
    }
    return candidate;
  }
}
