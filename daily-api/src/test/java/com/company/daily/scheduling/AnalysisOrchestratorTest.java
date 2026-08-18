package com.company.daily.scheduling;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.isNull;
import static org.mockito.ArgumentMatchers.nullable;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodConfiguration;
import com.company.daily.analysis.AnalysisPeriodConfigurationService;
import com.company.daily.analysis.AnalysisPeriodWindow;
import com.company.daily.analysis.AnalysisRuleVersionService;
import com.company.daily.analysis.AnalysisSourceSnapshotService;
import com.company.daily.analysis.LlmAnalysisAdapter;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import com.company.daily.email.EmailDeliveryResult;
import com.company.daily.email.EmailService;
import com.company.daily.metrics.ReportMetrics;
import com.company.daily.metrics.ReportMetricsService;
import com.company.daily.reporting.ReportArtifact;
import com.company.daily.reporting.ReportService;
import com.company.daily.rules.AnalysisRuleService;
import com.company.daily.skills.AnalysisSkillKind;
import com.company.daily.skills.AnalysisSkillService;
import com.company.daily.skills.AnalysisSkillStatus;
import com.company.daily.skills.AnalysisSkillVersion;
import com.company.daily.skills.SkillAnalysisExecutor;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import tools.jackson.databind.ObjectMapper;

