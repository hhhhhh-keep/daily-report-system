package com.company.daily.scheduling;

import com.company.daily.analysis.LlmAnalysisAdapter;
import com.company.daily.analysis.LlmAnalysisResult;
import com.company.daily.analysis.AnalysisPeriodConfiguration;
import com.company.daily.analysis.AnalysisPeriodConfigurationService;
import com.company.daily.analysis.AnalysisPeriodWindow;
import com.company.daily.analysis.AnalysisRuleVersionService;
import com.company.daily.analysis.AnalysisSourceSnapshotService;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import com.company.daily.email.EmailDeliveryResult;
import com.company.daily.email.EmailService;
import com.company.daily.metrics.ReportMetrics;
import com.company.daily.metrics.ReportMetricsService;
import com.company.daily.reporting.ReportArtifact;
import com.company.daily.reporting.ReportService;
import com.company.daily.rules.AnalysisRuleService;
import com.company.daily.rules.RuleConclusion;
import com.company.daily.skills.AnalysisSkillService;
import com.company.daily.skills.SkillAnalysisExecutor;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;
import tools.jackson.databind.ObjectMapper;

@Service
public class AnalysisOrchestrator {
  private final AnalysisConfigurationService configurationService;
  private final ReportMetricsService metricsService;
  private final AnalysisRuleService ruleService;
  private final LlmAnalysisAdapter llmAdapter;
  private final ReportService reportService;
  private final EmailService emailService;
  private final AnalysisRunStore runStore;
  private final ObjectMapper objectMapper;
  private final AnalysisPeriodConfigurationService periodConfigurationService;
  private final AnalysisRuleVersionService ruleVersionService;
  private final AnalysisSourceSnapshotService sourceSnapshotService;
  private final AnalysisSkillService analysisSkillService;
  private final SkillAnalysisExecutor skillAnalysisExecutor;

  public AnalysisOrchestrator(
      AnalysisConfigurationService configurationService,
      ReportMetricsService metricsService,
      AnalysisRuleService ruleService,
      LlmAnalysisAdapter llmAdapter,
      ReportService reportService,
      EmailService emailService,
      AnalysisRunStore runStore,
      ObjectMapper objectMapper,
      AnalysisPeriodConfigurationService periodConfigurationService,
      AnalysisRuleVersionService ruleVersionService,
      AnalysisSourceSnapshotService sourceSnapshotService,
      AnalysisSkillService analysisSkillService,
      SkillAnalysisExecutor skillAnalysisExecutor) {
    this.configurationService = configurationService;
    this.metricsService = metricsService;
    this.ruleService = ruleService;
    this.llmAdapter = llmAdapter;
    this.reportService = reportService;
    this.emailService = emailService;
    this.runStore = runStore;
    this.objectMapper = objectMapper;
    this.periodConfigurationService = periodConfigurationService;
    this.ruleVersionService = ruleVersionService;
    this.sourceSnapshotService = sourceSnapshotService;
    this.analysisSkillService = analysisSkillService;
    this.skillAnalysisExecutor = skillAnalysisExecutor;
  }

  public AnalysisRunResponse run(LocalDate date, String triggerType) {
    return execute(date, triggerType, null, 0);
  }

  public AnalysisRunResponse run(AnalysisPeriodWindow window, String triggerType) {
    AnalysisPeriodConfiguration configuration = periodConfigurationService.get(window.period());
    if (!configuration.enabled()) {
      throw new IllegalArgumentException("Analysis period is disabled");
    }
    return execute(window, triggerType, configuration.enabledModules());
  }

  public AnalysisRunResponse retry(long sourceRunId) {
    AnalysisRunResponse source = runStore.get(sourceRunId);
    if (!List.of("failed", "partial-failure").contains(source.status())) {
      throw new IllegalArgumentException("仅失败或部分失败的运行可以重试");
    }
    return execute(source.analysisDate(), "retry", source.id(), source.retryCount() + 1);
  }

