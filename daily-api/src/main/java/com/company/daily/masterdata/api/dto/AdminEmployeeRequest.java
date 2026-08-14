package com.company.daily.masterdata.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record AdminEmployeeRequest(
    @NotBlank String name,
    @NotBlank String teamName,
    @NotBlank String positionType,
    @NotNull Boolean active) {}
