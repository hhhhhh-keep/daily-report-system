package com.company.daily.skills;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.junit.jupiter.api.Test;

class ProcessPythonSkillRuntimeTest {
  @Test
  void returnsLargeScriptFailureOutputWithoutTimingOut() throws Exception {
    ProcessPythonSkillRuntime runtime = new ProcessPythonSkillRuntime("python", true,
        new SkillPackageValidator());

    assertThatThrownBy(() -> runtime.prepareFacts(scriptPackage(), new byte[] {1}, "2026-07-31"))
        .isInstanceOf(ProcessPythonSkillRuntime.SkillScriptException.class)
        .hasMessageContaining("validation failed");
  }

  private static byte[] scriptPackage() throws Exception {
    try (ByteArrayOutputStream output = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(output, StandardCharsets.UTF_8)) {
      add(zip, "SKILL.md", "---\nname: test-skill\ndescription: test\n---\n# Test\n");
      add(zip, "manifest.json", """
          {"format_version":"2.0","name":"test-skill","runtime_profile":"daily-python-3.12-v1",
           "entrypoints":{"prepare_facts":"scripts/run.py"},"permissions":{"network":false}}
          """);
      add(zip, "scripts/run.py", "import sys\nsys.stderr.write('validation failed\\n' * 10000)\nsys.exit(2)\n");
      zip.finish();
      return output.toByteArray();
    }
  }

  private static void add(ZipOutputStream zip, String name, String content) throws Exception {
    zip.putNextEntry(new ZipEntry(name));
    zip.write(content.getBytes(StandardCharsets.UTF_8));
    zip.closeEntry();
  }
}
