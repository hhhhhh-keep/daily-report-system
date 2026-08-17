package com.company.daily.config;

import java.time.Duration;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "daily")
public class EnvironmentProperties {
  private final Llm llm = new Llm();
  private final Smtp smtp = new Smtp();
  private final Administrator administrator = new Administrator();
  private String webBaseUrl = "http://localhost";

  public Llm getLlm() {
    return llm;
  }

  public Smtp getSmtp() {
    return smtp;
  }

  public Administrator getAdministrator() {
    return administrator;
  }

  public String getWebBaseUrl() {
    return webBaseUrl;
  }

  public void setWebBaseUrl(String webBaseUrl) {
    this.webBaseUrl = webBaseUrl;
  }

  public static final class Llm {
    private String endpoint = "";
    private String model = "";
    private String apiKey = "";
    private Duration skillRequestTimeout = Duration.ofSeconds(300);

    public String getEndpoint() {
      return endpoint;
    }

    public void setEndpoint(String endpoint) {
      this.endpoint = endpoint;
    }

    public String getModel() {
      return model;
    }

    public void setModel(String model) {
      this.model = model;
    }

    public String getApiKey() {
      return apiKey;
    }

    public void setApiKey(String apiKey) {
      this.apiKey = apiKey;
    }

    public Duration getSkillRequestTimeout() {
      return skillRequestTimeout;
    }

    public void setSkillRequestTimeout(Duration skillRequestTimeout) {
      this.skillRequestTimeout = skillRequestTimeout;
    }
  }

  public static final class Smtp {
    private String host = "";
    private int port = 587;
    private String username = "";
    private String password = "";
    private String from = "";

    public String getHost() { return host; }
    public void setHost(String host) { this.host = host; }
    public int getPort() { return port; }
    public void setPort(int port) { this.port = port; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getFrom() { return from; }
    public void setFrom(String from) { this.from = from; }
  }

  public static final class Administrator {
    private String username = "admin";
    private String initialPassword = "";

    public String getUsername() {
      return username;
    }

    public void setUsername(String username) {
      this.username = username;
    }

    public String getInitialPassword() {
      return initialPassword;
    }

    public void setInitialPassword(String initialPassword) {
      this.initialPassword = initialPassword;
    }
  }
}