class AnalysisOrchestratorTest {
  @Test
  void recordsAiFallbackAsPartialFailureInsteadOfAiSuccess() {
    AnalysisConfigurationService configurationService = mock(AnalysisConfigurationService.class);
    ReportMetricsService metricsService = mock(ReportMetricsService.class);
    AnalysisRuleService ruleService = mock(AnalysisRuleService.class);
    ReportService reportService = mock(ReportService.class);
    EmailService emailService = mock(EmailService.class);
    AnalysisRunStore runStore = mock(AnalysisRunStore.class);
    AnalysisPeriodConfigurationService periodService = mock(AnalysisPeriodConfigurationService.class);
    AnalysisSourceSnapshotService snapshotService = mock(AnalysisSourceSnapshotService.class);
    AnalysisSkillService skillService = mock(AnalysisSkillService.class);
    SkillAnalysisExecutor executor = mock(SkillAnalysisExecutor.class);
    AnalysisPeriodWindow window = new AnalysisPeriodWindow(
        AnalysisPeriod.DAILY, LocalDate.of(2026, 7, 31), LocalDate.of(2026, 7, 31));
    AnalysisConfiguration configuration = configuration();
    ReportMetrics metrics = new ReportMetrics(window.endDate(), 95, 93, 2, 115, 6,
        55, 60, 12, 0, 0, 0, 0, 0, 0, 0);
    AnalysisSkillService.PublishedSkillPair pair = pair();
    AtomicReference<String> completedStatus = new AtomicReference<>();
    AtomicReference<String> completedLlmStatus = new AtomicReference<>();
    AtomicReference<String> completedLlmError = new AtomicReference<>();
    AtomicReference<String> completedError = new AtomicReference<>();
    AtomicReference<byte[]> completedDocument = new AtomicReference<>();
    AtomicReference<String> completedFileName = new AtomicReference<>();

    when(periodService.get(AnalysisPeriod.DAILY)).thenReturn(new AnalysisPeriodConfiguration(
        AnalysisPeriod.DAILY, true, "0 0 22 * * ?", List.of("personnel-efficiency"), 12, true));
    when(configurationService.get()).thenReturn(configuration);
    when(skillService.publishedPair(AnalysisPeriod.DAILY)).thenReturn(pair);
    when(snapshotService.build(window)).thenReturn("{}");
    when(runStore.start(eq(window), eq("manual"), anyList(), eq("{}"), isNull(), eq(0)))
        .thenReturn(41L);
    when(executor.execute(any(), any(), anyString(), anyString(), eq("{}"), any(), any()))
        .thenReturn(new SkillAnalysisExecutor.SkillExecution(
            "SUCCEEDED", "{}", null, "<section>基础报告</section>", new byte[] {1},
            "failed", "AI 语义分析不可用，已生成基础报告"));
    when(metricsService.calculate(window.startDate(), window.endDate(), 8)).thenReturn(metrics);
    when(ruleService.evaluate(eq(metrics), any())).thenReturn(List.of());
    when(reportService.generate(eq(configuration), eq(metrics), anyList(), anyString(), anyString()))
        .thenReturn(new ReportArtifact("<section>fallback</section>", new byte[] {2}, "daily.pdf"));
    when(emailService.deliver(anyLong(), eq(window.endDate()), eq(configuration), any(), any()))
        .thenReturn(new EmailDeliveryResult("not-requested", null));
    when(runStore.get(41L)).thenReturn(mock(AnalysisRunResponse.class));
    doAnswer(invocation -> {
      completedStatus.set(invocation.getArgument(1));
      completedLlmStatus.set(invocation.getArgument(6));
      completedLlmError.set(invocation.getArgument(7));
      completedDocument.set(invocation.getArgument(9));
      completedFileName.set(invocation.getArgument(10));
      completedError.set(invocation.getArgument(13));
      return null;
    }).when(runStore).complete(eq(41L), anyString(), anyInt(), anyString(), anyString(),
        anyString(), anyString(), nullable(String.class), any(), any(), anyString(), anyString(),
        anyString(), nullable(String.class));

    AnalysisOrchestrator orchestrator = new AnalysisOrchestrator(configurationService, metricsService,
        ruleService, mock(LlmAnalysisAdapter.class), reportService, emailService, runStore,
        new ObjectMapper(), periodService, mock(AnalysisRuleVersionService.class), snapshotService,
        skillService, executor);

    orchestrator.run(window, "manual");

    assertThat(completedStatus).hasValue("partial-failure");
    assertThat(completedLlmStatus).hasValue("failed");
    assertThat(completedLlmError).hasValue("AI 语义分析不可用，已生成基础报告");
    assertThat(completedDocument.get()).containsExactly((byte) 1);
    assertThat(completedFileName).hasValue("日报工作分析报告（截至2026-07-31）.docx");
    assertThat(completedError.get()).contains("基础报告");
    ArgumentCaptor<ReportArtifact> artifactCaptor = ArgumentCaptor.forClass(ReportArtifact.class);
    verify(emailService).deliver(anyLong(), eq(window.endDate()), eq(configuration), any(),
        artifactCaptor.capture());
    assertThat(artifactCaptor.getValue().content()).containsExactly((byte) 1);
    assertThat(artifactCaptor.getValue().mimeType()).isEqualTo(ReportArtifact.DOCX_MIME_TYPE);
    verify(reportService, never()).generate(any(), any(), anyList(), anyString(), anyString());

    when(runStore.start(eq(window), eq("manual"), anyList(), eq("{}"), isNull(), eq(0)))
        .thenReturn(42L);
    when(executor.execute(any(), any(), anyString(), anyString(), eq("{}"), any(), any()))
        .thenReturn(new SkillAnalysisExecutor.SkillExecution(
            "SUCCEEDED", "{}", null, "<section>基础报告</section>", null,
            "succeeded", null));
    when(runStore.get(42L)).thenReturn(mock(AnalysisRunResponse.class));

    orchestrator.run(window, "manual");

    verify(runStore).fail(42L, "IllegalStateException: Skill 未生成 Word 报告");
    verify(emailService, times(1)).deliver(anyLong(), eq(window.endDate()), eq(configuration), any(), any());
  }

  private static AnalysisConfiguration configuration() {
    return new AnalysisConfiguration(true, "0 0 22 * * ?", List.of("personnel-efficiency"),
        Map.of("vagueResultLength", 8), "V1", "prompt", true, true, false,
        List.of(), List.of(), "日报 {{date}}", "{{content}}", null, null, null,
        null, null, null, null, null);
  }

  private static AnalysisSkillService.PublishedSkillPair pair() {
    AnalysisSkillVersion rule = new AnalysisSkillVersion(1, AnalysisPeriod.DAILY,
        AnalysisSkillKind.RULE, 2, AnalysisSkillStatus.PUBLISHED, "rule", "rule", "rule.zip",
        "checksum", "ok", "python-subprocess-v1", null, null, null);
    AnalysisSkillVersion template = new AnalysisSkillVersion(2, AnalysisPeriod.DAILY,
        AnalysisSkillKind.TEMPLATE, 2, AnalysisSkillStatus.PUBLISHED, "template", "template",
        "template.zip", "checksum", "ok", "python-subprocess-v1", null, null, null);
    return new AnalysisSkillService.PublishedSkillPair(
        rule, template, "rule", "template", new byte[] {1}, new byte[] {2});
  }
}
