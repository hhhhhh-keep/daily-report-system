import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class InspectRuleResponse {
  public static void main(String[] args) throws Exception {
    try (Connection connection = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/daily_report_dev", "drs_pg_admin", "1qaz@WSX")) {
      String endpoint = value(connection, "select model_endpoint from analysis_configurations where id=1");
      String model = value(connection, "select model_name from analysis_configurations where id=1");
      String apiKey = value(connection, "select model_api_key from analysis_configurations where id=1");
      String instructions = value(connection,
          "select skill_markdown from analysis_skill_versions where id=1");
      String snapshot = value(connection,
          "select source_snapshot_json from analysis_skill_trials where id=5");
      String payload = "{\"model\":\"" + escape(model) + "\",\"messages\":["
          + "{\"role\":\"system\",\"content\":\"" + escape(instructions) + "\"},"
          + "{\"role\":\"user\",\"content\":\"" + escape(snapshot) + "\"}]}";
      HttpRequest request = HttpRequest.newBuilder(URI.create(endpoint))
          .header("Content-Type", "application/json")
          .header("Authorization", "Bearer " + apiKey)
          .POST(HttpRequest.BodyPublishers.ofString(payload)).build();
      HttpResponse<String> response = HttpClient.newHttpClient().send(
          request, HttpResponse.BodyHandlers.ofString());
      System.out.println("STATUS=" + response.statusCode());
      System.out.println(response.body());
    }
  }

  private static String value(Connection connection, String sql) throws Exception {
    try (PreparedStatement statement = connection.prepareStatement(sql); ResultSet result = statement.executeQuery()) {
      result.next();
      return result.getString(1);
    }
  }

  private static String escape(String value) {
    return value.replace("\\", "\\\\").replace("\"", "\\\"")
        .replace("\n", "\\n").replace("\r", "\\r");
  }
}
