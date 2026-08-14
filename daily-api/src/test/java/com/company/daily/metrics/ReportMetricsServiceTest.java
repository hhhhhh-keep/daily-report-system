package com.company.daily.metrics;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest
class ReportMetricsServiceTest extends PostgresIntegrationTest {
  @Autowired JdbcTemplate jdbcTemplate;
  @Autowired ReportMetricsService service;

  @Test
  void calculatesCompletenessTaskProjectPeriodTrendAndCollaborationMetrics() {
    long employeeOne = employee("指标员工甲");
    long employeeTwo = employee("指标员工乙");
    employee("未填写员工");
    long projectOne = project("指标项目甲", "METRIC-A");
    long projectTwo = project("指标项目乙", "METRIC-B");
    LocalDate date = LocalDate.of(2026, 8, 10);

    for (int offset = 2; offset >= 0; offset--) {
      LocalDate day = date.minusDays(offset);
      long report = report(employeeOne, day);
      task(report, projectOne, "morning", "temporary-support", "持续支撑交付",
          offset == 0 ? "at-risk" : "progressing");
      task(report, projectOne, "afternoon", "owner", "等待客户反馈", "waiting-feedback");
    }
    long secondReport = report(employeeTwo, date);
    task(secondReport, projectOne, "morning", "collaborator", "协同项目甲", "completed");
    task(secondReport, projectTwo, "afternoon", "owner", "短", "completed");
    task(report(employeeOne, date), projectTwo, "fragmented", "owner", "并行项目乙", "blocked");

    ReportMetrics metrics = service.calculate(date, 4);

    assertThat(metrics.activeEmployeeCount()).isEqualTo(3);
    assertThat(metrics.submittedReportCount()).isEqualTo(2);
    assertThat(metrics.missingReportCount()).isEqualTo(1);
    assertThat(metrics.taskCount()).isEqualTo(5);
    assertThat(metrics.projectCount()).isEqualTo(2);
    assertThat(metrics.morningTaskCount()).isEqualTo(2);
    assertThat(metrics.afternoonTaskCount()).isEqualTo(2);
    assertThat(metrics.abnormalTaskCount()).isEqualTo(2);
    assertThat(metrics.waitingFeedbackTaskCount()).isEqualTo(1);
    assertThat(metrics.vagueTaskCount()).isEqualTo(1);
    assertThat(metrics.multiProjectEmployeeCount()).isEqualTo(2);
    assertThat(metrics.multiPersonProjectCount()).isEqualTo(2);
    assertThat(metrics.maxConsecutiveSupportDays()).isEqualTo(3);
    assertThat(metrics.maxConsecutiveWaitingFeedbackDays()).isEqualTo(3);
  }

  private long employee(String name) {
    return jdbcTemplate.queryForObject("insert into employees(name,team_name,position_type) "
        + "values (?, '指标组', '顾问') returning id", Long.class, name);
  }

  private long project(String name, String code) {
    return jdbcTemplate.queryForObject("insert into projects(name,status,code,formal,active) "
        + "values (?, 'active', ?, true, true) returning id", Long.class, name, code);
  }

  private long report(long employeeId, LocalDate date) {
    Long existing = jdbcTemplate.query("select id from daily_reports where employee_id=? and report_date=?",
        rs -> rs.next() ? rs.getLong(1) : null, employeeId, date);
    return existing != null ? existing : jdbcTemplate.queryForObject("insert into daily_reports"
        + "(report_date,employee_id,attendance_status,status,submitted_at) "
        + "values (?,?,'full-day','submitted',current_timestamp) returning id",
        Long.class, date, employeeId);
  }

  private void task(
      long reportId, long projectId, String period, String role, String result, String status) {
    jdbcTemplate.update("insert into daily_tasks(report_id,time_period,project_id,work_type,"
        + "participation_role,progress_result,current_status) values (?,?,?,'delivery',?,?,?)",
        reportId, period, projectId, role, result, status);
  }
}
