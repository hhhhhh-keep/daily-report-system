package com.company.daily.email;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.util.HtmlUtils;

/**
 * 用每封邮件独立的 Session 发送，方便在 UI 配置发件箱后无需重启服务。
 * 旧实现绑死了启动期 spring.mail.* 配置，无法热更新。
 */
@Component
public class SmtpEmailGateway implements EmailGateway {
  private static final Logger LOGGER = LoggerFactory.getLogger(SmtpEmailGateway.class);

  @Override
  public void send(EmailMessage message, SmtpSettings settings) {
    if (!settings.isUsable()) {
      throw new EmailDeliveryException("SMTP 未配置（缺少服务器地址）", null);
    }
    Session session = buildSession(settings);
    try {
      MimeMessage mime = new MimeMessage(session);
      boolean hasAttachment = message.pdf() != null
          && StringUtils.hasText(message.pdfFileName());
      MimeMessageHelper helper = new MimeMessageHelper(mime, hasAttachment, "UTF-8");
      if (StringUtils.hasText(settings.from())) {
        helper.setFrom(settings.from());
      }
      helper.setTo(message.recipients().toArray(String[]::new));
      if (!message.ccRecipients().isEmpty()) {
        helper.setCc(message.ccRecipients().toArray(String[]::new));
      }
      helper.setSubject(message.subject());
      helper.setText(toPlainText(message.html()), false);
      if (hasAttachment) {
        helper.addAttachment(message.pdfFileName(), new ByteArrayResource(message.pdf()));
      }
      jakarta.mail.Transport.send(mime);
    } catch (Exception exception) {
      LOGGER.warn("SMTP delivery failed: {}", failureSummary(exception));
      throw new EmailDeliveryException("SMTP 邮件发送失败", exception);
    }
  }

  static String failureSummary(Throwable failure) {
    Throwable current = failure;
    while (current != null) {
      try {
        Object code = current.getClass().getMethod("getReturnCode").invoke(current);
        return current.getClass().getSimpleName() + " smtpCode=" + code;
      } catch (ReflectiveOperationException ignored) {
        // The Jakarta Mail API does not expose provider-specific SMTP return codes.
      }
      current = current.getCause();
    }
    return failure.getClass().getSimpleName();
  }

  private static Session buildSession(SmtpSettings settings) {
    Properties props = new Properties();
    props.put("mail.smtp.host", settings.host());
    props.put("mail.smtp.port", String.valueOf(settings.port()));
    props.put("mail.smtp.auth", String.valueOf(hasAuth(settings)));
    if (settings.port() == 465) {
      props.put("mail.smtp.ssl.enable", "true");
    } else if (settings.port() == 587) {
      props.put("mail.smtp.starttls.enable", "true");
    }
    props.put("mail.smtp.connectiontimeout", "10000");
    props.put("mail.smtp.timeout", "20000");
    props.put("mail.smtp.writetimeout", "20000");
    if (!hasAuth(settings)) {
      return Session.getInstance(props);
    }
    return Session.getInstance(props, new Authenticator() {
      @Override protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(settings.username(), settings.password());
      }
    });
  }

  private static boolean hasAuth(SmtpSettings settings) {
    return StringUtils.hasText(settings.username());
  }

  private static String toPlainText(String html) {
    if (!StringUtils.hasText(html)) {
      return "日报分析报告已生成，请查收附件。";
    }
    String withLines = html
        .replaceAll("(?i)<br\\s*/?>", "\n")
        .replaceAll("(?i)</(?:p|div|li|h[1-6]|tr|section)>", "\n");
    String plain = HtmlUtils.htmlUnescape(withLines.replaceAll("(?s)<[^>]*>", " "))
        .replaceAll("[ \\t]+", " ")
        .replaceAll(" *\\n+ *", "\n")
        .trim();
    return plain.isBlank() ? "日报分析报告已生成，请查收附件。" : plain;
  }
}
