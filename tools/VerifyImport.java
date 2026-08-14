import java.sql.*;

public class VerifyImport {
  private static void print(Connection c, String sql) throws Exception {
    try (Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
      while (rs.next()) System.out.println(rs.getString(1) + "=" + rs.getLong(2));
    }
  }
  public static void main(String[] args) throws Exception {
    try (Connection c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/daily_report_dev", "drs_pg_admin", "1qaz@WSX")) {
      print(c, "select 'employees',count(*) from employees union all select 'projects',count(*) from projects union all select 'reports',count(*) from daily_reports union all select 'tasks',count(*) from daily_tasks");
      print(c, "select 'attendance:'||attendance_status,count(*) from daily_reports group by attendance_status order by 1");
      print(c, "select 'period:'||time_period,count(*) from daily_tasks group by time_period order by 1");
      print(c, "select 'status:'||current_status,count(*) from daily_tasks group by current_status order by 1");
      print(c, "select 'stage:'||work_stage,count(*) from daily_tasks where work_stage is not null group by work_stage order by 1");
      print(c, "select 'orphans',count(*) from daily_tasks t left join daily_reports r on r.id=t.report_id left join projects p on p.id=t.project_id where r.id is null or p.id is null");
      print(c, "select 'bad_text',count(*) from daily_tasks where progress_result like '%????%' or progress_result like '%' || chr(65533) || '%'");
      try (Statement s = c.createStatement(); ResultSet rs = s.executeQuery("select name from projects where formal order by code")) { while (rs.next()) System.out.println("project_name=" + rs.getString(1)); }
    }
  }
}
