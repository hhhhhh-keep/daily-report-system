package com.company.daily.scheduling.api;

import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.analysis.AnalysisPeriodWindow;
import com.company.daily.analysis.AnalysisPeriodWindowService;
import com.company.daily.scheduling.AnalysisOrchestrator;
import com.company.daily.scheduling.AnalysisRunStore;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;

class RunControllerTest {
  private final AnalysisOrchestrator orchestrator = mock(AnalysisOrchestrator.class);
  private final AnalysisPeriodWindowService windowService = mock(AnalysisPeriodWindowService.class);
  private final RunController controller = new RunController(
      orchestrator, mock(AnalysisRunStore.class), windowService);

  @Test
  void manualDailyTrialRemainsAvailable() {
    LocalDate date = LocalDate.of(2026, 8, 20);
    AnalysisPeriodWindow window = new AnalysisPeriodWindow(AnalysisPeriod.DAILY, date, date);
    when(windowService.resolve(AnalysisPeriod.DAILY, date)).thenReturn(window);

    controller.runNow(date, AnalysisPeriod.DAILY);

    verify(orchestrator).run(eq(window), eq("manual"));
  }
}
