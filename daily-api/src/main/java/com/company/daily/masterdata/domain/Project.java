package com.company.daily.masterdata.domain;

import com.company.daily.common.persistence.AuditedEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "projects")
public class Project extends AuditedEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String name;
  private String customerName;
  private String industry;
  private String projectStage;
  private String ownerName;
  private String priority;
  private String status;
  private String code;
  private boolean formal;
  private String systemKey;
  private boolean active;

  protected Project() {}

  public Project(
      String name,
      String customerName,
      String industry,
      String projectStage,
      String ownerName,
      String priority,
      String status,
      String code,
      boolean formal,
      String systemKey,
      boolean active) {
    update(name, customerName, industry, projectStage, ownerName, priority, status, code,
        formal, systemKey, active);
  }

  public void update(
      String name,
      String customerName,
      String industry,
      String projectStage,
      String ownerName,
      String priority,
      String status,
      String code,
      boolean formal,
      String systemKey,
      boolean active) {
    this.name = name;
    this.customerName = customerName;
    this.industry = industry;
    this.projectStage = projectStage;
    this.ownerName = ownerName;
    this.priority = priority;
    this.status = status;
    this.code = code;
    this.formal = formal;
    this.systemKey = systemKey;
    this.active = active;
  }

  public void deactivate() { this.active = false; }

  public Long getId() { return id; }
  public String getName() { return name; }
  public String getCustomerName() { return customerName; }
  public String getIndustry() { return industry; }
  public String getProjectStage() { return projectStage; }
  public String getOwnerName() { return ownerName; }
  public String getPriority() { return priority; }
  public String getStatus() { return status; }
  public String getCode() { return code; }
  public boolean isFormal() { return formal; }
  public String getSystemKey() { return systemKey; }
  public boolean isActive() { return active; }
}
