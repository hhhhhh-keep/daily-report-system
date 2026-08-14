package com.company.daily.support;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

public final class DemoDataSeeder {
  private static final String URL = "jdbc:postgresql://localhost:5432/daily_report_dev";
  private static final String USER = "drs_pg_admin";
  private static final String PASSWORD = "1qaz@WSX";

  private DemoDataSeeder() {}

  public static void main(String[] args) throws Exception {
    try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
      connection.setAutoCommit(false);
      long zhangSan = employee(connection, "张三", "解决方案组", "解决方案顾问");
      long liSi = employee(connection, "李四", "交付组", "实施顾问");
      long project = project(connection, "智慧园区数字化平台", "DEMO-001", null, true);
      long initiative = project(connection, "年度交付质量提升专项", null, "QUALITY-2026", false);
      task(connection, LocalDate.of(2026, 8, 10), zhangSan, project, "project-support",
          "requirements-analysis", "完成客户需求调研，形成访谈纪要", "in-progress");
      task(connection, LocalDate.of(2026, 8, 11), zhangSan, project, "project-support",
          "solution-design", "完成总体方案框架与核心流程设计", "in-progress");
      task(connection, LocalDate.of(2026, 8, 12), zhangSan, project, "project-support",
          "technical-presentation", "准备技术交流材料，等待客户反馈", "blocked");
      task(connection, LocalDate.of(2026, 8, 11), liSi, initiative, "special-work", null,
          "梳理交付质量问题清单并制定改进措施", "in-progress");
      task(connection, LocalDate.of(2026, 8, 12), liSi, initiative, "special-work", null,
          "完成质量检查表初稿并组织评审", "completed");
      derivedState(connection, project, "BLOCKED", "presales", "technical-presentation",
          LocalDate.of(2026, 8, 12));
      derivedState(connection, initiative, "COMPLETED", null, null, LocalDate.of(2026, 8, 12));
      connection.commit();
    }
  }

  private static long employee(Connection connection, String name, String team, String position)
      throws Exception {
    try (PreparedStatement select = connection.prepareStatement(
        "select id from employees where name=? and team_name=?")) {
      select.setString(1, name); select.setString(2, team);
      try (ResultSet results = select.executeQuery()) {
        if (results.next()) return results.getLong(1);
      }
    }
    try (PreparedStatement insert = connection.prepareStatement(
        "insert into employees(name,team_name,position_type,active) values (?,?,?,true) returning id")) {
      insert.setString(1, name); insert.setString(2, team); insert.setString(3, position);
      try (ResultSet results = insert.executeQuery()) { results.next(); return results.getLong(1); }
    }
  }

  private static long project(Connection connection, String name, String code, String systemKey,
      boolean formal) throws Exception {
    try (PreparedStatement select = connection.prepareStatement(
        "select id from projects where coalesce(code,'')=coalesce(?, '') and coalesce(system_key,'')=coalesce(?, '')")) {
      select.setString(1, code); select.setString(2, systemKey);
      try (ResultSet results = select.executeQuery()) {
        if (results.next()) {
          long id = results.getLong(1);
          try (PreparedStatement update = connection.prepareStatement("""
              update projects set name=?, customer_name=?, industry=?, project_stage=?, owner_name=?,
              priority=?, status=?, formal=?, active=true where id=?""")) {
            update.setString(1, name); update.setString(2, formal ? "示例客户" : null);
            update.setString(3, formal ? "政企" : null); update.setString(4, formal ? "售前" : null);
            update.setString(5, formal ? "张三" : "李四"); update.setString(6, formal ? "高" : "中");
            update.setString(7, "进行中"); update.setBoolean(8, formal); update.setLong(9, id);
            update.executeUpdate();
          }
          return id;
        }
      }
    }
    try (PreparedStatement insert = connection.prepareStatement("""
        insert into projects(name,customer_name,industry,project_stage,owner_name,priority,status,
        code,formal,system_key,active) values (?,?,?,?,?,?,?,?,?,?,true) returning id""")) {
      insert.setString(1, name); insert.setString(2, formal ? "示例客户" : null);
      insert.setString(3, formal ? "政企" : null); insert.setString(4, formal ? "售前" : null);
      insert.setString(5, formal ? "张三" : "李四"); insert.setString(6, formal ? "高" : "中");
      insert.setString(7, "进行中"); insert.setString(8, code); insert.setBoolean(9, formal);
      insert.setString(10, systemKey);
      try (ResultSet results = insert.executeQuery()) { results.next(); return results.getLong(1); }
    }
  }

  private static void derivedState(Connection connection, long projectId, String state, String lifecycle,
      String stage, LocalDate date) throws Exception {
    long taskId;
    try (PreparedStatement select = connection.prepareStatement("""
        select t.id from daily_tasks t join daily_reports r on r.id=t.report_id
        where t.project_id=? and r.report_date=? order by t.id desc limit 1""")) {
      select.setLong(1, projectId); select.setObject(2, date);
      try (ResultSet results = select.executeQuery()) { results.next(); taskId = results.getLong(1); }
    }
    try (PreparedStatement upsert = connection.prepareStatement("""
        insert into project_derived_states(project_id,state,lifecycle,current_stage,state_started_date,
        trigger_task_id) values (?,?,?,?,?,?) on conflict(project_id) do update set state=excluded.state,
        lifecycle=excluded.lifecycle,current_stage=excluded.current_stage,state_started_date=excluded.state_started_date,
        trigger_task_id=excluded.trigger_task_id,updated_at=current_timestamp""")) {
      upsert.setLong(1, projectId); upsert.setString(2, state); upsert.setString(3, lifecycle);
      upsert.setString(4, stage); upsert.setObject(5, date); upsert.setLong(6, taskId); upsert.executeUpdate();
    }
    try (PreparedStatement event = connection.prepareStatement("""
        insert into project_state_events(project_id,state,current_stage,trigger_task_id,occurred_date)
        select ?,?,?,?,? where not exists (select 1 from project_state_events
        where project_id=? and trigger_task_id=?)""")) {
      event.setLong(1, projectId); event.setString(2, state); event.setString(3, stage);
      event.setLong(4, taskId); event.setObject(5, date); event.setLong(6, projectId); event.setLong(7, taskId);
      event.executeUpdate();
    }
  }

  private static void task(Connection connection, LocalDate date, long employeeId, long projectId,
      String type, String stage, String progress, String status) throws Exception {
    long reportId;
    try (PreparedStatement report = connection.prepareStatement("""
        insert into daily_reports(report_date,employee_id,attendance_status,status)
        values (?,?,'present','submitted') on conflict(employee_id,report_date)
        do update set updated_at=current_timestamp returning id""")) {
      report.setObject(1, date); report.setLong(2, employeeId);
      try (ResultSet results = report.executeQuery()) { results.next(); reportId = results.getLong(1); }
    }
    try (PreparedStatement exists = connection.prepareStatement(
        "select 1 from daily_tasks where report_id=? and project_id=?")) {
      exists.setLong(1, reportId); exists.setLong(2, projectId);
      try (ResultSet results = exists.executeQuery()) { if (results.next()) return; }
    }
    try (PreparedStatement insert = connection.prepareStatement("""
        insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,
        participation_role,progress_result,current_status) values (?,?,?,?,?,?,?,?)""")) {
      insert.setLong(1, reportId); insert.setString(2, "morning"); insert.setLong(3, projectId);
      insert.setString(4, type); insert.setString(5, stage); insert.setString(6, "owner");
      insert.setString(7, progress); insert.setString(8, status); insert.executeUpdate();
    }
  }
}
