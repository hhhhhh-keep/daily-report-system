package com.company.daily.statistics;

import java.time.LocalDate;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReportStatisticsQueryRepository {
  private final JdbcTemplate jdbcTemplate;

  public ReportStatisticsQueryRepository(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  public List<StatisticsEmployee> activeEmployees() {
    return jdbcTemplate.query("select id,name,team_name from employees where active order by id",
        (rs, row) -> new StatisticsEmployee(rs.getLong("id"), rs.getString("name"),
            rs.getString("team_name")));
  }

  public List<StatisticsSubmission> submittedReports(LocalDate date) {
    return jdbcTemplate.query("select employee_id,submitted_at from daily_reports "
            + "where report_date=? and status='submitted' order by employee_id",
        (rs, row) -> new StatisticsSubmission(rs.getLong("employee_id"),
            rs.getTimestamp("submitted_at").toInstant()), date);
  }
}
