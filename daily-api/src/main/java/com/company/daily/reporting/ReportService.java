package com.company.daily.reporting;

import com.company.daily.configuration.AnalysisConfiguration;
import com.company.daily.metrics.ReportMetrics;
import com.company.daily.rules.RuleConclusion;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.springframework.stereotype.Service;

@Service
public class ReportService {
  public ReportArtifact generate(
      AnalysisConfiguration configuration,
      ReportMetrics metrics,
      List<RuleConclusion> rules,
      String advisory) {
    String ruleHtml = rules.stream().map(rule -> "<li>" + escape(rule.message()) + "</li>")
        .collect(Collectors.joining());
    String content = "<section><h2>客观指标</h2><p>已提交 " + metrics.submittedReportCount()
        + " 人，任务 " + metrics.taskCount() + " 项，项目 " + metrics.projectCount()
        + " 个，风险/阻塞 " + metrics.abnormalTaskCount() + " 项。</p><h2>规则结论</h2><ul>"
        + ruleHtml + "</ul><h2>AI 顾问建议</h2><pre>" + escape(advisory) + "</pre></section>";
    String html = configuration.reportTemplate().replace("{{date}}", metrics.date().toString())
        .replace("{{content}}", content);
    String fileName = "daily-analysis-" + metrics.date() + ".pdf";
    return new ReportArtifact(html, pdf(metrics, rules), fileName);
  }

  private byte[] pdf(ReportMetrics metrics, List<RuleConclusion> rules) {
    try (PDDocument document = new PDDocument(); ByteArrayOutputStream output = new ByteArrayOutputStream()) {
      PDPage page = new PDPage();
      document.addPage(page);
      try (PDPageContentStream stream = new PDPageContentStream(document, page)) {
        stream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 18);
        stream.beginText();
        stream.newLineAtOffset(52, 740);
        stream.showText("Daily Analysis Report " + metrics.date());
        stream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 11);
        stream.newLineAtOffset(0, -30);
        stream.showText("Employees: " + metrics.submittedReportCount() + "/"
            + metrics.activeEmployeeCount());
        stream.newLineAtOffset(0, -18);
        stream.showText("Tasks: " + metrics.taskCount() + "  Projects: " + metrics.projectCount());
        stream.newLineAtOffset(0, -18);
        stream.showText("Risk or blocked tasks: " + metrics.abnormalTaskCount());
        stream.newLineAtOffset(0, -18);
        stream.showText("Deterministic rule conclusions: " + rules.size());
        stream.endText();
      }
      document.save(output);
      return output.toByteArray();
    } catch (IOException exception) {
      throw new IllegalStateException("PDF 报告生成失败", exception);
    }
  }

  private static String escape(String value) {
    if (value == null) {
      return "";
    }
    return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
  }
}
