package com.company.daily.masterdata.api.dto;

public record AdminDictionaryResponse(
    Long id, String category, String code, String label, int sortOrder, boolean active) {}
