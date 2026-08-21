package com.company.daily.analysis;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.metrics.ReportMetrics;
import com.company.daily.rules.RuleConclusion;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

@Component
public class LlmAnalysisAdapter {
  private final EnvironmentProperties environment;
  private final ObjectMapper objectMapper;
  private final HttpClient httpClient;

  @Autowired
  public LlmAnalysisAdapter(EnvironmentProperties environment, ObjectMapper objectMapper) {
    this(environment, objectMapper, HttpClient.newBuilder()
        .connectTimeout(Duration.ofSeconds(5)).build());
  }

  LlmAnalysisAdapter(
      EnvironmentProperties environment, ObjectMapper objectMapper, HttpClient httpClient) {
    this.environment = environment;
    this.objectMapper = objectMapper;
    this.httpClient = httpClient;
  }

  public LlmAnalysisResult analyze(
      AnalysisConfiguration configuration,
      ReportMetrics metrics,
      List<RuleConclusion> rules,
      List<String> taskTexts) {
    String endpoint = StringUtils.hasText(configuration.modelEndpoint())
        ? configuration.modelEndpoint() : environment.getLlm().getEndpoint();
    String model = StringUtils.hasText(configuration.modelName())
        ? configuration.modelName() : environment.getLlm().getModel();
    String apiKey = StringUtils.hasText(configuration.modelApiKey())
        ? configuration.modelApiKey() : environment.getLlm().getApiKey();
    if (!StringUtils.hasText(endpoint) || !StringUtils.hasText(model)) {
      return LlmAnalysisResult.skipped("未配置 LLM，已保留客观指标与规则结论");
    }
    try {
      Map<String, Object> payload = new LinkedHashMap<>();
      payload.put("model", model);
      payload.put("messages", List.of(
          Map.of("role", "system", "content", configuration.promptTemplate()
              + " 输出仅为顾问性建议，不得声称已执行人员调配或项目决策。"),
          Map.of("role", "user", "content", Map.of(
              "date", metrics.date().toString(),
              "dimensions", configuration.selectedDimensions(),
              "metrics", metrics,
              "rules", rules,
              "taskTexts", taskTexts))));
      HttpRequest.Builder builder = HttpRequest.newBuilder(URI.create(endpoint))
          .timeout(Duration.ofSeconds(90))
          .header("Content-Type", "application/json")
          .POST(HttpRequest.BodyPublishers.ofString(objectMapper.writeValueAsString(payload)));
      if (StringUtils.hasText(apiKey)) {
        builder.header("Authorization", "Bearer " + apiKey);
      }
      HttpResponse<String> response = httpClient.send(
          builder.build(), HttpResponse.BodyHandlers.ofString());
      if (response.statusCode() < 200 || response.statusCode() >= 300) {
        return LlmAnalysisResult.failed("LLM HTTP " + response.statusCode());
      }
      JsonNode body = objectMapper.readTree(response.body());
      String text = body.path("choices").path(0).path("message").path("content").asText();
      if (!StringUtils.hasText(text)) {
        return LlmAnalysisResult.failed("LLM 未返回分析内容");
      }
      return new LlmAnalysisResult("succeeded", "管理建议（仅供参考）：\n" + text.trim(), null);
    } catch (InterruptedException exception) {
      Thread.currentThread().interrupt();
      return LlmAnalysisResult.failed("LLM 调用被中断");
    } catch (Exception exception) {
      return LlmAnalysisResult.failed("LLM 调用失败: " + exception.getClass().getSimpleName());
    }
  }

  public LlmAnalysisResult analyzeSkill(
      AnalysisConfiguration configuration, String instructions, Object input) {
    return analyzeSkill(configuration, instructions, input, schemaFromInstructions(instructions));
  }

