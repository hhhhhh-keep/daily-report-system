package com.company.daily.config;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class EnvironmentPropertiesTest {
  @Test
  void exposesEnvironmentManagedIntegrationSettings() {
    EnvironmentProperties properties = new EnvironmentProperties();
    properties.getLlm().setEndpoint("https://llm.example.test");
    properties.getSmtp().setFrom("daily@example.test");

    assertThat(properties.getLlm().getEndpoint()).isEqualTo("https://llm.example.test");
    assertThat(properties.getSmtp().getFrom()).isEqualTo("daily@example.test");
  }
}
