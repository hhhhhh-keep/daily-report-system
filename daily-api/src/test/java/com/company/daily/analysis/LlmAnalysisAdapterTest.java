package com.company.daily.analysis;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.metrics.ReportMetrics;
import com.company.daily.rules.RuleConclusion;
import com.sun.net.httpserver.HttpServer;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import org.junit.jupiter.api.Test;
import tools.jackson.databind.ObjectMapper;

class LlmAnalysisAdapterTest {
  @Test
  void defaultsSkillRequestTimeoutToFiveMinutes() {
    assertThat(new EnvironmentProperties().getLlm().getSkillRequestTimeout())
        .isEqualTo(Duration.ofSeconds(300));
  }

  @Test
  void sendsStrictSchemaAndFallsBackToJsonObjectWhenEndpointRejectsIt() throws Exception {
    AtomicInteger requests = new AtomicInteger();
    AtomicReference<String> firstRequest = new AtomicReference<>();
    AtomicReference<String> secondRequest = new AtomicReference<>();
    HttpServer server = HttpServer.create(new InetSocketAddress(0), 0);
    server.createContext("/chat", exchange -> {
      String request = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
      if (requests.incrementAndGet() == 1) {
        firstRequest.set(request);
        exchange.sendResponseHeaders(400, -1);
      } else {
        secondRequest.set(request);
        byte[] response = "{\"choices\":[{\"message\":{\"content\":\"{}\"}}]}"
            .getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().add("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, response.length);
        exchange.getResponseBody().write(response);
      }
      exchange.close();
    });
    server.start();
    try {
      AnalysisConfiguration configuration = configuration(
          "http://localhost:" + server.getAddress().getPort() + "/chat", "test-model");
      String instructions = "Rule\n# Required analysis JSON Schema\n{\"type\":\"object\"}\n"
          + "# Host output requirement\nJSON only";

      LlmAnalysisResult result = new LlmAnalysisAdapter(new EnvironmentProperties(), new ObjectMapper())
          .analyzeSkill(configuration, instructions, Map.of("facts", true));

      assertThat(result.status()).isEqualTo("succeeded");
      assertThat(firstRequest.get()).contains("\"type\":\"json_schema\"")
          .contains("\"strict\":true");
      assertThat(secondRequest.get()).contains("\"type\":\"json_object\"")
          .doesNotContain("\"json_schema\":");
    } finally {
      server.stop(0);
    }
  }

  @Test
  void disablesThinkingAndBoundsSkillResponseForMiniMaxM3() throws Exception {
    AtomicReference<String> requestBody = new AtomicReference<>();
    HttpServer server = HttpServer.create(new InetSocketAddress(0), 0);
    server.createContext("/chat", exchange -> {
      requestBody.set(new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8));
      byte[] response = """
          {"choices":[{"message":{"content":"{\\\"summary\\\":\\\"ok\\\"}"}}]}
          """.getBytes(StandardCharsets.UTF_8);
      exchange.getResponseHeaders().add("Content-Type", "application/json");
      exchange.sendResponseHeaders(200, response.length);
      exchange.getResponseBody().write(response);
      exchange.close();
    });
    server.start();
    try {
      AnalysisConfiguration configuration = configuration(
          "http://localhost:" + server.getAddress().getPort() + "/chat", "MiniMax-M3");

      LlmAnalysisResult result = new LlmAnalysisAdapter(
          new EnvironmentProperties(), new ObjectMapper()).analyzeSkill(
              configuration, "Return JSON only", Map.of("facts", true));

      assertThat(result.status()).isEqualTo("succeeded");
      assertThat(requestBody.get()).contains("\"thinking\":{\"type\":\"disabled\"}")
          .contains("\"max_completion_tokens\":8192")
          .doesNotContain("reasoning_split")
          .doesNotContain("\"max_tokens\"");
    } finally {
      server.stop(0);
    }
  }

