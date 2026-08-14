package com.company.daily.masterdata.api.dto;

public record AdminProjectResponse(
    Long id,
    String name,
    String customerName,
    String industry,
    String projectStage,
    String ownerName,
    String priority,
    String status,
    String code,
    boolean formal,
    String systemKey,
    boolean active) {}
