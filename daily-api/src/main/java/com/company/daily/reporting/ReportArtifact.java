package com.company.daily.reporting;

public record ReportArtifact(String html, byte[] content, String fileName, String mimeType) {
  public static final String PDF_MIME_TYPE = "application/pdf";
  public static final String DOCX_MIME_TYPE =
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document";

  public ReportArtifact(String html, byte[] content, String fileName) {
    this(html, content, fileName, PDF_MIME_TYPE);
  }
}
