package com.company.daily.admin.service;

import com.company.daily.admin.domain.Administrator;
import com.company.daily.admin.repository.AdministratorRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class AdminSessionService {
  private final AdministratorRepository repository;
  private final PasswordEncoder passwordEncoder;

  public AdminSessionService(
      AdministratorRepository repository, PasswordEncoder passwordEncoder) {
    this.repository = repository;
    this.passwordEncoder = passwordEncoder;
  }

  @Transactional(readOnly = true)
  public AdminIdentity authenticate(String username, String password) {
    Administrator administrator = repository.findByUsername(username)
        .orElseThrow(InvalidCredentialsException::new);
    if (!passwordEncoder.matches(password, administrator.getPasswordHash())) {
      throw new InvalidCredentialsException();
    }
    return new AdminIdentity(administrator.getUsername());
  }

  @Transactional
  public void changePassword(String username, String currentPassword, String newPassword) {
    Administrator administrator = repository.findByUsername(username)
        .orElseThrow(InvalidCredentialsException::new);
    if (!passwordEncoder.matches(currentPassword, administrator.getPasswordHash())) {
      throw new InvalidCredentialsException();
    }
    if (!StringUtils.hasText(newPassword) || newPassword.length() < 8) {
      throw new IllegalArgumentException("新密码至少需要 8 个字符");
    }
    administrator.changePassword(passwordEncoder.encode(newPassword));
  }
}
