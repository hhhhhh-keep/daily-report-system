package com.company.daily.analysis;

public record LlmAnalysisResult(String status, String advisoryText, String errorSummary) {
  public static LlmAnalysisResult skipped(String message) {
    return new LlmAnalysisResult("skipped", message, null);
  }

  public static LlmAnalysisResult failed(String message) {
    return new LlmAnalysisResult("failed", null, message);
  }
}
