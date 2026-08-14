package com.company.daily.scheduling.api;

import com.company.daily.common.api.PageResponse;
import com.company.daily.scheduling.AnalysisOrchestrator;
import com.company.daily.scheduling.AnalysisRunResponse;
import com.company.daily.scheduling.AnalysisRunStore;
import com.company.daily.scheduling.DimensionResultResponse;
import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodWindowService;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin")
public class RunController {
  private final AnalysisOrchestrator orchestrator;
  private final AnalysisRunStore runStore;
  private final AnalysisPeriodWindowService windowService;

  public RunController(
      AnalysisOrchestrator orchestrator,
      AnalysisRunStore runStore,
      AnalysisPeriodWindowService windowService) {
    this.orchestrator = orchestrator;
    this.runStore = runStore;
    this.windowService = windowService;
  }

  @GetMapping("/runs")
  public PageResponse<AnalysisRunResponse> runs(
      @RequestParam(required = false, defaultValue = "0") int page,
      @RequestParam(required = false, defaultValue = "20") int size) {
    return runStore.list(page, size);
  }

  @GetMapping("/runs/{id}")
  public AnalysisRunResponse run(@PathVariable long id) { return runStore.get(id); }

  @PostMapping("/runs")
  public AnalysisRunResponse runNow(
      @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
      @RequestParam(defaultValue = "DAILY") AnalysisPeriod period) {
    LocalDate effectiveDate = date == null ? LocalDate.now(ZoneId.of("Asia/Shanghai")) : date;
    return orchestrator.run(windowService.resolve(period, effectiveDate), "manual");
  }

  @PostMapping("/runs/{id}/retry")
  public AnalysisRunResponse retry(@PathVariable long id) { return orchestrator.retry(id); }

  @GetMapping("/runs/{id}/report.pdf")
  public ResponseEntity<byte[]> report(@PathVariable long id) {
    AnalysisRunResponse run = runStore.get(id);
    return ResponseEntity.ok()
        .header(HttpHeaders.CONTENT_DISPOSITION,
            ContentDisposition.attachment().filename(run.reportFileName()).build().toString())
        .contentType(MediaType.APPLICATION_PDF)
        .body(runStore.pdf(id));
  }

  @GetMapping("/analysis/latest")
  public List<DimensionResultResponse> latestAnalysis() { return runStore.latestDimensions(); }
}
