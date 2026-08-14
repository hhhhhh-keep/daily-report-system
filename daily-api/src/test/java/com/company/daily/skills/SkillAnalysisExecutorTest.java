package com.company.daily.skills;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.analysis.LlmAnalysisAdapter;
import com.company.daily.analysis.LlmAnalysisResult;
import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import tools.jackson.databind.ObjectMapper;

class SkillAnalysisExecutorTest {
  @Test
  void acceptsRuleOutputWrappedInAJsonCodeFence() {
    SkillAnalysisExecutor executor = new SkillAnalysisExecutor(
        new StubConfigurationService(), new StubAdapter(), new ObjectMapper());

    SkillAnalysisExecutor.SkillExecution result = executor.execute(
        null, null, "rule", "template", """
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
        "statistics":[],"workdays":[],"projectStates":[],
        "tasks":[{"employee_name":"Alice","team_name":"Delivery","project_name":"Project A",
        "current_status":"blocked","collaboration_requirement":"vendor input",
        "progress_result":"raw task detail must not be sent"}]}
        """);

    assertThat(result.status()).isEqualTo("SUCCEEDED");
    assertThat(result.analysisDraft()).contains("conclusions");
    assertThat(result.renderedHtml()).isEqualTo("<section class=\"daily-analysis-report\"></section>");
  }

  private static final class StubAdapter extends LlmAnalysisAdapter {
    private int calls;

    StubAdapter() { super(new EnvironmentProperties(), new ObjectMapper()); }

    @Override
    public LlmAnalysisResult analyzeSkill(
        AnalysisConfiguration configuration, String instructions, Object input) {
      calls++;
      if (calls == 1) {
        return new LlmAnalysisResult("succeeded", "<think>reasoning</think>\n```json\n{\"conclusions\":[]}\n```", null);
      }
      assertThat(input).isInstanceOf(String.class);
      assertThat((String) input).contains("analysisDraft").contains("sourceSummary")
          .contains("dailyReporting").contains("personnelEffectiveness").contains("projectManagement")
          .contains("resourceCoordination").doesNotContain("raw task detail must not be sent");
      return new LlmAnalysisResult("succeeded",
          "<think>reasoning</think><section class=\"daily-analysis-report\"></section>", null);
    }
  }

  private static final class StubConfigurationService extends AnalysisConfigurationService {
    StubConfigurationService() { super(null); }

    @Override
    public AnalysisConfiguration get() {
      return new AnalysisConfiguration(false, "", List.of(), Map.of(), "", "", false, false,
          false, List.of(), List.of(), "", "", "", "", "", null, null, null, null, null);
    }
  }
}
