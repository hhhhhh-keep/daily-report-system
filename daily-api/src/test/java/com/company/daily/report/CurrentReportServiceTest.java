package com.company.daily.report;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.company.daily.report.api.dto.CurrentReportRequest;
import com.company.daily.report.api.dto.CurrentTaskRequest;
import com.company.daily.report.service.CurrentReportService;
import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest
class CurrentReportServiceTest extends PostgresIntegrationTest {
  @Autowired private CurrentReportService service;
  @Autowired private JdbcTemplate jdbcTemplate;

  private long employeeId;
  private long projectId;

  @BeforeEach
  void insertReferences() {
    jdbcTemplate.update("delete from project_state_snapshots");
    jdbcTemplate.update("delete from project_state_events");
    jdbcTemplate.update("delete from project_derived_states");
    jdbcTemplate.update("delete from daily_tasks");
    jdbcTemplate.update("delete from daily_reports");
    jdbcTemplate.update("delete from projects where code='SERVICE-TEST'");
    jdbcTemplate.update("delete from employees");
    jdbcTemplate.update("insert into workday_calendar(calendar_date,workday,source,note,active) "
        + "values (?,true,'ADMIN_OVERRIDE','integration test',true) "
        + "on conflict (calendar_date,source) do update set workday=true,active=true",
        LocalDate.now());
    employeeId = jdbcTemplate.queryForObject(
        "insert into employees(name, team_name, position_type, active) "
            + "values ('服务测试员工', '测试组', '顾问', true) returning id",
        Long.class);
    projectId = jdbcTemplate.queryForObject(
        "insert into projects(name, project_stage, priority, status, code, formal, active) "
            + "values ('服务测试项目', 'delivery', 'high', 'active', 'SERVICE-TEST', true, true) "
            + "returning id",
        Long.class);
  }

  @Test
  void supportsMoreThanSixTasksAndRollsBackAnInvalidReplacement() {
    List<CurrentTaskRequest> sevenTasks = new ArrayList<>();
    for (int index = 1; index <= 7; index++) {
      sevenTasks.add(validTask("任务 " + index));
    }
    service.save(new CurrentReportRequest(
        employeeId, LocalDate.now(), "present", "七项任务", sevenTasks));

    assertThat(jdbcTemplate.queryForObject("select count(*) from daily_reports", Integer.class))
        .isEqualTo(1);
    assertThat(jdbcTemplate.queryForObject("select count(*) from daily_tasks", Integer.class))
        .isEqualTo(7);

    CurrentTaskRequest invalidRisk = new CurrentTaskRequest(
        "afternoon", projectId, "special-work", null, "owner", "风险任务", "blocked", null, null, null);
    assertThatThrownBy(() -> service.save(new CurrentReportRequest(
        employeeId,
        nextWorkday(),
        "present",
        "不应保存",
        List.of(validTask("替换任务"), invalidRisk))))
        .isInstanceOf(IllegalArgumentException.class);

    assertThat(jdbcTemplate.queryForObject("select count(*) from daily_reports", Integer.class))
        .isEqualTo(1);
    assertThat(jdbcTemplate.queryForObject("select count(*) from daily_tasks", Integer.class))
        .isEqualTo(7);
    assertThat(jdbcTemplate.queryForObject("select note from daily_reports", String.class))
        .isEqualTo("七项任务");
  }

  @Test
  void rejectsMorningWorkWhenEmployeeTakesMorningLeave() {
    assertThatThrownBy(() -> service.save(new CurrentReportRequest(
        employeeId, LocalDate.now(), "leave-morning", null, List.of(validTask("上午请假仍填上午工作")))))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessageContaining("afternoon");
  }

  private CurrentTaskRequest validTask(String result) {
    return new CurrentTaskRequest(
        "morning",
        projectId,
        "project-support",
        "delivery-implementation",
        "owner",
        result,
        "in-progress",
        null,
        null,
        null);
  }

  private LocalDate nextWorkday() {
    LocalDate date = LocalDate.now();
    while (date.getDayOfWeek().getValue() > 5) {
      date = date.plusDays(1);
    }
    return date;
  }
}
