package com.company.daily.metrics;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.contains;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.jdbc.core.JdbcTemplate;

class MetricsServiceTest {
  @Test
  void calculates1730RateFromFirstSubmissionTimeWithoutWaitingForSnapshot() {
    LocalDate date = LocalDate.of(2026, 8, 19);
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    when(jdbcTemplate.queryForObject("select count(*) from employees where active", Integer.class)).thenReturn(2);
    when(jdbcTemplate.queryForObject(contains("where report_date = ?"), eq(Integer.class), eq(date)))
        .thenReturn(2);
    when(jdbcTemplate.queryForObject(contains("submitted_at <= ?"), eq(Integer.class), eq(date),
        org.mockito.ArgumentMatchers.any(Timestamp.class))).thenReturn(1);

    DashboardMetricsResponse metrics = new MetricsService(jdbcTemplate).dashboard(date);

    assertThat(metrics.progress1730SubmittedCount()).isEqualTo(1);
    assertThat(metrics.progress1730MissingCount()).isEqualTo(1);
    assertThat(metrics.progress1730Rate()).isEqualByComparingTo("50.00");
    ArgumentCaptor<Timestamp> cutoff = ArgumentCaptor.forClass(Timestamp.class);
    verify(jdbcTemplate).queryForObject(contains("submitted_at <= ?"), eq(Integer.class), eq(date), cutoff.capture());
    assertThat(cutoff.getValue().toInstant()).isEqualTo(Instant.parse("2026-08-19T09:30:00Z"));
  }
}
