package com.company.daily.masterdata.state;

import java.time.LocalDate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProjectStateSnapshotService {
  private final JdbcTemplate jdbcTemplate;

  public ProjectStateSnapshotService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional
  public void capture(LocalDate date) {
    jdbcTemplate.update("delete from project_state_snapshots where snapshot_date=?", date);
    jdbcTemplate.update("""
        insert into project_state_snapshots(snapshot_date,project_id,project_name,state,lifecycle,
          current_stage,state_started_date,owner_name,participant_count,blocked_task_count,
          latest_report_date,trigger_task_id)
        select ?,p.id,p.name,
          case when fact.current_status='blocked' then 'BLOCKED'
               when fact.current_status='paused' then 'PAUSED'
               when fact.work_type='special-work' then 'IN_PROGRESS'
               when fact.work_stage in ('requirements-analysis','solution-design','bid-quotation','technical-presentation') then 'PRESALES_IN_PROGRESS'
               when fact.work_stage in ('implementation','testing-deployment','training-acceptance') then 'DELIVERY_IN_PROGRESS'
               when fact.work_stage in ('operations-support','incident-handling','optimization-upgrade','customer-support') then 'AFTERSALES_IN_PROGRESS'
               when fact.task_id is null then 'NOT_STARTED' else 'IN_PROGRESS' end,
          case when fact.work_stage in ('requirements-analysis','solution-design','bid-quotation','technical-presentation') then 'presales'
               when fact.work_stage in ('implementation','testing-deployment','training-acceptance') then 'delivery'
               when fact.work_stage in ('operations-support','incident-handling','optimization-upgrade','customer-support') then 'aftersales' end,
          fact.work_stage,coalesce(fact.report_date,?),p.owner_name,
          coalesce(metrics.participant_count,0),coalesce(metrics.blocked_task_count,0),
          metrics.latest_report_date,fact.task_id
        from projects p
        left join lateral (select t.id as task_id,r.report_date,t.work_type,t.work_stage,t.current_status
          from daily_tasks t join daily_reports r on r.id=t.report_id
          where t.project_id=p.id and r.report_date<=? order by r.report_date desc,t.id desc limit 1) fact on true
        left join lateral (select count(distinct r.employee_id) as participant_count,
          count(*) filter (where t.current_status in ('blocked','paused')) as blocked_task_count,
          max(r.report_date) as latest_report_date from daily_tasks t join daily_reports r on r.id=t.report_id
          where t.project_id=p.id and r.report_date<=?) metrics on true
        where p.active=true
        """, date, date, date, date);
  }
}
