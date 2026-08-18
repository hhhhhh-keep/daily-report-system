package com.company.daily.report.service;

import com.company.daily.report.api.dto.PersonReportPeriodStatistics;
import com.company.daily.report.api.dto.ReportPeriodStatisticsResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.springframework.stereotype.Service;

/** Writes the small, fixed statistics workbook without adding a document-library dependency. */
@Service
public class ReportPeriodStatisticsExcelExporter {
  private static final List<String> HEADERS = List.of(
      "人员", "所属团队", "应填", "17:30前填写", "早填率", "未填", "请假次数", "请假折算天数", "培训次数");

  public byte[] export(ReportPeriodStatisticsResponse statistics) {
    try (ByteArrayOutputStream output = new ByteArrayOutputStream();
         ZipOutputStream archive = new ZipOutputStream(output, StandardCharsets.UTF_8)) {
      entry(archive, "[Content_Types].xml", contentTypes());
      entry(archive, "_rels/.rels", rootRelationships());
      entry(archive, "xl/workbook.xml", workbook());
      entry(archive, "xl/_rels/workbook.xml.rels", workbookRelationships());
      entry(archive, "xl/styles.xml", styles());
      entry(archive, "xl/worksheets/sheet1.xml", worksheet(statistics));
      archive.finish();
      return output.toByteArray();
    } catch (IOException exception) {
      throw new IllegalStateException("无法生成填报累计统计 Excel", exception);
    }
  }

  private static void entry(ZipOutputStream archive, String name, String value) throws IOException {
    archive.putNextEntry(new ZipEntry(name));
    archive.write(value.getBytes(StandardCharsets.UTF_8));
    archive.closeEntry();
  }

  private static String worksheet(ReportPeriodStatisticsResponse statistics) {
    StringBuilder rows = new StringBuilder();
    rows.append(row(1, 2, List.of("填报累计统计")));
    rows.append(row(2, 0, List.of("统计范围", statistics.periodStart() + " 至 " + statistics.periodEnd())));
    rows.append(row(3, 0, List.of("工作日数", String.valueOf(statistics.workdayCount()))));
    rows.append(row(5, 1, HEADERS));
    ReportPeriodStatisticsResponse.Totals total = statistics.totals();
    rows.append(row(6, 1, List.of("部门合计", "", String.valueOf(total.expectedReportCount()),
        String.valueOf(total.earlySubmittedCount()), total.earlySubmissionRate() + "%",
        String.valueOf(total.missingCount()), String.valueOf(total.leaveOccurrences()),
        total.leaveEquivalentDays().stripTrailingZeros().toPlainString(), String.valueOf(total.trainingCount()))));
    int number = 7;
    for (PersonReportPeriodStatistics person : statistics.people()) {
      rows.append(row(number++, 0, List.of(person.employeeName(), person.teamName(),
          String.valueOf(person.expectedReportCount()), String.valueOf(person.earlySubmittedCount()),
          person.earlySubmissionRate() + "%", String.valueOf(person.missingCount()),
          String.valueOf(person.leaveOccurrences()), person.leaveEquivalentDays().stripTrailingZeros().toPlainString(),
          String.valueOf(person.trainingCount()))));
    }
    return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
        + "<worksheet xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\"><sheetViews><sheetView workbookViewId=\"0\"/></sheetViews>"
        + "<sheetFormatPr defaultRowHeight=\"18\"/><cols><col min=\"1\" max=\"1\" width=\"20\" customWidth=\"1\"/>"
        + "<col min=\"2\" max=\"2\" width=\"20\" customWidth=\"1\"/><col min=\"3\" max=\"9\" width=\"15\" customWidth=\"1\"/></cols>"
        + "<sheetData>" + rows + "</sheetData></worksheet>";
  }

  private static String row(int number, int style, List<String> values) {
    StringBuilder cells = new StringBuilder();
    for (int index = 0; index < values.size(); index++) {
      cells.append("<c r=\"").append(column(index)).append(number).append("\" t=\"inlineStr\"")
          .append(style == 0 ? "" : " s=\"" + style + "\"")
          .append("><is><t").append(needsSpace(values.get(index)) ? " xml:space=\"preserve\"" : "")
          .append(">").append(xml(values.get(index))).append("</t></is></c>");
    }
    return "<row r=\"" + number + "\">" + cells + "</row>";
  }

  private static String column(int index) {
    return String.valueOf((char) ('A' + index));
  }

  private static boolean needsSpace(String value) {
    return !value.isEmpty() && (Character.isWhitespace(value.charAt(0))
        || Character.isWhitespace(value.charAt(value.length() - 1)));
  }

  private static String xml(String value) {
    return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
        .replace("\"", "&quot;").replace("'", "&apos;");
  }

  private static String contentTypes() {
    return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Types xmlns=\"http://schemas.openxmlformats.org/package/2006/content-types\">"
        + "<Default Extension=\"rels\" ContentType=\"application/vnd.openxmlformats-package.relationships+xml\"/>"
        + "<Default Extension=\"xml\" ContentType=\"application/xml\"/>"
        + "<Override PartName=\"/xl/workbook.xml\" ContentType=\"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml\"/>"
        + "<Override PartName=\"/xl/worksheets/sheet1.xml\" ContentType=\"application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml\"/>"
        + "<Override PartName=\"/xl/styles.xml\" ContentType=\"application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml\"/></Types>";
  }

  private static String rootRelationships() {
    return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\">"
        + "<Relationship Id=\"rId1\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument\" Target=\"xl/workbook.xml\"/></Relationships>";
  }

  private static String workbook() {
    return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><workbook xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\" xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\"><sheets><sheet name=\"填报累计统计\" sheetId=\"1\" r:id=\"rId1\"/></sheets></workbook>";
  }

  private static String workbookRelationships() {
    return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\">"
        + "<Relationship Id=\"rId1\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet\" Target=\"worksheets/sheet1.xml\"/>"
        + "<Relationship Id=\"rId2\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles\" Target=\"styles.xml\"/></Relationships>";
  }

  private static String styles() {
    return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><styleSheet xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\">"
        + "<fonts count=\"2\"><font><sz val=\"11\"/><name val=\"等线\"/></font><font><b/><sz val=\"11\"/><name val=\"等线\"/></font></fonts>"
        + "<fills count=\"2\"><fill><patternFill patternType=\"none\"/></fill><fill><patternFill patternType=\"solid\"><fgColor rgb=\"FFEFF4FF\"/><bgColor indexed=\"64\"/></patternFill></fill></fills>"
        + "<borders count=\"1\"><border><left/><right/><top/><bottom/><diagonal/></border></borders><cellStyleXfs count=\"1\"><xf/></cellStyleXfs>"
        + "<cellXfs count=\"3\"><xf xfId=\"0\"/><xf xfId=\"0\" applyFont=\"1\" applyFill=\"1\" fontId=\"1\" fillId=\"1\"/><xf xfId=\"0\" applyFont=\"1\" fontId=\"1\"/></cellXfs></styleSheet>";
  }
}
