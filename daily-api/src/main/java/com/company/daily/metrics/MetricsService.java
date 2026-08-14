package com.company.daily.metrics;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MetricsService {
  private final JdbcTemplate jdbcTemplate;

  public MetricsService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional(readOnly = true)
  public DashboardMetricsResponse dashboard(LocalDate date) {
    int employees = count("select count(*) from employees where active", date, false);
    int reports = count("select count(*) from daily_reports where report_date = ?", date, true);
    int tasks = count(
        "select count(*) from daily_tasks t join daily_reports r on r.id=t.report_id "
            + "where r.report_date = ?", date, true);
    int projects = count(
        "select count(distinct t.project_id) from daily_tasks t join daily_reports r "
            + "on r.id=t.report_id where r.report_date = ?", date, true);
    int abnormal = count(
        "select count(*) from daily_tasks t join daily_reports r on r.id=t.report_id "
            + "where r.report_date = ? and t.current_status in ('at-risk','blocked')", date, true);
    int morning = count(
        "select count(*) from daily_tasks t join daily_reports r on r.id=t.report_id "
            + "where r.report_date = ? and t.time_period in ('morning','full-day')", date, true);
    int afternoon = count(
        "select count(*) from daily_tasks t join daily_reports r on r.id=t.report_id "
            + "where r.report_date = ? and t.time_period in ('afternoon','full-day')", date, true);
    BigDecimal rate = employees == 0 ? BigDecimal.ZERO : BigDecimal.valueOf(reports)
        .multiply(BigDecimal.valueOf(100)).divide(BigDecimal.valueOf(employees), 2, RoundingMode.HALF_UP);
    Map<String, Object> progress = jdbcTemplate.query("select submitted_count,missing_count,submission_rate "
        + "from report_statistics_snapshots where snapshot_date=? and snapshot_type='PROGRESS_1730'",
        resultSet -> resultSet.next() ? Map.of("submitted", resultSet.getInt(1), "missing", resultSet.getInt(2),
            "rate", resultSet.getBigDecimal(3).multiply(BigDecimal.valueOf(100))) : Map.of(), date);
    return new DashboardMetricsResponse(date, employees, reports, Math.max(0, employees - reports),
        tasks, projects, abnormal, morning, afternoon, rate,
        (BigDecimal) progress.getOrDefault("rate", BigDecimal.ZERO),
        (Integer) progress.getOrDefault("submitted", 0), (Integer) progress.getOrDefault("missing", 0));
  }

  private int count(String sql, LocalDate date, boolean usesDate) {
    Integer result = usesDate
        ? jdbcTemplate.queryForObject(sql, Integer.class, date)
        : jdbcTemplate.queryForObject(sql, Integer.class);
    return result == null ? 0 : result;
  }
}
