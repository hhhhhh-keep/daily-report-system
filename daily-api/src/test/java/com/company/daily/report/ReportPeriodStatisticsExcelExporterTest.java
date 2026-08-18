package com.company.daily.report;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.report.api.dto.PersonReportPeriodStatistics;
import com.company.daily.report.api.dto.ReportPeriodStatisticsResponse;
import com.company.daily.report.service.ReportPeriodStatisticsExcelExporter;
import java.io.ByteArrayInputStream;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;
import java.util.zip.ZipInputStream;
import org.junit.jupiter.api.Test;

class ReportPeriodStatisticsExcelExporterTest {
  @Test
  void writesAnXlsxWithRangeTotalsAndAllPeople() throws Exception {
    ReportPeriodStatisticsResponse statistics = new ReportPeriodStatisticsResponse(
        "CUSTOM", LocalDate.of(2026, 8, 1), LocalDate.of(2026, 8, 15), 11,
        "CURRENT_ROSTER_FALLBACK", new ReportPeriodStatisticsResponse.Totals(
            22, 20, new BigDecimal("90.91"), 2, 1, new BigDecimal("0.5"), 1),
        List.of(new PersonReportPeriodStatistics(1, "测试员工", "测试组", 11, 10,
            new BigDecimal("90.91"), 1, 1, new BigDecimal("0.5"), 1)));

    byte[] workbook = new ReportPeriodStatisticsExcelExporter().export(statistics);

    assertThat(workbook).startsWith((byte) 'P', (byte) 'K');
    assertThat(worksheet(workbook)).contains("填报累计统计", "2026-08-01 至 2026-08-15", "测试员工");
  }

  private String worksheet(byte[] workbook) throws Exception {
    try (ZipInputStream archive = new ZipInputStream(new ByteArrayInputStream(workbook))) {
      for (var entry = archive.getNextEntry(); entry != null; entry = archive.getNextEntry()) {
        if ("xl/worksheets/sheet1.xml".equals(entry.getName())) {
          return new String(archive.readAllBytes(), StandardCharsets.UTF_8);
        }
      }
    }
    throw new AssertionError("worksheet missing from xlsx");
  }
}
