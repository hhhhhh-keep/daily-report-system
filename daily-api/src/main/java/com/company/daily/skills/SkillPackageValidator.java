package com.company.daily.skills;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import org.springframework.stereotype.Component;

@Component
public class SkillPackageValidator {
  private static final int MAX_ARCHIVE_BYTES = 5 * 1024 * 1024;
  private static final int MAX_UNCOMPRESSED_BYTES = 5 * 1024 * 1024;

  public ValidatedSkillPackage validate(byte[] archiveBytes) {
    if (archiveBytes == null || archiveBytes.length == 0) {
      throw new IllegalArgumentException("Skill 包不能为空");
    }
    if (archiveBytes.length > MAX_ARCHIVE_BYTES) {
      throw new IllegalArgumentException("Skill 包不能超过 5MB");
    }
    String markdown = null;
    int uncompressed = 0;
    try (ZipInputStream input = new ZipInputStream(new ByteArrayInputStream(archiveBytes))) {
      ZipEntry entry;
      while ((entry = input.getNextEntry()) != null) {
        String name = entry.getName().replace('\\', '/');
        validateEntry(name, entry.isDirectory());
        byte[] content = readEntry(input, MAX_UNCOMPRESSED_BYTES - uncompressed);
        uncompressed += content.length;
        if (uncompressed > MAX_UNCOMPRESSED_BYTES) {
          throw new IllegalArgumentException("Skill 包解压后不能超过 5MB");
        }
        if ("SKILL.md".equals(name)) {
          if (markdown != null) {
            throw new IllegalArgumentException("Skill 包只能包含一份根目录 SKILL.md");
          }
          markdown = new String(content, StandardCharsets.UTF_8);
        }
      }
    } catch (IOException exception) {
      throw new IllegalArgumentException("Skill 包不是有效 ZIP 文件", exception);
    }
    if (markdown == null) {
      throw new IllegalArgumentException("Skill 包根目录必须包含 SKILL.md");
    }
    Metadata metadata = parseMetadata(markdown);
    return new ValidatedSkillPackage(metadata.name(), metadata.description(), markdown, checksum(archiveBytes));
  }

  private static void validateEntry(String name, boolean directory) {
    if (name.isBlank() || name.startsWith("/") || name.contains("../") || name.contains("//")) {
      throw new IllegalArgumentException("Skill 包包含不安全路径");
    }
    if (directory) {
      if (!"assets/".equals(name)) {
        throw new IllegalArgumentException("Skill 包仅允许 assets 目录");
      }
      return;
    }
    if ("SKILL.md".equals(name)) {
      return;
    }
    if (!name.startsWith("assets/") || name.substring("assets/".length()).contains("/")) {
      throw new IllegalArgumentException("Skill 包只允许根目录 SKILL.md 和 assets 下静态文件");
    }
    String extension = name.substring(name.lastIndexOf('.') + 1).toLowerCase(Locale.ROOT);
    if (!List.of("css", "png", "jpg", "jpeg", "gif", "svg", "webp").contains(extension)) {
      throw new IllegalArgumentException("assets 只允许 CSS 和图片文件");
    }
  }

  private static byte[] readEntry(ZipInputStream input, int remaining) throws IOException {
    if (remaining < 0) {
      throw new IllegalArgumentException("Skill 包解压后不能超过 5MB");
    }
    ByteArrayOutputStream output = new ByteArrayOutputStream();
    byte[] buffer = new byte[4096];
    int read;
    while ((read = input.read(buffer)) != -1) {
      if (output.size() + read > remaining) {
        throw new IllegalArgumentException("Skill 包解压后不能超过 5MB");
      }
      output.write(buffer, 0, read);
    }
    return output.toByteArray();
  }

  private static Metadata parseMetadata(String markdown) {
    String[] lines = markdown.replace("\r\n", "\n").split("\n");
    if (lines.length < 4 || !"---".equals(lines[0])) {
      throw new IllegalArgumentException("SKILL.md 必须以 name 和 description 前置元数据开头");
    }
    List<String> header = new ArrayList<>();
    int index = 1;
    while (index < lines.length && !"---".equals(lines[index])) {
      header.add(lines[index++]);
    }
    if (index == lines.length) {
      throw new IllegalArgumentException("SKILL.md 前置元数据未结束");
    }
    String name = value(header, "name:");
    String description = value(header, "description:");
    if (name == null || description == null) {
      throw new IllegalArgumentException("SKILL.md 必须提供 name 和 description");
    }
    return new Metadata(name, description);
  }

  private static String value(List<String> lines, String prefix) {
    return lines.stream().filter(line -> line.startsWith(prefix)).map(line -> line.substring(prefix.length()).trim())
        .filter(value -> !value.isBlank()).findFirst().orElse(null);
  }

  private static String checksum(byte[] bytes) {
    try {
      byte[] digest = MessageDigest.getInstance("SHA-256").digest(bytes);
      StringBuilder value = new StringBuilder();
      for (byte item : digest) {
        value.append(String.format("%02x", item));
      }
      return value.toString();
    } catch (NoSuchAlgorithmException exception) {
      throw new IllegalStateException("SHA-256 不可用", exception);
    }
  }

  private record Metadata(String name, String description) {}

  public record ValidatedSkillPackage(String skillName, String description, String markdown, String checksum) {}
}
