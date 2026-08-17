package com.company.daily.migration;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest(properties = "spring.quartz.auto-startup=false")
class MigrationVerificationTest extends PostgresIntegrationTest {
  @Autowired JdbcTemplate jdbcTemplate;

  @Test
  void appliesMigrationsInOrderAndEnforcesCoreUniquenessAndIdempotency() {
    List<String> versions = jdbcTemplate.queryForList(
        "select version from flyway_schema_history where success order by installed_rank", String.class);
    assertThat(versions).containsExactly(
        "001", "002", "003", "004", "005", "006", "007", "008", "009", "010",
        "011", "012", "013", "014", "015", "016", "017", "018", "019", "020",
        "021", "022", "023");

    long employee = jdbcTemplate.queryForObject("insert into employees(name,team_name,position_type) "
        + "values ('迁移员工','迁移组','顾问') returning id", Long.class);
    LocalDate date = LocalDate.of(2026, 8, 10);
    jdbcTemplate.update("insert into daily_reports(report_date,employee_id,attendance_status,status,"
        + "submitted_at) values (?,?,'full-day','submitted',current_timestamp)", date, employee);
    assertThatThrownBy(() -> jdbcTemplate.update("insert into daily_reports(report_date,employee_id,"
        + "attendance_status,status,submitted_at) values (?,?,'full-day','submitted',current_timestamp)",
        date, employee)).isInstanceOf(DataIntegrityViolationException.class);

    assertThatThrownBy(() -> jdbcTemplate.update("insert into administrators(id,username,password_hash) "
        + "values (2,'another-admin','not-used')"))
        .isInstanceOf(DataIntegrityViolationException.class);

    long firstRun = run(date);
    long secondRun = run(date);
    jdbcTemplate.update("insert into email_deliveries(run_id,analysis_date,status) values (?,?,'sent')",
        firstRun, date);
    jdbcTemplate.update(
        "insert into email_deliveries(run_id,analysis_date,status) values (?,?,'sent')", secondRun, date);
    assertThat(jdbcTemplate.queryForObject(
        "select count(*) from email_deliveries where analysis_date=? and status='sent'",
        Integer.class, date)).isEqualTo(2);
  }

  private long run(LocalDate date) {
    return jdbcTemplate.queryForObject("insert into analysis_runs(analysis_date,trigger_type,status,"
        + "selected_dimensions,started_at) values (?,'manual','succeeded','project-risk',"
        + "current_timestamp) returning id", Long.class, date);
  }
}
