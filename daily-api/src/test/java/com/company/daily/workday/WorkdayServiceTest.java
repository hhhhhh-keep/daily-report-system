package com.company.daily.workday;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.time.LocalDate;
import java.util.List;
import org.junit.jupiter.api.Test;

class WorkdayServiceTest {
  private final WorkdayCalendarRepository repository = mock(WorkdayCalendarRepository.class);
  private final WorkdayService service = new WorkdayService(repository);

  @Test
  void administratorWorkdayOverrideTakesPrecedenceOverWeekend() {
    LocalDate saturday = LocalDate.of(2026, 8, 15);
    when(repository.findAllByCalendarDateAndActiveTrue(saturday))
        .thenReturn(List.of(WorkdayCalendar.administratorOverride(saturday, true, "周末补班")));

    assertThat(service.isWorkday(saturday)).isTrue();
  }

  @Test
  void administratorRestDayOverrideTakesPrecedenceOverDefaultWeekday() {
    LocalDate monday = LocalDate.of(2026, 8, 17);
    when(repository.findAllByCalendarDateAndActiveTrue(monday))
        .thenReturn(List.of(WorkdayCalendar.administratorOverride(monday, false, "公司调休")));

    assertThat(service.isWorkday(monday)).isFalse();
  }

  @Test
  void importedHolidayTakesPrecedenceWhenThereIsNoAdministratorOverride() {
    LocalDate monday = LocalDate.of(2026, 10, 5);
    when(repository.findAllByCalendarDateAndActiveTrue(monday))
        .thenReturn(List.of(WorkdayCalendar.imported(monday, false,
            WorkdaySource.LEGAL_HOLIDAY, "国庆节")));

    assertThat(service.isWorkday(monday)).isFalse();
  }

  @Test
  void fallsBackToMondayThroughFridayWhenCalendarHasNoRecord() {
    when(repository.findAllByCalendarDateAndActiveTrue(LocalDate.of(2026, 8, 14)))
        .thenReturn(List.of());
    when(repository.findAllByCalendarDateAndActiveTrue(LocalDate.of(2026, 8, 15)))
        .thenReturn(List.of());

    assertThat(service.isWorkday(LocalDate.of(2026, 8, 14))).isTrue();
    assertThat(service.isWorkday(LocalDate.of(2026, 8, 15))).isFalse();
  }
}
