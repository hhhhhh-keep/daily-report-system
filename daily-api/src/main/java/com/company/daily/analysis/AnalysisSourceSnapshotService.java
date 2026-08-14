package com.company.daily.analysis;

import java.util.LinkedHashMap;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import tools.jackson.databind.ObjectMapper;

@Service
public class AnalysisSourceSnapshotService {
  private final JdbcTemplate jdbcTemplate;
  private final ObjectMapper objectMapper;

  public AnalysisSourceSnapshotService(JdbcTemplate jdbcTemplate, ObjectMapper objectMapper) {
    this.jdbcTemplate = jdbcTemplate;
    this.objectMapper = objectMapper;
  }

  public String build(AnalysisPeriodWindow window) {
    try {
      Map<String, Object> snapshot = new LinkedHashMap<>();
      snapshot.put("period", window.period().name());
      snapshot.put("periodStart", window.startDate().toString());
      snapshot.put("periodEnd", window.endDate().toString());
      snapshot.put("statistics", jdbcTemplate.queryForList("select snapshot_type,snapshot_date,"
          + "captured_at,expected_count,submitted_count,missing_count,submission_rate,"
          + "submitted_employees_json,missing_employees_json,late_submitted_employees_json,"
          + "team_statistics_json from report_statistics_snapshots where snapshot_date between ? "
          + "and ? order by snapshot_date,snapshot_type", window.startDate(), window.endDate()));
      snapshot.put("workdays", jdbcTemplate.queryForList("select calendar_date,workday,source,note "
          + "from workday_calendar where calendar_date between ? and ? and active=true order by calendar_date",
          window.startDate(), window.endDate()));
      snapshot.put("projectStates", jdbcTemplate.queryForList("select project_id,project_name,state,lifecycle,"
          + "current_stage,state_started_date,owner_name,participant_count,blocked_task_count,latest_report_date "
          + "from project_state_snapshots where snapshot_date=? order by project_id", window.endDate()));
      snapshot.put("tasks", jdbcTemplate.queryForList("select t.id as task_id,r.report_date,"
          + "e.id as employee_id,e.name as employee_name,e.team_name,r.attendance_status,"
          + "r.submitted_at,p.id as project_id,p.name as project_name,t.work_type,t.work_stage,"
          + "t.participation_role,t.progress_result,t.current_status,t.issue_type,"
          + "t.collaboration_role,t.collaboration_requirement from daily_tasks t "
          + "join daily_reports r on r.id=t.report_id join employees e on e.id=r.employee_id "
          + "join projects p on p.id=t.project_id where r.report_date between ? and ? "
          + "order by r.report_date,t.id", window.startDate(), window.endDate()));
      return objectMapper.writeValueAsString(snapshot);
    } catch (Exception exception) {
      throw new IllegalStateException("Unable to build analysis source snapshot", exception);
    }
  }
}
