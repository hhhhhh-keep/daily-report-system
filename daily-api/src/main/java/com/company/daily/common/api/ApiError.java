package com.company.daily.common.api;

import java.time.Instant;
import java.util.Map;

public record ApiError(
    String code,
    String message,
    Map<String, String> fieldErrors,
    String correlationId,
    Instant timestamp) {}
