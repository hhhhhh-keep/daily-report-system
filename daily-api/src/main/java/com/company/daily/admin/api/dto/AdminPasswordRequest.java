package com.company.daily.admin.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record AdminPasswordRequest(
    @NotBlank String currentPassword,
    @NotBlank @Size(min = 8, max = 200) String newPassword) {}
