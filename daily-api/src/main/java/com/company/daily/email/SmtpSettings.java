package com.company.daily.email;

import com.company.daily.config.EnvironmentProperties;
import com.company.daily.configuration.AnalysisConfiguration;

/**
 * 把分析配置里的 SMTP 字段与环境变量合并：DB 字段非空则覆盖 env。
 * 用于 SmtpEmailGateway 在每次发送时动态构建 jakarta.mail.Session。
 */
public record SmtpSettings(
    String host,
    int port,
    String username,
    String password,
    String from) {

  public boolean isUsable() {
    return host != null && !host.isBlank();
  }

  public static SmtpSettings fromConfiguration(
      AnalysisConfiguration configuration, EnvironmentProperties environment) {
    EnvironmentProperties.Smtp env = environment.getSmtp();
    return new SmtpSettings(
        pick(configuration.smtpHost(), env != null ? env.getHost() : null),
        configuration.smtpPort() != null ? configuration.smtpPort()
            : (env != null && env.getPort() > 0 ? env.getPort() : 587),
        pick(configuration.smtpUsername(), env != null ? env.getUsername() : null),
        pick(configuration.smtpPassword(), env != null ? env.getPassword() : null),
        pick(configuration.smtpFrom(), env != null ? env.getFrom() : null));
  }

  private static String pick(String dbValue, String envValue) {
    if (dbValue != null && !dbValue.isBlank()) {
      return dbValue.trim();
    }
    if (envValue != null && !envValue.isBlank()) {
      return envValue.trim();
    }
    return null;
  }
}
