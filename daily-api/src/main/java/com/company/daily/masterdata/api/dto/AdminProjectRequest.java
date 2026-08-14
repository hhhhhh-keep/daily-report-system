package com.company.daily.masterdata.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record AdminProjectRequest(
    @NotBlank String name,
    String customerName,
    String industry,
    String projectStage,
    String ownerName,
    String priority,
    @NotBlank String status,
    String code,
    @NotNull Boolean formal,
    String systemKey,
    @NotNull Boolean active) {}
