package com.company.daily.analysis;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
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
      List<Map<String, Object>> workdays = jdbcTemplate.queryForList(
          "select calendar_date,workday,source,note from workday_calendar "
              + "where calendar_date<=? and active=true order by calendar_date",
          window.endDate());
      LocalDate reportDate = window.endDate();
      LocalDate coverageStart = window.period() == AnalysisPeriod.DAILY ? reportDate : window.startDate();
      LocalDate coverageEnd = window.endDate();
      Map<String, Object> snapshot = new LinkedHashMap<>();
      snapshot.put("period", window.period().name());
      snapshot.put("periodStart", window.startDate().toString());
      snapshot.put("periodEnd", window.endDate().toString());
      snapshot.put("reportDate", reportDate.toString());
      snapshot.put("coverageStart", coverageStart.toString());
      snapshot.put("coverageEnd", coverageEnd.toString());
      snapshot.put("roster", jdbcTemplate.queryForList("select e.id as employee_id,e.name as employee_name,"
          + "e.team_name,e.position_type from employees e where e.active=true or exists ("
          + "select 1 from daily_reports r where r.employee_id=e.id and r.report_date between ? and ?) "
          + "order by e.id", coverageStart, coverageEnd));
      snapshot.put("reports", jdbcTemplate.queryForList("select r.id as report_id,r.report_date,"
          + "r.employee_id,r.attendance_status,r.note,r.status,r.submitted_at,r.updated_at "
          + "from daily_reports r where r.report_date between ? and ? order by r.report_date,r.id",
          coverageStart, coverageEnd));
      snapshot.put("statistics", jdbcTemplate.queryForList("select snapshot_type,snapshot_date,"
          + "captured_at,expected_count,submitted_count,missing_count,submission_rate,"
          + "submitted_employees_json,missing_employees_json,late_submitted_employees_json,"
          + "team_statistics_json from report_statistics_snapshots where snapshot_date between ? "
          + "and ? order by snapshot_date,snapshot_type",
          window.period() == AnalysisPeriod.DAILY ? reportDate : window.startDate(), coverageEnd));
      snapshot.put("workdays", workdays);
      snapshot.put("projectStates", jdbcTemplate.queryForList("select s.snapshot_date,s.captured_at,"
          + "s.project_id,s.project_name,s.state,s.lifecycle,s.current_stage,s.state_started_date,"
          + "s.owner_name,s.participant_count,s.blocked_task_count,s.latest_report_date,"
          + "p.formal,p.active,p.status,p.priority from project_state_snapshots s "
          + "join projects p on p.id=s.project_id where s.snapshot_date=? and p.active=true order by s.project_id",
          window.endDate()));
      snapshot.put("tasks", jdbcTemplate.queryForList("select t.id as task_id,t.report_id,r.report_date,"
          + "e.id as employee_id,e.name as employee_name,e.team_name,r.attendance_status,"
          + "r.submitted_at,p.id as project_id,p.name as project_name,t.time_period,t.work_type,t.work_stage,"
          + "t.participation_role,t.progress_result,t.current_status,t.issue_type,"
          + "t.collaboration_role,t.collaboration_requirement from daily_tasks t "
          + "join daily_reports r on r.id=t.report_id join employees e on e.id=r.employee_id "
          + "join projects p on p.id=t.project_id where r.report_date between ? and ? and p.active=true "
          + "order by r.report_date,t.id", coverageStart, coverageEnd));
      return objectMapper.writeValueAsString(snapshot);
    } catch (Exception exception) {
      throw new IllegalStateException("Unable to build analysis source snapshot", exception);
    }
  }

  private static LocalDate asLocalDate(Object value) {
    if (value instanceof LocalDate date) {
      return date;
    }
    if (value instanceof java.sql.Date date) {
      return date.toLocalDate();
    }
    return value == null ? null : LocalDate.parse(value.toString());
  }
}
