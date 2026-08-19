package com.company.daily.skills;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.argThat;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodWindow;
import com.company.daily.analysis.AnalysisPeriodWindowService;
import com.company.daily.analysis.AnalysisSourceSnapshotService;
import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

class AnalysisSkillServicePersistenceTest {
  @Test
  @SuppressWarnings("unchecked")
  void trialListDoesNotFetchSourceSnapshots() {
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    when(jdbcTemplate.query(anyString(), any(RowMapper.class), eq("DAILY"))).thenReturn(List.of());
    AnalysisSkillService service = new AnalysisSkillService(jdbcTemplate,
        mock(SkillPackageValidator.class), mock(AnalysisPeriodWindowService.class),
        mock(AnalysisSourceSnapshotService.class), mock(SkillAnalysisExecutor.class));

    service.trials(AnalysisPeriod.DAILY);

    verify(jdbcTemplate).query(argThat(sql -> !sql.contains("*")
        && !sql.contains("source_snapshot_json")), any(RowMapper.class), eq("DAILY"));
  }

  @Test
  void deletingDraftVersionRemovesItsTrialHistory() {
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    AnalysisSkillService service = spy(new AnalysisSkillService(jdbcTemplate,
        mock(SkillPackageValidator.class), mock(AnalysisPeriodWindowService.class),
        mock(AnalysisSourceSnapshotService.class), mock(SkillAnalysisExecutor.class)));
    doReturn(version(1, AnalysisSkillKind.RULE)).when(service).get(1);
    service.delete(1);

    verify(jdbcTemplate).update("delete from analysis_skill_trials where rule_skill_version_id=? or template_skill_version_id=?",
        1L, 1L);
    verify(jdbcTemplate).update("delete from analysis_skill_versions where id=?", 1L);
  }

  @Test
  void persistsRunningTrialBeforeStartingTheLongModelExecution() {
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    AnalysisPeriodWindowService windowService = mock(AnalysisPeriodWindowService.class);
    AnalysisSourceSnapshotService snapshotService = mock(AnalysisSourceSnapshotService.class);
    SkillAnalysisExecutor executor = mock(SkillAnalysisExecutor.class);
    AnalysisSkillService service = spy(new AnalysisSkillService(
        jdbcTemplate, mock(SkillPackageValidator.class), windowService, snapshotService, executor));
    AnalysisSkillVersion rule = version(1, AnalysisSkillKind.RULE);
    AnalysisSkillVersion template = version(2, AnalysisSkillKind.TEMPLATE);
    doReturn(rule).when(service).get(1);
    doReturn(template).when(service).get(2);
    LocalDate date = LocalDate.of(2026, 8, 14);
    when(windowService.resolve(AnalysisPeriod.DAILY, date))
        .thenReturn(new AnalysisPeriodWindow(AnalysisPeriod.DAILY, date, date));
    when(snapshotService.build(any())).thenReturn("{}");
    when(jdbcTemplate.queryForObject(anyString(), eq(String.class), any(Object[].class)))
        .thenReturn("skill");
    when(jdbcTemplate.queryForObject(anyString(), eq(byte[].class), any(Object[].class)))
        .thenReturn(new byte[0]);
    AtomicBoolean runningInserted = new AtomicBoolean();
    when(jdbcTemplate.queryForObject(
        argThat(sql -> sql.contains("insert into analysis_skill_trials")),
        eq(Long.class), any(Object[].class))).thenAnswer(invocation -> {
          runningInserted.set(true);
          return 99L;
        });
    doAnswer(invocation -> {
      assertThat(runningInserted).isTrue();
      return new SkillAnalysisExecutor.SkillExecution(
          "SUCCEEDED", "{}", "{}", "<section />", null, "succeeded", null);
    }).when(executor).execute(any(), any(), any(), any(), any(), any(), any());

    service.trial(AnalysisPeriod.DAILY, date, 1, 2);

    assertThat(runningInserted).isTrue();
  }

  @Test
  void publishingAnAlreadyPublishedPairIsANoOp() {
    JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
    AnalysisSkillService service = spy(new AnalysisSkillService(jdbcTemplate,
        mock(SkillPackageValidator.class), mock(AnalysisPeriodWindowService.class),
        mock(AnalysisSourceSnapshotService.class), mock(SkillAnalysisExecutor.class)));
    doReturn(publishedVersion(1, AnalysisSkillKind.RULE)).when(service).get(1);
    doReturn(publishedVersion(2, AnalysisSkillKind.TEMPLATE)).when(service).get(2);

    service.publishPair(AnalysisPeriod.DAILY, 1, 2);

    verify(jdbcTemplate, never()).update(anyString(), any(Object[].class));
  }

  private static AnalysisSkillVersion version(long id, AnalysisSkillKind kind) {
    return new AnalysisSkillVersion(id, AnalysisPeriod.DAILY, kind, 1, AnalysisSkillStatus.DRAFT,
        "skill", "test", "skill.zip", "checksum", "ok", "daily-python-3.12-v1",
        null, null, null);
  }

  private static AnalysisSkillVersion publishedVersion(long id, AnalysisSkillKind kind) {
    AnalysisSkillVersion draft = version(id, kind);
    return new AnalysisSkillVersion(draft.id(), draft.period(), draft.kind(), draft.versionNumber(),
        AnalysisSkillStatus.PUBLISHED, draft.skillName(), draft.description(), draft.packageName(),
        draft.checksum(), draft.validationMessage(), draft.runtimeProfile(), draft.trialSucceededAt(),
        draft.publishedAt(), draft.createdAt());
  }
}
