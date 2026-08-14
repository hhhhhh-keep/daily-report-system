package com.company.daily.skills.api;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.skills.AnalysisSkillKind;
import com.company.daily.skills.AnalysisSkillService;
import com.company.daily.skills.AnalysisSkillTrial;
import com.company.daily.skills.AnalysisSkillVersion;
import java.time.LocalDate;
import java.util.List;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/admin/analysis-skills")
public class AnalysisSkillController {
  private final AnalysisSkillService service;

  public AnalysisSkillController(AnalysisSkillService service) {
    this.service = service;
  }

  @GetMapping("/{period}/{kind}")
  public List<AnalysisSkillVersion> list(
      @PathVariable AnalysisPeriod period, @PathVariable AnalysisSkillKind kind) {
    return service.list(period, kind);
  }

  @PostMapping(path = "/{period}/{kind}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  public AnalysisSkillVersion upload(
      @PathVariable AnalysisPeriod period,
      @PathVariable AnalysisSkillKind kind,
      @RequestParam("file") MultipartFile file) throws Exception {
    if (file.isEmpty() || file.getOriginalFilename() == null || !file.getOriginalFilename().endsWith(".zip")) {
      throw new IllegalArgumentException("请选择 ZIP 格式的 Skill 包");
    }
    return service.upload(period, kind, file.getOriginalFilename(), file.getBytes());
  }

  @GetMapping("/download/{id}")
  public ResponseEntity<byte[]> download(@PathVariable long id) {
    return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=skill.zip")
        .contentType(MediaType.APPLICATION_OCTET_STREAM).body(service.download(id));
  }

  @PostMapping("/{period}/trial")
  public AnalysisSkillTrial trial(
      @PathVariable AnalysisPeriod period,
      @RequestParam LocalDate endDate,
      @RequestParam long ruleVersionId,
      @RequestParam long templateVersionId) {
    return service.trial(period, endDate, ruleVersionId, templateVersionId);
  }

  @GetMapping("/{period}/trials")
  public List<AnalysisSkillTrial> trials(@PathVariable AnalysisPeriod period) {
    return service.trials(period);
  }

  @PostMapping("/{period}/publish")
  public void publish(
      @PathVariable AnalysisPeriod period,
      @RequestParam long ruleVersionId,
      @RequestParam long templateVersionId) {
    service.publishPair(period, ruleVersionId, templateVersionId);
  }
}