  public LlmAnalysisResult analyzeSkill(
      AnalysisConfiguration configuration, String instructions, Object input, String jsonSchema) {
    String endpoint = StringUtils.hasText(configuration.modelEndpoint())
        ? configuration.modelEndpoint() : environment.getLlm().getEndpoint();
    String model = StringUtils.hasText(configuration.modelName())
        ? configuration.modelName() : environment.getLlm().getModel();
    String apiKey = StringUtils.hasText(configuration.modelApiKey())
        ? configuration.modelApiKey() : environment.getLlm().getApiKey();
    if (!StringUtils.hasText(endpoint) || !StringUtils.hasText(model)) {
      return LlmAnalysisResult.failed("未配置可用的模型服务");
    }
    try {
      Map<String, Object> payload = new LinkedHashMap<>();
      payload.put("model", model);
      if (isMiniMaxM3(model)) {
        payload.put("thinking", Map.of("type", "disabled"));
        payload.put("max_completion_tokens", 8192);
      } else if (isMiniMax(endpoint, model)) {
        payload.put("reasoning_split", true);
        payload.put("max_completion_tokens", 8192);
      }
      payload.put("messages", List.of(
          Map.of("role", "system", "content", instructions),
          Map.of("role", "user", "content", input)));
      boolean schemaRequested = StringUtils.hasText(jsonSchema);
      if (schemaRequested) {
        payload.put("response_format", Map.of("type", "json_schema", "json_schema", Map.of(
            "name", "daily_analysis", "strict", true, "schema", objectMapper.readTree(jsonSchema))));
      }
      String requestBody = objectMapper.writeValueAsString(payload);
      for (int attempt = 0; attempt < 2; attempt++) {
        HttpRequest.Builder builder = HttpRequest.newBuilder(URI.create(endpoint))
            .timeout(environment.getLlm().getSkillRequestTimeout()).header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(requestBody));
        if (StringUtils.hasText(apiKey)) {
          builder.header("Authorization", "Bearer " + apiKey);
        }
        HttpResponse<String> response = httpClient.send(
            builder.build(), HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() < 200 || response.statusCode() >= 300) {
          if (schemaRequested && attempt == 0) {
            payload.put("response_format", Map.of("type", "json_object"));
            requestBody = objectMapper.writeValueAsString(payload);
            schemaRequested = false;
            continue;
          }
          return LlmAnalysisResult.failed("LLM HTTP " + response.statusCode());
        }
        JsonNode body = objectMapper.readTree(response.body());
        String text = body.path("choices").path(0).path("message").path("content").asText();
        if (StringUtils.hasText(text)) {
          return new LlmAnalysisResult("succeeded", text.trim(), null);
        }
      }
      return LlmAnalysisResult.failed("LLM 未返回分析内容");
    } catch (InterruptedException exception) {
      Thread.currentThread().interrupt();
      return LlmAnalysisResult.failed("LLM 调用被中断");
    } catch (Exception exception) {
      return LlmAnalysisResult.failed("LLM 调用失败: " + exception.getClass().getSimpleName());
    }
  }

  public LlmAnalysisResult testConnection(String endpoint, String model, String apiKey) {
    AnalysisConfiguration configuration = new AnalysisConfiguration(false, "0 0 0 * * ?", List.of(), Map.of(),
        "connection-test", "Reply with OK only.", false, false, false, List.of(), List.of(), "", "",
        endpoint, model, apiKey, null, null, null, null, null);
    return analyzeSkill(configuration, "Reply with OK only.", Map.of("test", true));
  }

  private static boolean isMiniMax(String endpoint, String model) {
    return model.regionMatches(true, 0, "MiniMax", 0, "MiniMax".length())
        || endpoint.contains("minimaxi.com") || endpoint.contains("minimax.io");
  }

  private static boolean isMiniMaxM3(String model) {
    return model.regionMatches(true, 0, "MiniMax-M3", 0, "MiniMax-M3".length());
  }

  private static String schemaFromInstructions(String instructions) {
    String marker = "# Required analysis JSON Schema";
    String endMarker = "# Host output requirement";
    int start = instructions == null ? -1 : instructions.indexOf(marker);
    if (start < 0) {
      return null;
    }
    start += marker.length();
    int end = instructions.indexOf(endMarker, start);
    String schema = (end < 0 ? instructions.substring(start) : instructions.substring(start, end)).trim();
    return schema.startsWith("{") ? schema : null;
  }
}
