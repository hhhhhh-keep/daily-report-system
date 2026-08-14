package com.company.daily.workday;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WorkdayCalendarRepository extends JpaRepository<WorkdayCalendar, Long> {
  List<WorkdayCalendar> findAllByCalendarDateAndActiveTrue(LocalDate calendarDate);

  Optional<WorkdayCalendar> findByCalendarDateAndSource(
      LocalDate calendarDate, WorkdaySource source);

  List<WorkdayCalendar> findAllByCalendarDateBetweenOrderByCalendarDateAscSourceAsc(
      LocalDate startDate, LocalDate endDate);
}
