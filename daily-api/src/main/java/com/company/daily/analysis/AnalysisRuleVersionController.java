package com.company.daily.analysis;

import jakarta.validation.Valid;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/analysis-rule-versions")
public class AnalysisRuleVersionController {
  private final AnalysisRuleVersionService service;

  public AnalysisRuleVersionController(AnalysisRuleVersionService service) {
    this.service = service;
  }

  @GetMapping("/{period}")
  public List<AnalysisRuleVersion> list(@PathVariable AnalysisPeriod period) {
    return service.list(period);
  }

  @PostMapping("/{period}")
  public AnalysisRuleVersion create(
      @PathVariable AnalysisPeriod period, @Valid @RequestBody AnalysisRuleVersionRequest request) {
    return service.createDraft(period, request);
  }

  @PostMapping("/{id}/trial-succeeded")
  public AnalysisRuleVersion completeTrial(@PathVariable long id) {
    return service.markTrialSucceeded(id);
  }

  @PostMapping("/{id}/publish")
  public AnalysisRuleVersion publish(
      @PathVariable long id,
      @RequestParam(defaultValue = "false") boolean allowUntriedFirstVersion) {
    return service.publish(id, allowUntriedFirstVersion);
  }
}
