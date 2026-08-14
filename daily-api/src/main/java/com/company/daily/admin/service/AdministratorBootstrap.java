package com.company.daily.admin.service;

import com.company.daily.admin.domain.Administrator;
import com.company.daily.admin.repository.AdministratorRepository;
import com.company.daily.config.EnvironmentProperties;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Component
public class AdministratorBootstrap implements ApplicationRunner {
  private final AdministratorRepository repository;
  private final PasswordEncoder passwordEncoder;
  private final EnvironmentProperties properties;

  public AdministratorBootstrap(
      AdministratorRepository repository,
      PasswordEncoder passwordEncoder,
      EnvironmentProperties properties) {
    this.repository = repository;
    this.passwordEncoder = passwordEncoder;
    this.properties = properties;
  }

  @Override
  @Transactional
  public void run(ApplicationArguments arguments) {
    if (repository.existsById(Administrator.SINGLETON_ID)) {
      return;
    }
    String username = properties.getAdministrator().getUsername();
    String initialPassword = properties.getAdministrator().getInitialPassword();
    if (!StringUtils.hasText(username) || !StringUtils.hasText(initialPassword)) {
      throw new IllegalStateException("首次启动必须配置 ADMIN_USERNAME 和 ADMIN_INITIAL_PASSWORD");
    }
    repository.save(Administrator.create(username.trim(), passwordEncoder.encode(initialPassword)));
  }
}
