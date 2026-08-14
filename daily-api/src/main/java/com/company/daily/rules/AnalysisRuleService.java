package com.company.daily.rules;

import com.company.daily.metrics.ReportMetrics;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public class AnalysisRuleService {
  public List<RuleConclusion> evaluate(ReportMetrics metrics, Map<String, Integer> thresholds) {
    List<RuleConclusion> results = new ArrayList<>();
    if (metrics.missingReportCount() > 0) {
      results.add(new RuleConclusion("missing-reports", "warning",
          metrics.missingReportCount() + " 人未提交日报"));
    }
    if (metrics.abnormalTaskCount() > 0) {
      results.add(new RuleConclusion("abnormal-tasks", "warning",
          metrics.abnormalTaskCount() + " 项任务存在风险或阻塞"));
    }
    if (metrics.vagueTaskCount() > 0) {
      results.add(new RuleConclusion("vague-results", "notice",
          metrics.vagueTaskCount() + " 项任务进展描述过短"));
    }
    if (metrics.taskCount() >= threshold(thresholds, "highTaskCount", 6)) {
      results.add(new RuleConclusion("high-task-load", "notice",
          "当日任务数达到 " + metrics.taskCount() + " 项，请结合人员分布评估负荷"));
    }
    if (metrics.projectCount() >= threshold(thresholds, "highProjectCount", 3)) {
      results.add(new RuleConclusion("high-project-load", "notice",
          "当日涉及 " + metrics.projectCount() + " 个项目，存在较多并行切换"));
    }
    if (metrics.maxConsecutiveSupportDays() >= threshold(thresholds, "consecutiveSupportDays", 3)) {
      results.add(new RuleConclusion("continuous-support", "warning",
          "存在连续 " + metrics.maxConsecutiveSupportDays() + " 天临时支撑"));
    }
    if (metrics.maxConsecutiveWaitingFeedbackDays()
        >= threshold(thresholds, "waitingFeedbackDays", 2)) {
      results.add(new RuleConclusion("continuous-waiting-feedback", "warning",
          "存在连续 " + metrics.maxConsecutiveWaitingFeedbackDays() + " 天等待反馈"));
    }
    if (metrics.multiProjectEmployeeCount() > 0) {
      results.add(new RuleConclusion("multi-project", "notice",
          metrics.multiProjectEmployeeCount() + " 人同时参与多个项目"));
    }
    if (metrics.multiPersonProjectCount() > 0) {
      results.add(new RuleConclusion("multi-person-project", "notice",
          metrics.multiPersonProjectCount() + " 个项目由多人协同"));
    }
    if (metrics.taskCount() == 0 && metrics.submittedReportCount() > 0) {
      results.add(new RuleConclusion("empty-reports", "warning", "已提交日报中没有任务"));
    }
    return results;
  }

  private static int threshold(Map<String, Integer> values, String key, int defaultValue) {
    return values.getOrDefault(key, defaultValue);
  }
}