  private AnalysisRunResponse execute(
      LocalDate date, String triggerType, Long retryOf, int retryCount) {
    AnalysisConfiguration configuration = configurationService.get();
    long runId = runStore.start(
        date, triggerType, configuration.selectedDimensions(), retryOf, retryCount);
    try {
      int vagueLength = configuration.ruleThresholds().getOrDefault("vagueResultLength", 8);
      ReportMetrics metrics = metricsService.calculate(date, vagueLength);
      List<RuleConclusion> rules = ruleService.evaluate(metrics, configuration.ruleThresholds());
      LlmAnalysisResult llm = llmAdapter.analyze(
          configuration, metrics, rules, runStore.taskTexts(date));
      String advisory = llm.advisoryText() == null
          ? "LLM 不可用；本次仅提供客观指标与确定性规则。" : llm.advisoryText();
      ReportArtifact artifact = configuration.reportEnabled()
          ? reportService.generate(configuration, metrics, rules, advisory) : null;
      EmailDeliveryResult email = artifact == null
          ? new EmailDeliveryResult("not-requested", null)
          : emailService.deliver(runId, date, configuration, artifact);
      List<String> errors = new ArrayList<>();
      if (llm.errorSummary() != null) {
        errors.add(llm.errorSummary());
      }
      if (email.errorSummary() != null) {
        errors.add(email.errorSummary());
      }
      String status = errors.isEmpty() ? "succeeded" : "partial-failure";
      String summary = dimensionSummary(metrics, rules, advisory);
      if (configuration.dashboardEnabled()) {
        for (String dimension : configuration.selectedDimensions()) {
          runStore.saveDimension(runId, dimension, summary);
        }
      }
      runStore.complete(runId, status, metrics.submittedReportCount(),
          objectMapper.writeValueAsString(metrics), objectMapper.writeValueAsString(rules),
          advisory, llm.status(), artifact == null ? null : artifact.html(),
          artifact == null ? null : artifact.pdf(), artifact == null ? null : artifact.fileName(),
          email.status(), errors.isEmpty() ? null : String.join("; ", errors));
    } catch (Exception exception) {
      runStore.fail(runId, exception.getClass().getSimpleName() + ": " + exception.getMessage());
    }
    return runStore.get(runId);
  }

  private AnalysisRunResponse execute(
      AnalysisPeriodWindow window, String triggerType, List<String> selectedDimensions) {
    AnalysisSkillService.PublishedSkillPair skills = analysisSkillService.publishedPair(window.period());
    AnalysisConfiguration configuration = configurationService.get();
    String sourceSnapshot = sourceSnapshotService.build(window);
    long runId = runStore.start(window, triggerType, selectedDimensions,
        sourceSnapshot, null, 0);
    try {
      runStore.saveSkillVersionSnapshot(runId, skills.rule().id(), skills.template().id());
      SkillAnalysisExecutor.SkillExecution skillExecution = skillAnalysisExecutor.execute(skills.rule(),
          skills.template(), skills.ruleMarkdown(), skills.templateMarkdown(), sourceSnapshot,
          skills.rulePackage(), skills.templatePackage());
      if (!"SUCCEEDED".equals(skillExecution.status())) {
        throw new IllegalStateException(skillExecution.errorSummary());
      }
      int vagueLength = configuration.ruleThresholds().getOrDefault("vagueResultLength", 8);
      ReportMetrics metrics = metricsService.calculate(window.startDate(), window.endDate(), vagueLength);
      List<RuleConclusion> rules = ruleService.evaluate(metrics, configuration.ruleThresholds());
      String advisory = skillExecution.analysisDraft() == null
          ? skillExecution.errorSummary() : skillExecution.analysisDraft();
      ReportArtifact fallbackArtifact = reportService.generate(configuration, metrics, rules, advisory);
      ReportArtifact artifact = configuration.reportEnabled()
          ? new ReportArtifact(skillExecution.renderedHtml(), fallbackArtifact.pdf(), fallbackArtifact.fileName()) : null;
      EmailDeliveryResult email = artifact == null
          ? new EmailDeliveryResult("not-requested", null)
          : emailService.deliver(runId, window.endDate(), configuration, artifact);
      List<String> errors = new ArrayList<>();
      if ("failed".equals(skillExecution.aiStatus()) && skillExecution.errorSummary() != null) {
        errors.add(skillExecution.errorSummary());
      }
      if (email.errorSummary() != null) {
        errors.add(email.errorSummary());
      }
      String status = errors.isEmpty() ? "succeeded" : "partial-failure";
      String summary = dimensionSummary(metrics, rules, advisory);
      if (configuration.dashboardEnabled()) {
        for (String dimension : selectedDimensions) {
          runStore.saveDimension(runId, dimension, summary);
        }
      }
      runStore.complete(runId, status, metrics.submittedReportCount(),
          objectMapper.writeValueAsString(metrics), objectMapper.writeValueAsString(rules), advisory,
          skillExecution.aiStatus(), artifact == null ? null : artifact.html(),
          artifact == null ? null : artifact.pdf(), artifact == null ? null : artifact.fileName(),
          email.status(), errors.isEmpty() ? null : String.join("; ", errors));
    } catch (Exception exception) {
      runStore.fail(runId, exception.getClass().getSimpleName() + ": " + exception.getMessage());
    }
    return runStore.get(runId);
  }

  private String dimensionSummary(
      ReportMetrics metrics, List<RuleConclusion> rules, String advisory) {
    return "提交 " + metrics.submittedReportCount() + "/" + metrics.activeEmployeeCount()
        + " 人；任务 " + metrics.taskCount() + " 项；项目 " + metrics.projectCount()
        + " 个；异常 " + metrics.abnormalTaskCount() + " 项；规则 " + rules.size()
        + " 条。\n" + advisory;
  }
}
