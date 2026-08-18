package com.company.daily.email;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodConfiguration;
import java.time.LocalDate;
import java.util.List;
import org.junit.jupiter.api.Test;

class PeriodEmailDeliverySettingsTest {
  @Test
  void resolvesWeeklyTitlesAndRecipientsIndependently() {
    AnalysisPeriodConfiguration configuration = new AnalysisPeriodConfiguration(
        AnalysisPeriod.WEEKLY, true, "0 0 9 ? * MON", List.of("project-risk"), 12, true,
        true, List.of("weekly@example.test"), List.of("copy@example.test"),
        "{{period}}分析报告｜{{date}}", "{{period}}工作分析报告（截至{{date}}）");

    PeriodEmailDeliverySettings settings = PeriodEmailDeliverySettings.from(
        configuration, LocalDate.of(2026, 8, 17));

    assertThat(settings.enabled()).isTrue();
    assertThat(settings.recipients()).containsExactly("weekly@example.test");
    assertThat(settings.ccRecipients()).containsExactly("copy@example.test");
    assertThat(settings.subject()).isEqualTo("周报分析报告｜2026-08-17");
    assertThat(settings.reportTitle()).isEqualTo("周报工作分析报告（截至2026-08-17）");
  }
}
