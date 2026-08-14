package com.company.daily.email;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
 * 用每封邮件独立的 Session 发送，方便在 UI 配置发件箱后无需重启服务。
 * 旧实现绑死了启动期 spring.mail.* 配置，无法热更新。
 */
@Component
public class SmtpEmailGateway implements EmailGateway {
  @Override
  public void send(EmailMessage message, SmtpSettings settings) {
    if (!settings.isUsable()) {
      throw new EmailDeliveryException("SMTP 未配置（缺少服务器地址）", null);
    }
    Session session = buildSession(settings);
    try {
      MimeMessage mime = new MimeMessage(session);
      MimeMessageHelper helper = new MimeMessageHelper(mime, true, "UTF-8");
      if (StringUtils.hasText(settings.from())) {
        helper.setFrom(settings.from());
      }
      helper.setTo(message.recipients().toArray(String[]::new));
      if (!message.ccRecipients().isEmpty()) {
        helper.setCc(message.ccRecipients().toArray(String[]::new));
      }
      helper.setSubject(message.subject());
      helper.setText(message.html(), true);
      helper.addAttachment(message.pdfFileName(), new ByteArrayResource(message.pdf()));
      jakarta.mail.Transport.send(mime);
    } catch (Exception exception) {
      throw new EmailDeliveryException("SMTP 邮件发送失败", exception);
    }
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
}
