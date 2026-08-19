package com.company.daily.email;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.configuration.AnalysisConfigurationService;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class SmtpTestEmailService {
  private static final ZoneId BUSINESS_ZONE = ZoneId.of("Asia/Shanghai");
  private static final DateTimeFormatter TIME_FORMATTER =
      DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss XXX");

  private final AnalysisConfigurationService configurationService;
  private final EmailGateway gateway;
  private final EnvironmentProperties environment;

  public SmtpTestEmailService(
      AnalysisConfigurationService configurationService,
      EmailGateway gateway,
      EnvironmentProperties environment) {
    this.configurationService = configurationService;
    this.gateway = gateway;
    this.environment = environment;
  }

  public SmtpTestEmailResponse send(List<String> recipients, List<String> ccRecipients) {
    AnalysisConfiguration configuration = configurationService.get();
    List<String> targetRecipients = clean(recipients);
    if (targetRecipients.isEmpty()) {
      throw new IllegalArgumentException("请填写测试收件人");
    }
    SmtpSettings settings = SmtpSettings.fromConfiguration(configuration, environment);
    if (!settings.isUsable() || !StringUtils.hasText(settings.from())) {
      throw new IllegalArgumentException("SMTP 服务器或发件人地址未配置完整");
    }
    String sentAt = OffsetDateTime.now(BUSINESS_ZONE).format(TIME_FORMATTER);
    EmailMessage message = new EmailMessage(
        targetRecipients, clean(ccRecipients),
        "日报分析系统 SMTP 测试邮件",
        "<p>这是一封由日报分析系统管理员主动触发的 SMTP 测试邮件。</p>"
            + "<p>发送时间：" + sentAt + "</p>",
        null, null, null);
    gateway.send(message, settings);
    return new SmtpTestEmailResponse(
        true, "测试邮件已发送，请检查收件箱和垃圾邮件目录。");
  }

  private static List<String> clean(List<String> values) {
    return values == null ? List.of() : values.stream().filter(StringUtils::hasText)
        .map(String::trim).toList();
  }
}
