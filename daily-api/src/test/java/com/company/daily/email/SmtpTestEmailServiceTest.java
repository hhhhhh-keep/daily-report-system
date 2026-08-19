package com.company.daily.email;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

class SmtpTestEmailServiceTest {
  private AnalysisConfigurationService configurationService;
  private EmailGateway gateway;
  private SmtpTestEmailService service;

  @BeforeEach
  void setUp() {
    configurationService = mock(AnalysisConfigurationService.class);
    gateway = mock(EmailGateway.class);
    service = new SmtpTestEmailService(configurationService, gateway, new EnvironmentProperties());
  }

  @Test
  void sendsAStandaloneTestMessageUsingSavedConfiguration() {
    when(configurationService.get()).thenReturn(configuration(
        false, List.of(), "smtp.example.test", "sender@example.test"));

    SmtpTestEmailResponse response = service.send(
        List.of("manager@example.test"), List.of("audit@example.test"));

    ArgumentCaptor<EmailMessage> messageCaptor = ArgumentCaptor.forClass(EmailMessage.class);
    ArgumentCaptor<SmtpSettings> settingsCaptor = ArgumentCaptor.forClass(SmtpSettings.class);
    verify(gateway).send(messageCaptor.capture(), settingsCaptor.capture());
    assertThat(response.sent()).isTrue();
    assertThat(messageCaptor.getValue().subject()).isEqualTo("日报分析系统 SMTP 测试邮件");
    assertThat(messageCaptor.getValue().recipients()).containsExactly("manager@example.test");
    assertThat(messageCaptor.getValue().ccRecipients()).containsExactly("audit@example.test");
    assertThat(messageCaptor.getValue().attachment()).isNull();
    assertThat(settingsCaptor.getValue().host()).isEqualTo("smtp.example.test");
    assertThat(settingsCaptor.getValue().from()).isEqualTo("sender@example.test");
  }

  @Test
  void rejectsMissingTestRecipientsWithoutCallingGateway() {
    when(configurationService.get()).thenReturn(configuration(
        false, List.of(), "smtp.example.test", "sender@example.test"));

    assertThatThrownBy(() -> service.send(List.of(), List.of()))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessage("请填写测试收件人");
    verifyNoInteractions(gateway);
  }

  @Test
  void rejectsMissingSmtpHostOrSenderWithoutCallingGateway() {
    when(configurationService.get()).thenReturn(configuration(
        false, List.of(), null, null));

    assertThatThrownBy(() -> service.send(List.of("manager@example.test"), List.of()))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessage("SMTP 服务器或发件人地址未配置完整");
    verifyNoInteractions(gateway);
  }

  private AnalysisConfiguration configuration(
      boolean emailEnabled, List<String> recipients, String smtpHost, String smtpFrom) {
    return new AnalysisConfiguration(true, "0 0 22 * * ?", List.of("project-risk"), Map.of(),
        "V1", "prompt", true, true, emailEnabled, recipients,
        List.of("audit@example.test"), "日报 {{date}}", "{{content}}",
        null, null, null, smtpHost, 587, "sender@example.test", "secret", smtpFrom);
  }
}
