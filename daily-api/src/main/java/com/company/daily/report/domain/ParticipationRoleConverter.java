package com.company.daily.report.domain;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class ParticipationRoleConverter implements AttributeConverter<ParticipationRole, String> {
  @Override
  public String convertToDatabaseColumn(ParticipationRole attribute) {
    return attribute == null ? null : attribute.value();
  }

  @Override
  public ParticipationRole convertToEntityAttribute(String value) {
    return value == null ? null : ParticipationRole.fromValue(value);
  }
}
