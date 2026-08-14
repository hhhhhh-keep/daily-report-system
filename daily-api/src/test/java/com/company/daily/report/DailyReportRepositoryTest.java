package com.company.daily.report;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.company.daily.masterdata.domain.Employee;
import com.company.daily.masterdata.repository.EmployeeRepository;
import com.company.daily.report.domain.DailyReport;
import com.company.daily.report.repository.DailyReportRepository;
import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest
class DailyReportRepositoryTest extends PostgresIntegrationTest {
  @Autowired private DailyReportRepository reportRepository;
  @Autowired private EmployeeRepository employeeRepository;
  @Autowired private JdbcTemplate jdbcTemplate;

  private Employee employee;

  @BeforeEach
  void insertEmployee() {
    jdbcTemplate.update("delete from daily_tasks");
    jdbcTemplate.update("delete from daily_reports");
    jdbcTemplate.update("delete from employees");
    long id = jdbcTemplate.queryForObject(
        "insert into employees(name, team_name, position_type, active) "
            + "values ('仓储测试员工', '测试组', '顾问', true) returning id",
        Long.class);
    employee = employeeRepository.findById(id).orElseThrow();
  }

  @Test
  void findsReportByEmployeeAndDate() {
    LocalDate today = LocalDate.now();
    reportRepository.saveAndFlush(DailyReport.create(employee, today, "present", "正常提交"));

    assertThat(reportRepository.findByEmployeeIdAndReportDate(employee.getId(), today))
        .get()
        .extracting(DailyReport::getNote)
        .isEqualTo("正常提交");
  }

  @Test
  void databasePreventsTwoReportsForEmployeeAndDate() {
    LocalDate today = LocalDate.now();
    reportRepository.saveAndFlush(DailyReport.create(employee, today, "present", null));

    assertThatThrownBy(() -> reportRepository.saveAndFlush(
        DailyReport.create(employee, today, "present", null)))
        .isInstanceOf(DataIntegrityViolationException.class);
  }
}
