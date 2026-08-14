package com.company.daily.masterdata.domain;

import com.company.daily.common.persistence.AuditedEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "employees")
public class Employee extends AuditedEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String name;
  private String teamName;
  private String positionType;
  private boolean active;

  protected Employee() {}

  public Employee(String name, String teamName, String positionType, boolean active) {
    update(name, teamName, positionType, active);
  }

  public void update(String name, String teamName, String positionType, boolean active) {
    this.name = name;
    this.teamName = teamName;
    this.positionType = positionType;
    this.active = active;
  }

  public void deactivate() {
    this.active = false;
  }

  public Long getId() {
    return id;
  }

  public String getName() {
    return name;
  }

  public String getTeamName() {
    return teamName;
  }

  public String getPositionType() {
    return positionType;
  }

  public boolean isActive() {
    return active;
  }
}
