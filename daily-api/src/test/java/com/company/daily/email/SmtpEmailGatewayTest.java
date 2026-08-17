package com.company.daily.email;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;
import static org.mockito.Mockito.mockStatic;

import jakarta.mail.Transport;
import org.eclipse.angus.mail.smtp.SMTPSendFailedException;
import jakarta.mail.internet.MimeMessage;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.MockedStatic;

class SmtpEmailGatewayTest {
  @Test
  void summarizesSmtpFailureWithoutProviderMessage() {
    SMTPSendFailedException failure = new SMTPSendFailedException(
        "provider text must not be logged", 550, "provider detail", null, null, null, null);

    assertThat(SmtpEmailGateway.failureSummary(failure))
        .isEqualTo("SMTPSendFailedException smtpCode=550");
  }

  @Test
  void sendsMessageWithoutAttachment() throws Exception {
    EmailMessage message = new EmailMessage(List.of("manager@example.test"), List.of(),
        "测试邮件", "<p>测试正文</p>", null, null);
    SmtpSettings settings = new SmtpSettings(
        "smtp.example.test", 25, null, null, "sender@example.test");

    try (MockedStatic<Transport> transport = mockStatic(Transport.class)) {
      assertThatCode(() -> new SmtpEmailGateway().send(message, settings))
          .doesNotThrowAnyException();
      ArgumentCaptor<MimeMessage> messageCaptor = ArgumentCaptor.forClass(MimeMessage.class);
      transport.verify(() -> Transport.send(messageCaptor.capture()));
      assertThat(messageCaptor.getValue().getContent()).isInstanceOf(String.class);
      assertThat(messageCaptor.getValue().getContentType()).startsWith("text/plain");
    }
  }
}
