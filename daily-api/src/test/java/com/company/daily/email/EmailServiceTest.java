package com.company.daily.email;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.reporting.ReportArtifact;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;

class EmailServiceTest {
  @Test
  void skipsGatewayWhenTheDateAlreadyHasASuccessfulDelivery() {
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    EmailGateway gateway = mock(EmailGateway.class);
    LocalDate date = LocalDate.of(2026, 8, 10);
    when(jdbcTemplate.queryForObject(anyString(), eq(Integer.class), eq(date))).thenReturn(1);

    EmailDeliveryResult result = new EmailService(jdbcTemplate, gateway, new EnvironmentProperties())
        .deliver(7, date, configuration(), new ReportArtifact("<h1>report</h1>",
            new byte[] {1}, "r.pdf"));

    assertThat(result.status()).isEqualTo("skipped-duplicate");
    verifyNoInteractions(gateway);
  }

  private AnalysisConfiguration configuration() {
    return new AnalysisConfiguration(true, "0 0 22 * * ?", List.of("project-risk"), Map.of(),
        "V1", "prompt", true, true, true, List.of("manager@example.test"), List.of(),
        "日报 {{date}}", "{{content}}", null, null, null, null, null, null, null, null);
  }
}
