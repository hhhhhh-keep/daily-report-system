package com.company.daily.masterdata.api.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record AdminDictionaryRequest(
    @NotBlank String category,
    @NotBlank String code,
    @NotBlank String label,
    @Min(0) int sortOrder,
    @NotNull Boolean active) {}
