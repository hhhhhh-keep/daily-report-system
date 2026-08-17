package com.company.daily.skills;

import static org.assertj.core.api.Assertions.assertThat;

import com.company.daily.analysis.AnalysisPeriod;
import com.company.daily.support.PostgresIntegrationTest;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class AnalysisSkillServiceUploadTest extends PostgresIntegrationTest {
  @Autowired private AnalysisSkillService service;

  @Test
  void uploadsScriptedSkillAndPersistsItsRuntimeProfile() throws IOException {
    byte[] skillPackage = scriptedSkillPackage();

    AnalysisSkillVersion uploaded = service.upload(
        AnalysisPeriod.DAILY, AnalysisSkillKind.RULE, "daily-work-analysis.zip", skillPackage);

    assertThat(uploaded.runtimeProfile()).isEqualTo("daily-python-3.12-v1");
    assertThat(service.download(uploaded.id())).isEqualTo(skillPackage);
  }

  private static byte[] scriptedSkillPackage() throws IOException {
    String manifest = """
        {
          "format_version": "2.0",
          "name": "daily-work-analysis",
          "version": "1.1.0",
          "runtime_profile": "daily-python-3.12-v1",
          "entrypoints": {"prepare_facts": "scripts/run_prepare_facts.py"},
          "modules": [],
          "permissions": {"network": false}
        }
        """;
    try (ByteArrayOutputStream output = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(output, StandardCharsets.UTF_8)) {
      add(zip, "SKILL.md", "---\nname: daily-work-analysis\ndescription: test\n---\n# Test\n");
      add(zip, "manifest.json", manifest);
      add(zip, "scripts/run_prepare_facts.py", "print('ok')\n");
      zip.finish();
      return output.toByteArray();
    }
  }

  private static void add(ZipOutputStream zip, String path, String content) throws IOException {
    zip.putNextEntry(new ZipEntry(path));
    zip.write(content.getBytes(StandardCharsets.UTF_8));
    zip.closeEntry();
  }
}
