package com.company.daily.workday;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Comparator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class WorkdayService {
  private final WorkdayCalendarRepository repository;

  public WorkdayService(WorkdayCalendarRepository repository) {
    this.repository = repository;
  }

  @Transactional(readOnly = true)
  public boolean isWorkday(LocalDate date) {
    return repository.findAllByCalendarDateAndActiveTrue(date).stream()
        .max(Comparator.comparingInt(WorkdayCalendar::priority))
        .map(WorkdayCalendar::isWorkday)
        .orElseGet(() -> isDefaultWorkday(date));
  }

  private boolean isDefaultWorkday(LocalDate date) {
    DayOfWeek day = date.getDayOfWeek();
    return day != DayOfWeek.SATURDAY && day != DayOfWeek.SUNDAY;
  }
}
