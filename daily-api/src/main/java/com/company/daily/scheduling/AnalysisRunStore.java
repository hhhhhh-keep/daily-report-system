package com.company.daily.scheduling;

import com.company.daily.common.api.ResourceNotFoundException;
import com.company.daily.analysis.AnalysisPeriodWindow;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

@Repository
public class AnalysisRunStore {
  private final JdbcTemplate jdbcTemplate;

  public AnalysisRunStore(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  public long start(
      LocalDate date, String triggerType, List<String> dimensions, Long retryOf, int retryCount) {
    return jdbcTemplate.queryForObject("insert into analysis_runs(analysis_date,trigger_type,status,"
        + "selected_dimensions,started_at,retry_of_run_id,retry_count) "
        + "values (?,?,'running',?,current_timestamp,?,?) returning id", Long.class,
        date, triggerType, String.join(",", dimensions), retryOf, retryCount);
  }

  public long start(
      AnalysisPeriodWindow window,
      String triggerType,
      List<String> dimensions,
      String sourceSnapshot,
      Long retryOf,
      int retryCount) {
    return jdbcTemplate.queryForObject("insert into analysis_runs(analysis_date,analysis_period,"
        + "period_start,period_end,trigger_type,status,selected_dimensions,started_at,"
        + "source_snapshot_json,retry_of_run_id,retry_count) values (?,?,?,?,?,'running',?,"
        + "current_timestamp,?,?,?) returning id", Long.class, window.endDate(),
        window.period().name(), window.startDate(), window.endDate(), triggerType,
        String.join(",", dimensions), sourceSnapshot, retryOf, retryCount);
  }

  public void complete(
      long id,
      String status,
      int employeeCount,
      String metricsJson,
      String rulesJson,
      String advisory,
      String llmStatus,
      String llmErrorSummary,
      String html,
      byte[] reportContent,
      String fileName,
      String mimeType,
      String emailStatus,
      String errorSummary) {
    jdbcTemplate.update("update analysis_runs set status=?,finished_at=current_timestamp,"
        + "analyzed_employee_count=?,metrics_json=?,rules_json=?,advisory_text=?,llm_status=?,llm_error_summary=?,"
        + "report_html=?,report_pdf=?,report_file_name=?,report_mime_type=?,email_status=?,error_summary=?,"
        + "updated_at=current_timestamp where id=?", status, employeeCount, metricsJson, rulesJson,
        advisory, llmStatus, llmErrorSummary, html, reportContent, fileName, mimeType, emailStatus,
        errorSummary, id);
  }

  public void fail(long id, String error) {
    jdbcTemplate.update("update analysis_runs set status='failed',finished_at=current_timestamp,"
        + "error_summary=?,updated_at=current_timestamp where id=?", error, id);
  }

  public void saveVersionSnapshot(
      long id, long ruleVersionId, String rules, String prompt, String schema, String modelName) {
    jdbcTemplate.update("update analysis_runs set rule_version_id=?,rule_snapshot_json=?,"
        + "prompt_snapshot=?,schema_snapshot_json=?,model_name_snapshot=? where id=?", ruleVersionId,
        rules, prompt, schema, modelName, id);
  }

  public void saveSkillVersionSnapshot(long id, long ruleSkillVersionId, long templateSkillVersionId) {
    jdbcTemplate.update("update analysis_runs set rule_skill_version_id=?,template_skill_version_id=? where id=?",
        ruleSkillVersionId, templateSkillVersionId, id);
  }

  public void saveDimension(long runId, String dimension, String result) {
    jdbcTemplate.update("insert into analysis_dimension_results(run_id,dimension,result_text) "
        + "values (?,?,?) on conflict(run_id,dimension) do update set result_text=excluded.result_text",
        runId, dimension, result);
  }

  public com.company.daily.common.api.PageResponse<AnalysisRunResponse> list(int page, int size) {
    int safePage = Math.max(0, page);
    int safeSize = size <= 0 ? 20 : Math.min(size, 100);
    long total = jdbcTemplate.queryForObject("select count(*) from analysis_runs", Long.class);
    int offset = safePage * safeSize;
    List<AnalysisRunResponse> items = jdbcTemplate.query(
        "select * from analysis_runs order by started_at desc limit ? offset ?", this::map,
        safeSize, offset);
    return com.company.daily.common.api.PageResponse.of(items, total, safePage, safeSize);
  }

  public AnalysisRunResponse get(long id) {
    List<AnalysisRunResponse> values = jdbcTemplate.query(
        "select * from analysis_runs where id=?", this::map, id);
    if (values.isEmpty()) {
      throw new ResourceNotFoundException("分析运行不存在");
    }
    return values.getFirst();
  }

  public byte[] pdf(long id) {
    byte[] value = jdbcTemplate.query("select report_pdf from analysis_runs where id=?",
        rs -> rs.next() ? rs.getBytes(1) : null, id);
    if (value == null) {
      throw new ResourceNotFoundException("该运行没有 PDF 报告");
    }
    return value;
  }

  public byte[] report(long id) {
    byte[] value = jdbcTemplate.query("select report_pdf from analysis_runs where id=?",
        rs -> rs.next() ? rs.getBytes(1) : null, id);
    if (value == null) {
      throw new ResourceNotFoundException("该运行没有报告附件");
    }
    return value;
  }

  public List<String> taskTexts(LocalDate date) {
    return jdbcTemplate.query("select e.name || ' / ' || p.name || ': ' || t.progress_result "
        + "from daily_tasks t join daily_reports r on r.id=t.report_id "
        + "join employees e on e.id=r.employee_id join projects p on p.id=t.project_id "
        + "where r.report_date=? and p.active=true order by e.name,t.id", (rs, row) -> rs.getString(1), date);
  }

  public List<String> taskTexts(LocalDate startDate, LocalDate endDate) {
    return jdbcTemplate.query("select e.name || ' / ' || p.name || ': ' || t.progress_result "
        + "from daily_tasks t join daily_reports r on r.id=t.report_id "
        + "join employees e on e.id=r.employee_id join projects p on p.id=t.project_id "
        + "where r.report_date between ? and ? and p.active=true order by r.report_date,e.name,t.id",
        (rs, row) -> rs.getString(1), startDate, endDate);
  }

  public List<DimensionResultResponse> latestDimensions() {
    return jdbcTemplate.query("select d.dimension,d.result_text,r.id,r.analysis_date "
        + "from analysis_dimension_results d join analysis_runs r on r.id=d.run_id "
        + "where r.id=(select max(id) from analysis_runs where status in ('succeeded','partial-failure')) "
        + "order by d.dimension", (rs, row) -> new DimensionResultResponse(
            rs.getLong("id"), rs.getObject("analysis_date", LocalDate.class),
            rs.getString("dimension"), rs.getString("result_text")));
  }

  private AnalysisRunResponse map(ResultSet rs, int row) throws SQLException {
    String dimensions = rs.getString("selected_dimensions");
    Instant finished = rs.getTimestamp("finished_at") == null
        ? null : rs.getTimestamp("finished_at").toInstant();
    Long retryOf = rs.getObject("retry_of_run_id", Long.class);
    return new AnalysisRunResponse(rs.getLong("id"), rs.getObject("analysis_date", LocalDate.class),
        rs.getString("analysis_period"), rs.getObject("period_start", LocalDate.class),
        rs.getObject("period_end", LocalDate.class), rs.getObject("rule_version_id", Long.class),
        rs.getString("prompt_version_snapshot"), rs.getString("task_name"),
        rs.getString("trigger_type"), rs.getString("status"),
        StringUtils.hasText(dimensions) ? Arrays.asList(dimensions.split(",")) : List.of(),
        rs.getTimestamp("started_at").toInstant(), finished,
        rs.getInt("analyzed_employee_count"), rs.getString("metrics_json"),
        rs.getString("rules_json"), rs.getString("advisory_text"), rs.getString("llm_status"),
        rs.getString("llm_error_summary"),
        rs.getBytes("report_pdf") != null, rs.getString("report_file_name"),
        rs.getString("report_mime_type"),
        rs.getString("email_status"), rs.getString("error_summary"), retryOf,
        rs.getInt("retry_count"));
  }
}
