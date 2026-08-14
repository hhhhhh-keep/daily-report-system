package com.company.daily.migration;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.support.PostgresIntegrationTest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest(properties = "spring.quartz.auto-startup=false")
class ModelApiKeyMigrationTest extends PostgresIntegrationTest {
  @Autowired JdbcTemplate jdbcTemplate;

  @Test
  void acceptsModelApiKeysLongerThanOneHundredAndTwentyCharacters() {
    String apiKey = "k".repeat(121);

    jdbcTemplate.update("update analysis_configurations set model_api_key = ? where id = 1", apiKey);

    Integer savedLength = jdbcTemplate.queryForObject(
        "select length(model_api_key) from analysis_configurations where id = 1", Integer.class);
    assertThat(savedLength).isEqualTo(121);
  }
}
