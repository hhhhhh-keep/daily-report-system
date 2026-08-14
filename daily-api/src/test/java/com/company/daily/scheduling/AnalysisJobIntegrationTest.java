package com.company.daily.scheduling;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.email.EmailDeliveryException;
import com.company.daily.DailyApiApplication;
import com.company.daily.email.EmailGateway;
import com.company.daily.email.EmailMessage;
import com.company.daily.email.SmtpSettings;
import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest(
    properties = "spring.quartz.auto-startup=false",
    classes = {DailyApiApplication.class, AnalysisJobIntegrationTest.FakeEmailConfiguration.class})
class AnalysisJobIntegrationTest extends PostgresIntegrationTest {
  @Autowired AnalysisJob job;
  @Autowired AnalysisOrchestrator orchestrator;
  @Autowired AnalysisRunStore runStore;
  @Autowired JdbcTemplate jdbcTemplate;
  @Autowired FakeEmailGateway gateway;

  @Test
  void recordsScheduledFailureAndRetriesWithoutDuplicatingSuccessfulEmail() {
    jdbcTemplate.update("update analysis_configurations set email_enabled=true,"
        + "recipients='manager@example.test',report_enabled=true where id=1");
    gateway.fail.set(true);

    job.execute(null);
    AnalysisRunResponse failedEmail = runStore.list(0, 50).items().getFirst();
    assertThat(failedEmail.triggerType()).isEqualTo("scheduled");
    assertThat(failedEmail.status()).isEqualTo("partial-failure");
    assertThat(failedEmail.emailStatus()).isEqualTo("failed");

    gateway.fail.set(false);
    AnalysisRunResponse successfulRetry = orchestrator.retry(failedEmail.id());
    assertThat(successfulRetry.status()).isEqualTo("succeeded");
    assertThat(successfulRetry.emailStatus()).isEqualTo("sent");

    AnalysisRunResponse duplicateRetry = orchestrator.retry(failedEmail.id());
    assertThat(duplicateRetry.status()).isEqualTo("succeeded");
    assertThat(duplicateRetry.emailStatus()).isEqualTo("skipped-duplicate");
    assertThat(gateway.attempts).hasValue(2);
    Integer sent = jdbcTemplate.queryForObject("select count(*) from email_deliveries "
        + "where analysis_date=? and status='sent'", Integer.class, LocalDate.now());
    assertThat(sent).isEqualTo(1);
  }

  @TestConfiguration
  static class FakeEmailConfiguration {
    @Bean
    @Primary
    FakeEmailGateway fakeEmailGateway() { return new FakeEmailGateway(); }
  }

  static class FakeEmailGateway implements EmailGateway {
    final AtomicBoolean fail = new AtomicBoolean();
    final AtomicInteger attempts = new AtomicInteger();

    @Override
    public void send(EmailMessage message, SmtpSettings settings) {
      attempts.incrementAndGet();
      if (fail.get()) {
        throw new EmailDeliveryException("模拟 SMTP 失败", new IllegalStateException("offline"));
      }
    }
  }
}
