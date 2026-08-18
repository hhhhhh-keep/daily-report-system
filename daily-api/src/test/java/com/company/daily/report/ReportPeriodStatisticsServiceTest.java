package com.company.daily.report;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.report.api.dto.PersonReportPeriodStatistics;
import com.company.daily.report.api.dto.ReportPeriodStatisticsResponse;
import com.company.daily.report.service.ReportPeriodStatisticsService;
import com.company.daily.support.PostgresIntegrationTest;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest
class ReportPeriodStatisticsServiceTest extends PostgresIntegrationTest {
  @Autowired JdbcTemplate jdbcTemplate;
  @Autowired ReportPeriodStatisticsService service;

  @Test
  void aggregatesEarlyMissingLeaveAndTrainingWithoutTreatingModificationAsLate() {
    LocalDate monday = LocalDate.of(2026, 8, 10);
    LocalDate tuesday = monday.plusDays(1);
    workday(monday);
    workday(tuesday);
    nonWorkday(monday.plusDays(2));
    nonWorkday(monday.plusDays(3));
    nonWorkday(monday.plusDays(4));
    long employeeA = employee("周期统计员工甲");
    long employeeB = employee("周期统计员工乙");

    report(employeeA, monday, "present", "2026-08-10T09:00:00Z", "2026-08-10T12:00:00Z");
    report(employeeA, tuesday, "training", "2026-08-11T10:00:00Z", "2026-08-11T10:00:00Z");
    report(employeeB, monday, "leave-morning", "2026-08-10T08:00:00Z", "2026-08-10T08:00:00Z");

    ReportPeriodStatisticsResponse result = service.statistics("WEEKLY", monday);

    assertThat(result.periodStart()).isEqualTo(monday);
    assertThat(result.periodEnd()).isEqualTo(monday.plusDays(6));
    assertThat(result.workdayCount()).isEqualTo(2);
    assertThat(result.coverageMode()).isEqualTo("CURRENT_ROSTER_FALLBACK");

    PersonReportPeriodStatistics first = person(result, employeeA);
    assertThat(first.expectedReportCount()).isEqualTo(2);
    assertThat(first.earlySubmittedCount()).isEqualTo(1);
    assertThat(first.missingCount()).isZero();
    assertThat(first.leaveOccurrences()).isZero();
    assertThat(first.leaveEquivalentDays()).isEqualByComparingTo(BigDecimal.ZERO);
    assertThat(first.trainingCount()).isEqualTo(1);

    PersonReportPeriodStatistics second = person(result, employeeB);
    assertThat(second.expectedReportCount()).isEqualTo(2);
    assertThat(second.earlySubmittedCount()).isEqualTo(1);
    assertThat(second.missingCount()).isEqualTo(1);
    assertThat(second.leaveOccurrences()).isEqualTo(1);
    assertThat(second.leaveEquivalentDays()).isEqualByComparingTo("0.5");
    assertThat(second.trainingCount()).isZero();
  }

  @Test
  void countsOrdinaryWeekdaysWhenCalendarHasNoExplicitRows() {
    LocalDate monday = LocalDate.of(2026, 8, 3);
    long employeeId = employee("默认工作日员工");

    ReportPeriodStatisticsResponse result = service.statistics("WEEKLY", monday);

    assertThat(result.workdayCount()).isEqualTo(5);
    assertThat(person(result, employeeId).expectedReportCount()).isEqualTo(5);
  }

  @Test
  void aggregatesAnInclusiveCustomRange() {
    LocalDate start = LocalDate.of(2026, 8, 3);
    long employeeId = employee("自选周期员工");
    workday(start);
    workday(start.plusDays(1));
    nonWorkday(start.plusDays(2));

    ReportPeriodStatisticsResponse result = service.statistics(start, start.plusDays(2));

    assertThat(result.period()).isEqualTo("CUSTOM");
    assertThat(result.periodStart()).isEqualTo(start);
    assertThat(result.periodEnd()).isEqualTo(start.plusDays(2));
    assertThat(result.workdayCount()).isEqualTo(2);
    assertThat(person(result, employeeId).expectedReportCount()).isEqualTo(2);
  }
  private PersonReportPeriodStatistics person(ReportPeriodStatisticsResponse result, long employeeId) {
    return result.people().stream().filter(item -> item.employeeId() == employeeId).findFirst().orElseThrow();
  }

  private long employee(String name) {
    return jdbcTemplate.queryForObject("insert into employees(name,team_name,position_type,active) "
        + "values (?, '周期统计组', '顾问', true) returning id", Long.class, name);
  }

  private void workday(LocalDate date) {
    jdbcTemplate.update("insert into workday_calendar(calendar_date,workday,source,note,active) "
        + "values (?,true,'ADMIN_OVERRIDE','period statistics test',true) "
        + "on conflict(calendar_date,source) do update set workday=true,active=true", date);
  }

  private void nonWorkday(LocalDate date) {
    jdbcTemplate.update("insert into workday_calendar(calendar_date,workday,source,note,active) "
        + "values (?,false,'ADMIN_OVERRIDE','period statistics test',true) "
        + "on conflict(calendar_date,source) do update set workday=false,active=true", date);
  }
  private void report(long employeeId, LocalDate date, String attendance,
      String submittedAt, String updatedAt) {
    jdbcTemplate.update("insert into daily_reports(report_date,employee_id,attendance_status,status,"
        + "submitted_at,updated_at) values (?,? ,?,'submitted',?::timestamptz,?::timestamptz)",
        date, employeeId, attendance, submittedAt, updatedAt);
  }
}
