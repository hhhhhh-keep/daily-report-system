package com.company.daily.admin.domain;

import com.company.daily.common.persistence.AuditedEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.Instant;

@Entity
@Table(name = "administrators")
public class Administrator extends AuditedEntity {
  public static final short SINGLETON_ID = 1;

  @Id
  private Short id;

  @Column(nullable = false, unique = true)
  private String username;

  @Column(name = "password_hash", nullable = false)
  private String passwordHash;

  @Column(name = "password_changed_at")
  private Instant passwordChangedAt;

  protected Administrator() {}

  private Administrator(String username, String passwordHash) {
    this.id = SINGLETON_ID;
    this.username = username;
    this.passwordHash = passwordHash;
  }

  public static Administrator create(String username, String passwordHash) {
    return new Administrator(username, passwordHash);
  }

  public void changePassword(String passwordHash) {
    this.passwordHash = passwordHash;
    this.passwordChangedAt = Instant.now();
  }

  public Short getId() {
    return id;
  }

  public String getUsername() {
    return username;
  }

  public String getPasswordHash() {
    return passwordHash;
  }

  public Instant getPasswordChangedAt() {
    return passwordChangedAt;
  }
}
