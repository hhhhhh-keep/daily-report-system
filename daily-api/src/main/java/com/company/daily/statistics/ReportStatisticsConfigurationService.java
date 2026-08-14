package com.company.daily.statistics;

import org.quartz.CronExpression;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReportStatisticsConfigurationService {
  private final JdbcTemplate jdbcTemplate;

  public ReportStatisticsConfigurationService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional(readOnly = true)
  public ReportStatisticsConfiguration get() {
    return jdbcTemplate.queryForObject("select * from report_statistics_configurations where id=1",
        (rs, row) -> new ReportStatisticsConfiguration(rs.getBoolean("early_snapshot_enabled"),
            rs.getString("early_snapshot_cron_expression"), rs.getBoolean("final_snapshot_enabled"),
            rs.getString("final_snapshot_cron_expression")));
  }

  @Transactional
  public ReportStatisticsConfiguration update(ReportStatisticsConfigurationRequest request) {
    String earlyCron = validCron(request.earlySnapshotCronExpression());
    String finalCron = validCron(request.finalSnapshotCronExpression());
    jdbcTemplate.update("update report_statistics_configurations set early_snapshot_enabled=?,"
            + "early_snapshot_cron_expression=?,final_snapshot_enabled=?,"
            + "final_snapshot_cron_expression=?,updated_at=current_timestamp where id=1",
        request.earlySnapshotEnabled(), earlyCron, request.finalSnapshotEnabled(), finalCron);
    return get();
  }

  private String validCron(String value) {
    String cron = value.trim();
    if (!CronExpression.isValidExpression(cron)) {
      throw new IllegalArgumentException("Invalid Quartz cron expression");
    }
    return cron;
  }
}
