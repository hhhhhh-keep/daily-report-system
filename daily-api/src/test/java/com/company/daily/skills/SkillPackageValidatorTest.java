package com.company.daily.skills;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.junit.jupiter.api.Test;

class SkillPackageValidatorTest {
  private final SkillPackageValidator validator = new SkillPackageValidator();

  @Test
  void acceptsSkillMarkdownAtArchiveRoot() throws Exception {
    SkillPackageValidator.ValidatedSkillPackage value = validator.validate(zip("SKILL.md", """
        ---
        name: daily-rule
        description: Daily report rule
        ---
        Use only supplied data.
        """));

    assertEquals("daily-rule", value.skillName());
  }

  @Test
  void rejectsArchiveWithoutRootSkillMarkdown() throws Exception {
    assertThrows(IllegalArgumentException.class, () -> validator.validate(zip("assets/style.css", "body{}")));
  }

  @Test
  void rejectsExecutableOrUnsafeContent() throws Exception {
    assertThrows(IllegalArgumentException.class, () -> validator.validate(zip("assets/run.sh", "echo no")));
  }

  private static byte[] zip(String name, String content) throws Exception {
    try (ByteArrayOutputStream output = new ByteArrayOutputStream(); ZipOutputStream zip = new ZipOutputStream(output)) {
      zip.putNextEntry(new ZipEntry(name));
      zip.write(content.getBytes(StandardCharsets.UTF_8));
      zip.closeEntry();
      zip.finish();
      return output.toByteArray();
    }
  }
}
