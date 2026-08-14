import java.net.*;
import java.net.http.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

public class UploadDailySkills {
  private static final URI BASE = URI.create("http://localhost:8080/api/admin/analysis-skills/");
  private final HttpClient client = HttpClient.newBuilder().cookieHandler(new CookieManager()).build();

  public static void main(String[] args) throws Exception {
    UploadDailySkills app = new UploadDailySkills();
    app.login();
    if (args.length == 3 && "--trial".equals(args[0])) { app.trial(Long.parseLong(args[1]), Long.parseLong(args[2])); return; }
    long rule = app.upload("DAILY/RULE", Path.of(args[0]));
    long template = app.upload("DAILY/TEMPLATE", Path.of(args[1]));
    app.trial(rule, template);
  }

  private void login() throws Exception {
    HttpRequest request = HttpRequest.newBuilder(URI.create("http://localhost:8080/api/admin/session"))
        .header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString("{\"username\":\"admin\",\"password\":\"1qaz@WSX\"}"))
        .build();
    HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
    require(response, "login");
  }

  private long upload(String slot, Path file) throws Exception {
    String boundary = "DailySkillBoundary" + UUID.randomUUID().toString().replace("-", "");
    byte[] bytes = Files.readAllBytes(file);
    String head = "--" + boundary + "\r\nContent-Disposition: form-data; name=\"file\"; filename=\""
        + file.getFileName() + "\"\r\nContent-Type: application/zip\r\n\r\n";
    byte[] tail = ("\r\n--" + boundary + "--\r\n").getBytes(StandardCharsets.UTF_8);
    byte[] body = new byte[head.getBytes(StandardCharsets.UTF_8).length + bytes.length + tail.length];
    int offset = 0;
    for (byte[] part : List.of(head.getBytes(StandardCharsets.UTF_8), bytes, tail)) {
      System.arraycopy(part, 0, body, offset, part.length); offset += part.length;
    }
    HttpRequest request = HttpRequest.newBuilder(BASE.resolve(slot)).header("Content-Type", "multipart/form-data; boundary=" + boundary)
        .POST(HttpRequest.BodyPublishers.ofByteArray(body)).build();
    HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
    require(response, "upload " + slot);
    Matcher id = Pattern.compile("\"id\"\\s*:\\s*(\\d+)").matcher(response.body());
    if (!id.find()) throw new IllegalStateException("No version id: " + response.body());
    long value = Long.parseLong(id.group(1));
    System.out.println(slot + " uploaded version=" + value);
    return value;
  }

  private void trial(long rule, long template) throws Exception {
    URI uri = BASE.resolve("DAILY/trial?endDate=2026-07-31&ruleVersionId=" + rule + "&templateVersionId=" + template);
    HttpResponse<String> response = client.send(HttpRequest.newBuilder(uri).POST(HttpRequest.BodyPublishers.noBody()).build(), HttpResponse.BodyHandlers.ofString());
    require(response, "trial");
    System.out.println("trial=" + response.body());
  }

  private static void require(HttpResponse<String> response, String operation) {
    if (response.statusCode() < 200 || response.statusCode() >= 300) {
      throw new IllegalStateException(operation + " failed HTTP " + response.statusCode() + ": " + response.body());
    }
  }
}
