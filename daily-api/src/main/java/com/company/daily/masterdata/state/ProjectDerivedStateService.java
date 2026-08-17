package com.company.daily.masterdata.state;

import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProjectDerivedStateService {
  private final JdbcTemplate jdbcTemplate;
  private final ProjectStateResolver resolver = new ProjectStateResolver();

  public ProjectDerivedStateService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional
  public void recalculateProject(long projectId) {
    Optional<ProjectStateFact> latest = latestFact(projectId);
    if (latest.isEmpty()) {
      return;
    }
    ProjectStateFact fact = latest.get();
    ProjectDerivedStateValue state = resolver.resolve(fact);
    ProjectDerivedStateResponse previous = current(projectId).orElse(null);
    boolean changed = previous == null || previous.state() != state
        || !java.util.Objects.equals(previous.currentStage(), fact.workStage());
    LocalDate stateStart = changed ? fact.reportDate() : previous.stateStartedDate();
    jdbcTemplate.update("""
        insert into project_derived_states(project_id,state,lifecycle,current_stage,state_started_date,
          trigger_task_id,updated_at) values (?,?,?,?,?,?,current_timestamp)
        on conflict(project_id) do update set state=excluded.state,lifecycle=excluded.lifecycle,
          current_stage=excluded.current_stage,state_started_date=excluded.state_started_date,
          trigger_task_id=excluded.trigger_task_id,updated_at=current_timestamp""",
        projectId, state.name(), lifecycle(state), fact.workStage(), stateStart, fact.taskId());
    if (changed) {
      jdbcTemplate.update("""
          insert into project_state_events(project_id,state,current_stage,trigger_task_id,occurred_date)
          values (?,?,?,?,?)""", projectId, state.name(), fact.workStage(), fact.taskId(), fact.reportDate());
    }
  }

  @Transactional
  public void recalculateProjectsForDate(LocalDate date) {
    jdbcTemplate.queryForList("""
        select distinct t.project_id from daily_tasks t join daily_reports r on r.id=t.report_id
        where r.report_date=?""", Long.class, date).forEach(this::recalculateProject);
  }

  @Transactional
  public void removeTaskReferencesForReport(long reportId) {
    jdbcTemplate.update("update project_state_snapshots set trigger_task_id=null "
        + "where trigger_task_id in (select id from daily_tasks where report_id=?)", reportId);
    jdbcTemplate.update("delete from project_state_events "
        + "where trigger_task_id in (select id from daily_tasks where report_id=?)", reportId);
    jdbcTemplate.update("delete from project_derived_states "
        + "where trigger_task_id in (select id from daily_tasks where report_id=?)", reportId);
  }

  @Transactional(readOnly = true)
  public Optional<ProjectDerivedStateResponse> current(long projectId) {
    List<ProjectDerivedStateResponse> states = jdbcTemplate.query("""
        select state,lifecycle,current_stage,state_started_date,trigger_task_id
        from project_derived_states where project_id=?""", this::state, projectId);
    return states.stream().findFirst();
  }

  @Transactional(readOnly = true)
  public List<ProjectStateEventResponse> events(long projectId) {
    return jdbcTemplate.query("""
        select occurred_date,state,current_stage,trigger_task_id from project_state_events
        where project_id=? order by occurred_date desc,id desc""", (rs, row) -> new ProjectStateEventResponse(
            rs.getObject(1, LocalDate.class), ProjectDerivedStateValue.valueOf(rs.getString(2)),
            rs.getString(3), rs.getLong(4)), projectId);
  }

  private Optional<ProjectStateFact> latestFact(long projectId) {
    List<ProjectStateFact> values = jdbcTemplate.query("""
        select t.id,r.report_date,t.work_type,t.work_stage,t.current_status
        from daily_tasks t join daily_reports r on r.id=t.report_id where t.project_id=?
        order by r.report_date desc,t.id desc limit 1""", (rs, row) -> fact(rs), projectId);
    return values.stream().findFirst();
  }

  private ProjectDerivedStateResponse state(ResultSet rs, int row) throws java.sql.SQLException {
    return new ProjectDerivedStateResponse(ProjectDerivedStateValue.valueOf(rs.getString(1)), rs.getString(2),
        rs.getString(3), rs.getObject(4, LocalDate.class), rs.getObject(5, Long.class));
  }

  private ProjectStateFact fact(ResultSet rs) throws java.sql.SQLException {
    return new ProjectStateFact(rs.getLong(1), rs.getObject(2, LocalDate.class), rs.getString(3),
        rs.getString(4), rs.getString(5));
  }

  private String lifecycle(ProjectDerivedStateValue state) {
    return switch (state) {
      case PRESALES_IN_PROGRESS -> "presales";
      case DELIVERY_IN_PROGRESS -> "delivery";
      case AFTERSALES_IN_PROGRESS -> "aftersales";
      default -> null;
    };
  }
}
