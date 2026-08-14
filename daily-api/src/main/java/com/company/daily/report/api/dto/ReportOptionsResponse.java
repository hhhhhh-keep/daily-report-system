package com.company.daily.report.api.dto;

import com.company.daily.masterdata.api.dto.DictionaryOption;
import com.company.daily.masterdata.api.dto.EmployeeOption;
import com.company.daily.masterdata.api.dto.NonFormalOption;
import com.company.daily.masterdata.api.dto.ProjectOption;
import java.util.List;
import java.util.Map;

public record ReportOptionsResponse(
    List<EmployeeOption> employees,
    List<ProjectOption> projects,
    Map<String, List<DictionaryOption>> dictionaries,
    List<NonFormalOption> nonFormalOptions) {}