  @Test
  void retriesOneEmptyMiniMaxM3SkillResponse() throws Exception {
    AtomicInteger requests = new AtomicInteger();
    HttpServer server = HttpServer.create(new InetSocketAddress(0), 0);
    server.createContext("/chat", exchange -> {
      int attempt = requests.incrementAndGet();
      exchange.getRequestBody().readAllBytes();
      String body = attempt == 1
          ? "{\"choices\":[{\"finish_reason\":\"length\",\"message\":{\"content\":\"\"}}]}"
          : "{\"choices\":[{\"finish_reason\":\"stop\",\"message\":{\"content\":\"{\\\"summary\\\":\\\"ok\\\"}\"}}]}";
      byte[] response = body.getBytes(StandardCharsets.UTF_8);
      exchange.getResponseHeaders().add("Content-Type", "application/json");
      exchange.sendResponseHeaders(200, response.length);
      exchange.getResponseBody().write(response);
      exchange.close();
    });
    server.start();
    try {
      AnalysisConfiguration configuration = configuration(
          "http://localhost:" + server.getAddress().getPort() + "/chat", "MiniMax-M3");

      LlmAnalysisResult result = new LlmAnalysisAdapter(
          new EnvironmentProperties(), new ObjectMapper()).analyzeSkill(
              configuration, "Return JSON only", Map.of("facts", true));

      assertThat(result.status()).isEqualTo("succeeded");
      assertThat(requests).hasValue(2);
    } finally {
      server.stop(0);
    }
  }

  @Test
  void failsAfterTwoEmptyMiniMaxM3SkillResponses() throws Exception {
    AtomicInteger requests = new AtomicInteger();
    HttpServer server = HttpServer.create(new InetSocketAddress(0), 0);
    server.createContext("/chat", exchange -> {
      requests.incrementAndGet();
      exchange.getRequestBody().readAllBytes();
      byte[] response = "{\"choices\":[{\"finish_reason\":\"length\",\"message\":{\"content\":\"\"}}]}"
          .getBytes(StandardCharsets.UTF_8);
      exchange.getResponseHeaders().add("Content-Type", "application/json");
      exchange.sendResponseHeaders(200, response.length);
      exchange.getResponseBody().write(response);
      exchange.close();
    });
    server.start();
    try {
      AnalysisConfiguration configuration = configuration(
          "http://localhost:" + server.getAddress().getPort() + "/chat", "MiniMax-M3");

      LlmAnalysisResult result = new LlmAnalysisAdapter(
          new EnvironmentProperties(), new ObjectMapper()).analyzeSkill(
              configuration, "Return JSON only", Map.of("facts", true));

      assertThat(result.status()).isEqualTo("failed");
      assertThat(result.errorSummary()).contains("未返回分析内容");
      assertThat(requests).hasValue(2);
    } finally {
      server.stop(0);
    }
  }

  @Test
  void isolatesOpenAiCompatibleCallAndLabelsOutputAsAdvisory() throws Exception {
    AtomicReference<String> requestBody = new AtomicReference<>();
    HttpServer server = HttpServer.create(new InetSocketAddress(0), 0);
    server.createContext("/chat", exchange -> {
      requestBody.set(new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8));
      byte[] response = """
          {"choices":[{"message":{"content":"建议关注项目风险并由管理者评估资源安排。"}}]}
          """.getBytes(StandardCharsets.UTF_8);
      exchange.getResponseHeaders().add("Content-Type", "application/json");
      exchange.sendResponseHeaders(200, response.length);
      exchange.getResponseBody().write(response);
      exchange.close();
    });
    server.start();
    try {
      AnalysisConfiguration configuration = configuration(
          "http://localhost:" + server.getAddress().getPort() + "/chat", "test-model");
      LlmAnalysisResult result = new LlmAnalysisAdapter(
          new EnvironmentProperties(), new ObjectMapper()).analyze(configuration, metrics(),
          List.of(new RuleConclusion("risk", "warning", "存在风险")), List.of("等待反馈"));

      assertThat(result.status()).isEqualTo("succeeded");
      assertThat(result.advisoryText()).startsWith("管理建议（仅供参考）");
      assertThat(requestBody.get()).contains("不得声称已执行人员调配或项目决策")
          .contains("project-risk").contains("等待反馈");
    } finally {
      server.stop(0);
    }
  }

  @Test
  void degradesWithoutCallingAnExternalModelWhenConfigurationIsBlank() {
    LlmAnalysisResult result = new LlmAnalysisAdapter(
        new EnvironmentProperties(), new ObjectMapper()).analyze(configuration(null, null), metrics(),
        List.of(), List.of());

    assertThat(result.status()).isEqualTo("skipped");
    assertThat(result.advisoryText()).contains("客观指标与规则结论");
  }

  private AnalysisConfiguration configuration(String endpoint, String model) {
    return new AnalysisConfiguration(true, "0 0 22 * * ?", List.of("project-risk"), Map.of(),
        "V1", "分析风险", true, true, false, List.of(), List.of(), "日报 {{date}}",
        "{{content}}", endpoint, model, null, null, null, null, null, null);
  }

  private ReportMetrics metrics() {
    return new ReportMetrics(LocalDate.of(2026, 8, 10), 1, 1, 0, 1, 1, 1, 0,
        1, 1, 0, 0, 0, 0, 0, 1);
  }
}
