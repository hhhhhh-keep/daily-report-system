package com.company.daily.configuration;

import jakarta.validation.Valid;
import com.company.daily.scheduling.AnalysisScheduleManager;
import org.quartz.SchedulerException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.company.daily.analysis.LlmAnalysisAdapter;

@RestController
@RequestMapping("/api/admin/configuration/analysis")
public class AnalysisConfigurationController {
  private final AnalysisConfigurationService service;
  private final AnalysisScheduleManager scheduleManager;
  private final LlmAnalysisAdapter llmAdapter;

  public AnalysisConfigurationController(
      AnalysisConfigurationService service, AnalysisScheduleManager scheduleManager, LlmAnalysisAdapter llmAdapter) {
    this.service = service;
    this.scheduleManager = scheduleManager;
    this.llmAdapter = llmAdapter;
  }

  @GetMapping
  public AnalysisConfiguration get() { return service.get(); }

  @PutMapping
  public AnalysisConfiguration update(@Valid @RequestBody AnalysisConfigurationRequest request)
      throws SchedulerException {
    AnalysisConfiguration updated = service.update(request);
    scheduleManager.reschedule();
    return updated;
  }

  @org.springframework.web.bind.annotation.PostMapping("/test-connection")
  public AnalysisConnectionTestResponse testConnection(@RequestBody AnalysisConnectionTestRequest request) {
    var result = llmAdapter.testConnection(request.modelEndpoint(), request.modelName(), request.modelApiKey());
    return new AnalysisConnectionTestResponse("succeeded".equals(result.status()),
        result.errorSummary() == null ? "模型连接成功" : result.errorSummary());
  }
}
