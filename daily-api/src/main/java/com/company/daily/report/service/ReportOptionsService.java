package com.company.daily.report.service;

import com.company.daily.masterdata.service.MasterDataQueryService;
import com.company.daily.report.api.dto.ReportOptionsResponse;
import org.springframework.stereotype.Service;

@Service
public class ReportOptionsService {
  private final MasterDataQueryService masterDataQueryService;

  public ReportOptionsService(MasterDataQueryService masterDataQueryService) {
    this.masterDataQueryService = masterDataQueryService;
  }

  public ReportOptionsResponse getOptions() {
    return masterDataQueryService.getReportOptions();
  }
}
