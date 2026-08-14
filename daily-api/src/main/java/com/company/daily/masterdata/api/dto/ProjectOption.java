package com.company.daily.masterdata.api.dto;

public record ProjectOption(
    Long id,
    String name,
    String customerName,
    String industry,
    String projectStage,
    String ownerName,
    String priority,
    String status,
    String code) {}
