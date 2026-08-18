package com.company.daily.email;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.reporting.ReportArtifact;
import java.time.LocalDate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
  private final JdbcTemplate jdbcTemplate;
  private final EmailGateway gateway;
  private final EnvironmentProperties environment;

  public EmailService(JdbcTemplate jdbcTemplate, EmailGateway gateway,
      EnvironmentProperties environment) {
    this.jdbcTemplate = jdbcTemplate;
    this.gateway = gateway;
    this.environment = environment;
  }

  public EmailDeliveryResult deliver(
      long runId,
      LocalDate date,
      AnalysisConfiguration configuration,
      ReportArtifact artifact) {
    return deliver(runId, date, configuration, new PeriodEmailDeliverySettings(
        configuration.emailEnabled(), configuration.recipients(), configuration.ccRecipients(),
        configuration.emailSubjectTemplate().replace("{{date}}", date.toString()), ""), artifact);
  }

  public EmailDeliveryResult deliver(
      long runId,
      LocalDate date,
      AnalysisConfiguration configuration,
      PeriodEmailDeliverySettings delivery,
      ReportArtifact artifact) {
    if (!delivery.enabled()) {
      return new EmailDeliveryResult("not-requested", null);
    }
    if (delivery.recipients().isEmpty()) {
      String error = "该周期已启用邮件发送，但未配置收件人";
      save(runId, date, "failed", delivery, error);
      return new EmailDeliveryResult("failed", error);
    }
    SmtpSettings settings = SmtpSettings.fromConfiguration(configuration, environment);
    try {
      gateway.send(new EmailMessage(delivery.recipients(), delivery.ccRecipients(), delivery.subject(),
          artifact.html(), artifact.content(), artifact.fileName(), artifact.mimeType()), settings);
      save(runId, date, "sent", delivery, null);
      return new EmailDeliveryResult("sent", null);
    } catch (EmailDeliveryException exception) {
      String error = exception.getMessage();
      save(runId, date, "failed", delivery, error);
      return new EmailDeliveryResult("failed", error);
    }
  }

  private void save(
      long runId,
      LocalDate date,
      String status,
      PeriodEmailDeliverySettings delivery,
      String error) {
    jdbcTemplate.update("insert into email_deliveries(run_id,analysis_date,status,recipients,"
        + "cc_recipients,subject,sent_at,error_summary) values (?,?,?,?,?,?,"
        + "case when ?='sent' then current_timestamp else null end,?)",
        runId, date, status, String.join(",", delivery.recipients()),
        String.join(",", delivery.ccRecipients()), delivery.subject(), status, error);
  }
}
