import java.sql.*;

public class VerifyDailySkills {
  public static void main(String[] args) throws Exception {
    try (Connection c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/daily_report_dev", "drs_pg_admin", "1qaz@WSX"); Statement s = c.createStatement()) {
      show(s, "select analysis_period||'/'||skill_kind||'/v'||version_number||'/'||status||'/'||skill_name, validation_message from analysis_skill_versions order by id");
      show(s, "select 'trial-'||id||'/'||status||'/'||period_start||'/'||period_end, coalesce(error_summary,'') from analysis_skill_trials order by id desc");
      show(s, "select 'model-config', case when model_endpoint is null or model_name is null then 'MISSING' else 'SET' end from analysis_configurations where id=1");
    }
  }
  private static void show(Statement s, String sql) throws Exception {
    try (ResultSet r = s.executeQuery(sql)) { while (r.next()) System.out.println(r.getString(1) + "|" + r.getString(2)); }
  }
}
