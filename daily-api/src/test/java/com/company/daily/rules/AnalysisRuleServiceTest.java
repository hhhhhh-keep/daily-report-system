package com.company.daily.rules;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.metrics.ReportMetrics;
import java.time.LocalDate;
import java.util.Map;
import org.junit.jupiter.api.Test;

class AnalysisRuleServiceTest {
  private final AnalysisRuleService service = new AnalysisRuleService();

  @Test
  void keepsDeterministicRuleConclusionsSeparateFromAdvisoryAnalysis() {
    ReportMetrics metrics = new ReportMetrics(LocalDate.of(2026, 8, 10), 5, 4, 1,
        9, 4, 4, 3, 2, 1, 3, 1, 2, 1, 4, 3);

    var results = service.evaluate(metrics,
        Map.of("consecutiveSupportDays", 3, "waitingFeedbackDays", 2));

    assertThat(results).extracting(RuleConclusion::code).containsExactly(
        "missing-reports", "abnormal-tasks", "vague-results", "high-task-load",
        "high-project-load", "continuous-support",
        "continuous-waiting-feedback", "multi-project", "multi-person-project");
    assertThat(results).allMatch(result -> !result.message().contains("调配人员"));
  }
}
