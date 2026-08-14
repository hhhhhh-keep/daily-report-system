package com.company.daily.admin;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.company.daily.admin.domain.Administrator;
import com.company.daily.admin.repository.AdministratorRepository;
import com.company.daily.admin.service.AdminSessionService;
import com.company.daily.support.PostgresIntegrationTest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootTest
class AdminSessionServiceTest extends PostgresIntegrationTest {
  @Autowired private AdminSessionService sessionService;
  @Autowired private AdministratorRepository administratorRepository;
  @Autowired private PasswordEncoder passwordEncoder;

  @Test
  void bootstrapsExactlyOneHashedAdministratorAndAuthenticatesIt() {
    Administrator administrator = administratorRepository.findById((short) 1).orElseThrow();

    assertThat(administratorRepository.count()).isEqualTo(1);
    assertThat(administrator.getPasswordHash()).doesNotContain("integration-test-only");
    assertThat(passwordEncoder.matches("integration-test-only", administrator.getPasswordHash())).isTrue();
    assertThat(sessionService.authenticate("admin", "integration-test-only").username()).isEqualTo("admin");
    assertThatThrownBy(() -> sessionService.authenticate("admin", "错误密码"))
        .isInstanceOf(IllegalArgumentException.class);
  }

  @Test
  void changesPasswordOnlyWhenTheCurrentPasswordMatches() {
    assertThatThrownBy(() -> sessionService.changePassword("admin", "错误密码", "new-password-123"))
        .isInstanceOf(IllegalArgumentException.class);

    sessionService.changePassword("admin", "integration-test-only", "new-password-123");

    assertThatThrownBy(() -> sessionService.authenticate("admin", "integration-test-only"))
        .isInstanceOf(IllegalArgumentException.class);
    assertThat(sessionService.authenticate("admin", "new-password-123").username()).isEqualTo("admin");
  }
}
