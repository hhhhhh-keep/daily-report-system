package com.company.daily.analysis;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.workday.WorkdayService;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

class AnalysisPeriodWindowServiceTest {
  @Test
  void selectsFridayAsWeeklyEndWhenItIsTheLastWorkday() {
    WorkdayService workdayService = Mockito.mock(WorkdayService.class);
    LocalDate friday = LocalDate.of(2026, 8, 14);
    Mockito.when(workdayService.isWorkday(Mockito.any())).thenAnswer(invocation -> {
      LocalDate date = invocation.getArgument(0);
      return date.getDayOfWeek().getValue() <= 5;
    });
    AnalysisPeriodWindowService service = new AnalysisPeriodWindowService(workdayService);

    assertThat(service.isScheduledEnd(AnalysisPeriod.WEEKLY, friday)).isTrue();
    assertThat(service.resolve(AnalysisPeriod.WEEKLY, friday).startDate())
        .isEqualTo(LocalDate.of(2026, 8, 10));
    assertThat(service.isScheduledEnd(AnalysisPeriod.MONTHLY, friday)).isFalse();
  }

  @Test
  void selectsTheLastWorkdayOfTheMonthForMonthlyAnalysis() {
    WorkdayService workdayService = Mockito.mock(WorkdayService.class);
    LocalDate friday = LocalDate.of(2026, 7, 31);
    Mockito.when(workdayService.isWorkday(Mockito.any())).thenAnswer(invocation -> {
      LocalDate date = invocation.getArgument(0);
      return date.getDayOfWeek().getValue() <= 5;
    });
    AnalysisPeriodWindowService service = new AnalysisPeriodWindowService(workdayService);

    assertThat(service.isScheduledEnd(AnalysisPeriod.MONTHLY, friday)).isTrue();
    assertThat(service.resolve(AnalysisPeriod.MONTHLY, friday).startDate())
        .isEqualTo(LocalDate.of(2026, 7, 1));
  }
}
