import java.nio.file.*;
import java.sql.*;

public class RunSql {
  public static void main(String[] args) throws Exception {
    String sql = Files.readString(Path.of(args[0]));
    try (Connection c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/daily_report_dev", "drs_pg_admin", "1qaz@WSX"); Statement s = c.createStatement()) {
      try (ResultSet rs = s.executeQuery("select current_database()")) { rs.next(); if (!"daily_report_dev".equals(rs.getString(1))) throw new IllegalStateException("Unexpected database"); }
      boolean quoted = false; StringBuilder part = new StringBuilder();
      for (int i = 0; i < sql.length(); i++) {
        char ch = sql.charAt(i);
        if (ch == 39) { if (quoted && i + 1 < sql.length() && sql.charAt(i + 1) == 39) { part.append("''"); i++; continue; } quoted = !quoted; }
        if (ch == ';' && !quoted) { if (!part.toString().trim().isEmpty()) s.execute(part.toString()); part.setLength(0); } else part.append(ch);
      }
    }
  }
}
