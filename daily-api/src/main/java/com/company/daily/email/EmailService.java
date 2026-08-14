package com.company.daily.email;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.reporting.ReportArtifact;
import java.time.LocalDate;
import org.springframework.dao.DuplicateKeyException;
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
    if (!configuration.emailEnabled()) {
      return new EmailDeliveryResult("not-requested", null);
    }
    if (successfulDeliveryExists(date)) {
      save(runId, date, "skipped", configuration, null, "该日期已成功投递，跳过重复邮件");
      return new EmailDeliveryResult("skipped-duplicate", null);
    }
    String subject = configuration.emailSubjectTemplate().replace("{{date}}", date.toString());
    SmtpSettings settings = SmtpSettings.fromConfiguration(configuration, environment);
    try {
      gateway.send(new EmailMessage(configuration.recipients(), configuration.ccRecipients(),
          subject, artifact.html(), artifact.pdf(), artifact.fileName()), settings);
      save(runId, date, "sent", configuration, subject, null);
      return new EmailDeliveryResult("sent", null);
    } catch (EmailDeliveryException | DuplicateKeyException exception) {
      String error = exception instanceof DuplicateKeyException
          ? "该日期邮件已由并发运行成功投递" : exception.getMessage();
      save(runId, date, "failed", configuration, subject, error);
      return new EmailDeliveryResult("failed", error);
    }
  }

  private boolean successfulDeliveryExists(LocalDate date) {
    Integer count = jdbcTemplate.queryForObject(
        "select count(*) from email_deliveries where analysis_date=? and status='sent'",
        Integer.class, date);
    return count != null && count > 0;
  }

  private void save(
      long runId,
      LocalDate date,
      String status,
      AnalysisConfiguration configuration,
      String subject,
      String error) {
    jdbcTemplate.update("insert into email_deliveries(run_id,analysis_date,status,recipients,"
        + "cc_recipients,subject,sent_at,error_summary) values (?,?,?,?,?,?,"
        + "case when ?='sent' then current_timestamp else null end,?)",
        runId, date, status, String.join(",", configuration.recipients()),
        String.join(",", configuration.ccRecipients()), subject, status, error);
  }
}
