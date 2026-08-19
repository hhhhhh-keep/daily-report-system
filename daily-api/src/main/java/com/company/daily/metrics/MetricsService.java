package com.company.daily.metrics;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MetricsService {
  private static final ZoneId CHINA_ZONE = ZoneId.of("Asia/Shanghai");
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
    int progressSubmitted = progress1730SubmittedCount(date);
    int progressMissing = Math.max(0, employees - progressSubmitted);
    BigDecimal progressRate = employees == 0 ? BigDecimal.ZERO : BigDecimal.valueOf(progressSubmitted)
        .multiply(BigDecimal.valueOf(100)).divide(BigDecimal.valueOf(employees), 2, RoundingMode.HALF_UP);
    return new DashboardMetricsResponse(date, employees, reports, Math.max(0, employees - reports),
        tasks, projects, abnormal, morning, afternoon, rate,
        progressRate, progressSubmitted, progressMissing);
  }

  private int progress1730SubmittedCount(LocalDate date) {
    Instant cutoff = date.atTime(17, 30).atZone(CHINA_ZONE).toInstant();
    Integer result = jdbcTemplate.queryForObject(
        "select count(*) from daily_reports where report_date=? and status='submitted' and submitted_at <= ?",
        Integer.class, date, Timestamp.from(cutoff));
    return result == null ? 0 : result;
  }

  private int count(String sql, LocalDate date, boolean usesDate) {
    Integer result = usesDate
        ? jdbcTemplate.queryForObject(sql, Integer.class, date)
        : jdbcTemplate.queryForObject(sql, Integer.class);
    return result == null ? 0 : result;
  }
}
