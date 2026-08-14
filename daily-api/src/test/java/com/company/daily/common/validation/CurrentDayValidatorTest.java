package com.company.daily.common.validation;

import static org.assertj.core.api.Assertions.assertThatNoException;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.time.Clock;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import com.company.daily.workday.WorkdayService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

class CurrentDayValidatorTest {
  private final Clock clock =
      Clock.fixed(Instant.parse("2026-08-10T08:00:00Z"), ZoneId.of("Asia/Shanghai"));

  @Test
  void acceptsToday() {
    CurrentDayValidator validator = new CurrentDayValidator(clock);
    assertThatNoException().isThrownBy(() -> validator.requireToday(LocalDate.of(2026, 8, 10)));
  }

  @Test
  void rejectsAnyOtherDay() {
    CurrentDayValidator validator = new CurrentDayValidator(clock);
    assertThatThrownBy(() -> validator.requireToday(LocalDate.of(2026, 8, 9)))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessage("仅允许提交或修改当天日报");
  }

  @Test
  void acceptsFutureWorkdayForAdvanceEntry() {
    WorkdayService workdayService = Mockito.mock(WorkdayService.class);
    LocalDate futureWorkday = LocalDate.of(2026, 8, 11);
    Mockito.when(workdayService.isWorkday(futureWorkday)).thenReturn(true);

    CurrentDayValidator validator = new CurrentDayValidator(clock, workdayService);

    assertThatNoException().isThrownBy(() -> validator.requireSubmittableDate(futureWorkday));
  }
}
