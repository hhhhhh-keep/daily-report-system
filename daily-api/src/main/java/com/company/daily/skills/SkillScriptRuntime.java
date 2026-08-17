package com.company.daily.skills;

public interface SkillScriptRuntime {
  byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate);

  void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis);

  byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis);
}
