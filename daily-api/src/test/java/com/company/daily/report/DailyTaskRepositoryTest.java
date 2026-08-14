package com.company.daily.report;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.masterdata.domain.Employee;
import com.company.daily.masterdata.domain.Project;
import com.company.daily.masterdata.repository.EmployeeRepository;
import com.company.daily.masterdata.repository.ProjectRepository;
import com.company.daily.report.domain.CurrentStatus;
import com.company.daily.report.domain.DailyReport;
import com.company.daily.report.domain.DailyTask;
import com.company.daily.report.domain.ParticipationRole;
import com.company.daily.report.domain.TimePeriod;
import com.company.daily.report.repository.DailyReportRepository;
import com.company.daily.report.repository.DailyTaskRepository;
import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest
class DailyTaskRepositoryTest extends PostgresIntegrationTest {
  @Autowired private DailyReportRepository reportRepository;
  @Autowired private DailyTaskRepository taskRepository;
  @Autowired private EmployeeRepository employeeRepository;
  @Autowired private ProjectRepository projectRepository;
  @Autowired private JdbcTemplate jdbcTemplate;

  @Test
  void mapsTaskReferencesAndApprovedEnumValues() {
    long employeeId = jdbcTemplate.queryForObject(
        "insert into employees(name, team_name, position_type, active) "
            + "values ('任务测试员工', '测试组', '顾问', true) returning id",
        Long.class);
    long projectId = jdbcTemplate.queryForObject(
        "insert into projects(name, project_stage, priority, status, formal, active) "
            + "values ('任务测试项目', 'delivery', 'high', 'active', true, true) returning id",
        Long.class);
    Employee employee = employeeRepository.findById(employeeId).orElseThrow();
    Project project = projectRepository.findById(projectId).orElseThrow();
    DailyReport report = reportRepository.saveAndFlush(
        DailyReport.create(employee, LocalDate.now(), "present", null));

    taskRepository.saveAndFlush(DailyTask.create(
        report,
        project,
        TimePeriod.FULL_DAY,
        "delivery",
        ParticipationRole.TEMPORARY_SUPPORT,
        "完成任务",
        CurrentStatus.COMPLETED,
        null,
        null,
        null));

    assertThat(taskRepository.findAllByReportIdOrderById(report.getId()))
        .singleElement()
        .satisfies(task -> {
          assertThat(task.getTimePeriod()).isEqualTo(TimePeriod.FULL_DAY);
          assertThat(task.getParticipationRole()).isEqualTo(ParticipationRole.TEMPORARY_SUPPORT);
          assertThat(task.getProject().getId()).isEqualTo(projectId);
        });
  }
}
