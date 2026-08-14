package com.company.daily.report.domain;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class TimePeriodConverter implements AttributeConverter<TimePeriod, String> {
  @Override
  public String convertToDatabaseColumn(TimePeriod attribute) {
    return attribute == null ? null : attribute.value();
  }

  @Override
  public TimePeriod convertToEntityAttribute(String value) {
    return value == null ? null : TimePeriod.fromValue(value);
  }
}
