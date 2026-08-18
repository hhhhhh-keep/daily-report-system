package com.company.daily.analysis;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import tools.jackson.databind.ObjectMapper;

class AnalysisSourceSnapshotServiceTest {
  @Test
  void includesRosterReportsAndTaskFieldsRequiredByScriptedSkills() {
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    List<String> executedSql = new ArrayList<>();
    when(jdbcTemplate.queryForList(anyString())).thenAnswer(invocation -> {
      String sql = invocation.getArgument(0);
      executedSql.add(sql);
      return List.of();
    });
    when(jdbcTemplate.queryForList(anyString(), any(Object[].class))).thenAnswer(invocation -> {
      String sql = invocation.getArgument(0);
      executedSql.add(sql);
      if (sql.contains("from employees")) {
        return List.of(Map.of("employee_id", 1, "employee_name", "张三", "team_name", "交付组",
            "position_type", "自有"));
      }
      if (sql.contains("from daily_reports r") && !sql.contains("daily_tasks")) {
        return List.of(Map.of("report_id", 2, "report_date", LocalDate.of(2026, 7, 31), "employee_id", 1,
            "attendance_status", "present", "note", "完成日报", "status", "submitted"));
      }
      if (sql.contains("from workday_calendar")) {
        return List.of(
            Map.of("calendar_date", LocalDate.of(2026, 7, 27), "workday", true),
            Map.of("calendar_date", LocalDate.of(2026, 7, 28), "workday", true),
            Map.of("calendar_date", LocalDate.of(2026, 7, 29), "workday", true),
            Map.of("calendar_date", LocalDate.of(2026, 7, 30), "workday", true),
            Map.of("calendar_date", LocalDate.of(2026, 7, 31), "workday", true));
      }
      if (sql.contains("from project_state_snapshots")) {
        return List.of(Map.ofEntries(
            Map.entry("snapshot_date", LocalDate.of(2026, 7, 31)),
            Map.entry("captured_at", "2026-08-14T10:00:00+08:00"),
            Map.entry("project_id", 31), Map.entry("project_name", "A项目"),
            Map.entry("state", "DELIVERY_IN_PROGRESS"), Map.entry("current_stage", "implementation"),
            Map.entry("owner_name", "李经理"), Map.entry("formal", true),
            Map.entry("active", true), Map.entry("status", "active"), Map.entry("priority", "high")));
      }
      return List.of();
    });
    AnalysisSourceSnapshotService service = new AnalysisSourceSnapshotService(jdbcTemplate, new ObjectMapper());
    AnalysisPeriodWindow window = new AnalysisPeriodWindow(AnalysisPeriod.DAILY, LocalDate.of(2026, 7, 31),
        LocalDate.of(2026, 7, 31));

    String snapshot = service.build(window);

    assertThat(snapshot).contains("\"roster\"").contains("\"reports\"")
        .contains("\"reportDate\":\"2026-07-31\"")
        .contains("\"coverageStart\":\"2026-07-31\"")
        .contains("\"coverageEnd\":\"2026-07-31\"")
        .contains("\"employee_name\":\"张三\"").contains("\"report_id\":2")
        .contains("\"projectStates\"").contains("\"captured_at\"")
        .contains("\"formal\":true").contains("\"priority\":\"high\"");
    assertThat(executedSql).anySatisfy(sql -> assertThat(sql)
        .contains("s.captured_at").contains("p.formal").contains("p.priority").contains("p.active=true"));
    assertThat(executedSql).anySatisfy(sql -> assertThat(sql)
        .contains("from daily_tasks t").contains("p.active=true"));
    assertThat(executedSql).anySatisfy(sql -> assertThat(sql)
        .contains("from employees e").contains("e.active=true or exists")
        .contains("r.report_date between ? and ?"));
  }

  @Test
  void fallsBackToWeekdaysWhenConfiguredCalendarHasFewerThanFiveWorkdays() {
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    when(jdbcTemplate.queryForList(anyString(), any(Object[].class))).thenAnswer(invocation -> {
      String sql = invocation.getArgument(0);
      if (sql.contains("from workday_calendar")) {
        return List.of(
            Map.of("calendar_date", LocalDate.of(2026, 1, 4), "workday", true),
            Map.of("calendar_date", LocalDate.of(2026, 2, 14), "workday", true),
            Map.of("calendar_date", LocalDate.of(2026, 2, 28), "workday", true),
            Map.of("calendar_date", LocalDate.of(2026, 5, 9), "workday", true));
      }
      return List.of();
    });
    AnalysisSourceSnapshotService service = new AnalysisSourceSnapshotService(jdbcTemplate, new ObjectMapper());

    String snapshot = service.build(new AnalysisPeriodWindow(AnalysisPeriod.DAILY,
        LocalDate.of(2026, 7, 31), LocalDate.of(2026, 7, 31)));

    assertThat(snapshot).contains("\"coverageStart\":\"2026-07-31\"");
  }
}
