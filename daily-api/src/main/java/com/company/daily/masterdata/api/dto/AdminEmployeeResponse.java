package com.company.daily.masterdata.api.dto;

public record AdminEmployeeResponse(
    Long id, String name, String teamName, String positionType, boolean active) {}
