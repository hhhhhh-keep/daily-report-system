package com.company.daily.masterdata.domain;

import com.company.daily.common.persistence.AuditedEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "business_dictionaries")
public class BusinessDictionary extends AuditedEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String category;
  private String code;
  private String label;
  private int sortOrder;
  private boolean active;

  protected BusinessDictionary() {}

  public BusinessDictionary(
      String category, String code, String label, int sortOrder, boolean active) {
    update(category, code, label, sortOrder, active);
  }

  public void update(String category, String code, String label, int sortOrder, boolean active) {
    this.category = category;
    this.code = code;
    this.label = label;
    this.sortOrder = sortOrder;
    this.active = active;
  }

  public void deactivate() { this.active = false; }

  public Long getId() { return id; }
  public String getCategory() { return category; }
  public String getCode() { return code; }
  public String getLabel() { return label; }
  public int getSortOrder() { return sortOrder; }
  public boolean isActive() { return active; }
}
