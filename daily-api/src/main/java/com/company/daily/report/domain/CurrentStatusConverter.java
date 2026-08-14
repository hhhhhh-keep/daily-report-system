package com.company.daily.report.domain;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class CurrentStatusConverter implements AttributeConverter<CurrentStatus, String> {
  @Override
  public String convertToDatabaseColumn(CurrentStatus attribute) {
    return attribute == null ? null : attribute.value();
  }

  @Override
  public CurrentStatus convertToEntityAttribute(String value) {
    return value == null ? null : CurrentStatus.fromValue(value);
  }
}
