package com.company.daily.analysis;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.metrics.ReportMetrics;
import com.company.daily.rules.RuleConclusion;
import com.sun.net.httpserver.HttpServer;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;
import org.junit.jupiter.api.Test;
import tools.jackson.databind.ObjectMapper;

class LlmAnalysisAdapterTest {
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
