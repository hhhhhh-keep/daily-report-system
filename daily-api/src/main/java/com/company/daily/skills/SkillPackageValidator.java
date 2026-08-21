package com.company.daily.skills;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.CodingErrorAction;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import org.springframework.stereotype.Component;
import tools.jackson.databind.ObjectMapper;

@Component
public class SkillPackageValidator {
  private static final int MAX_ARCHIVE_BYTES = 5 * 1024 * 1024;
  private static final int MAX_UNCOMPRESSED_BYTES = 5 * 1024 * 1024;
  private static final Set<String> PROMPT_ASSETS = Set.of("css", "png", "jpg", "jpeg", "gif", "svg", "webp");
  private static final Set<String> SCRIPTED_ASSETS = Set.of(
      "css", "png", "jpg", "jpeg", "gif", "svg", "webp", "docx");
  private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

  public ValidatedSkillPackage validate(byte[] archiveBytes) {
    if (archiveBytes == null || archiveBytes.length == 0) {
      throw new IllegalArgumentException("Skill 包不能为空");
    }
    if (archiveBytes.length > MAX_ARCHIVE_BYTES) {
      throw new IllegalArgumentException("Skill 包不能超过 5MB");
    }
    Map<String, byte[]> entries = readEntries(archiveBytes);
    byte[] markdownBytes = entries.get("SKILL.md");
    if (markdownBytes == null) {
      throw new IllegalArgumentException("Skill 包根目录必须包含 SKILL.md");
    }
    String markdown = new String(markdownBytes, StandardCharsets.UTF_8);
    Metadata metadata = parseMetadata(markdown);
    SkillManifest manifest = parseManifest(entries.get("manifest.json"));
    if (manifest == null) {
      validatePromptEntries(entries.keySet());
    } else {
      validateScriptedEntries(metadata, manifest, entries.keySet());
    }
    String analysisSchema = analysisSchema(manifest, entries);
    String analysisInstructions = buildAnalysisInstructions(markdown, manifest, entries, analysisSchema);
    return new ValidatedSkillPackage(metadata.name(), metadata.description(), markdown, analysisInstructions,
        analysisSchema, checksum(archiveBytes), manifest);
  }

  private static String buildAnalysisInstructions(
      String markdown, SkillManifest manifest, Map<String, byte[]> entries, String schema) {
    if (schema == null) {
      return markdown;
    }

    StringBuilder result = new StringBuilder(markdown);
    entries.entrySet().stream()
        .filter(entry -> entry.getKey().startsWith("references/")
            && entry.getKey().endsWith(".md"))
        .sorted(Map.Entry.comparingByKey())
        .forEach(entry -> result.append("\n\n# ").append(entry.getKey()).append('\n')
            .append(decodeUtf8(entry.getValue(), entry.getKey())));
    result.append("\n\n# Required analysis JSON Schema\n").append(schema)
        .append("\n\n# Host output requirement\n")
        .append("Return exactly one JSON object matching the schema. Do not return Markdown, reasoning, ")
        .append("or additional properties. Keep the complete JSON under 12,000 characters. For every ")
        .append("array-valued semantic section, return at most 5 items; keep each summary within 240 ")
        .append("characters, each evidence_ids array within 12 IDs, and each person_ids array within 10 IDs. ")
        .append("Use only person, project, and evidence IDs present in the facts.");
    return result.toString();
  }

  private static String analysisSchema(SkillManifest manifest, Map<String, byte[]> entries) {
    if (manifest == null || manifest.contracts() == null
        || manifest.contracts().get("analysis") == null) {
      return null;
    }
    String contract = manifest.contracts().get("analysis");
    String contractName = contract.split("/", 2)[0];
    String schemaPath = "schemas/" + contractName + ".schema.json";
    byte[] schemaBytes = entries.get(schemaPath);
    if (schemaBytes == null) {
      throw new IllegalArgumentException("分析契约缺少对应 Schema: " + schemaPath);
    }
    String schema = decodeUtf8(schemaBytes, schemaPath);
    try {
      OBJECT_MAPPER.readTree(schema);
    } catch (Exception exception) {
      throw new IllegalArgumentException("分析契约 Schema 不是有效 JSON: " + schemaPath, exception);
    }
    return schema;
  }

  private static String decodeUtf8(byte[] bytes, String path) {
    try {
      return StandardCharsets.UTF_8.newDecoder()
          .onMalformedInput(CodingErrorAction.REPORT)
          .onUnmappableCharacter(CodingErrorAction.REPORT)
          .decode(ByteBuffer.wrap(bytes)).toString();
    } catch (CharacterCodingException exception) {
      throw new IllegalArgumentException("Skill 包文本不是有效 UTF-8: " + path, exception);
    }
  }

  private static Map<String, byte[]> readEntries(byte[] archiveBytes) {
    Map<String, byte[]> entries = new LinkedHashMap<>();
    int uncompressed = 0;
    try (ZipInputStream input = new ZipInputStream(new ByteArrayInputStream(archiveBytes))) {
      ZipEntry entry;
      while ((entry = input.getNextEntry()) != null) {
        String name = entry.getName().replace('\\', '/');
        validateSafePath(name);
        if (entry.isDirectory()) {
          continue;
        }
        byte[] content = readEntry(input, MAX_UNCOMPRESSED_BYTES - uncompressed);
        uncompressed += content.length;
        if (entries.putIfAbsent(name, content) != null) {
          throw new IllegalArgumentException("Skill 包不能包含重复路径");
        }
      }
    } catch (IOException exception) {
      throw new IllegalArgumentException("Skill 包不是有效 ZIP 文件", exception);
    }
    return entries;
  }

  private static void validateSafePath(String name) {
    if (name.isBlank() || name.startsWith("/") || name.contains("../") || name.contains("//")
        || name.contains(":")) {
      throw new IllegalArgumentException("Skill 包包含不安全路径");
    }
  }

  private static void validatePromptEntries(Set<String> entries) {
    for (String name : entries) {
      if ("SKILL.md".equals(name)) {
        continue;
      }
      if (!isSingleLevelFile(name, "assets/") || !PROMPT_ASSETS.contains(extension(name))) {
        throw new IllegalArgumentException("提示词 Skill 只允许根目录 SKILL.md 和 assets 下静态文件");
      }
    }
  }

  private static void validateScriptedEntries(Metadata metadata, SkillManifest manifest, Set<String> entries) {
    if (!"2.0".equals(manifest.formatVersion()) || !"daily-python-3.12-v1".equals(manifest.runtimeProfile())) {
      throw new IllegalArgumentException("脚本型 Skill 必须使用受支持的 format_version 和 runtime_profile");
    }
    if (!metadata.name().equals(manifest.name())) {
      throw new IllegalArgumentException("manifest name 必须与 SKILL.md name 一致");
    }
    if (manifest.permissions() == null || !Boolean.FALSE.equals(manifest.permissions().get("network"))) {
      throw new IllegalArgumentException("脚本型 Skill 必须显式禁用网络权限");
    }
    Map<String, String> entrypoints = manifest.entrypoints();
    if (entrypoints == null || entrypoints.isEmpty()) {
      throw new IllegalArgumentException("脚本型 Skill 必须声明至少一个入口脚本");
    }
    Set<String> declaredScripts = new java.util.HashSet<>(entrypoints.values());
    if (manifest.modules() != null) {
      declaredScripts.addAll(manifest.modules());
    }
    for (String script : declaredScripts) {
      if (!isSingleLevelFile(script, "scripts/") || !"py".equals(extension(script)) || !entries.contains(script)) {
        throw new IllegalArgumentException("manifest 包含无效或不存在的入口脚本");
      }
    }
    for (String name : entries) {
      if ("SKILL.md".equals(name) || "manifest.json".equals(name)) {
        continue;
      }
      if (isSingleLevelFile(name, "scripts/") && "py".equals(extension(name))) {
        if (!declaredScripts.contains(name)) {
          throw new IllegalArgumentException("scripts 下的 Python 文件必须声明为入口脚本");
        }
        continue;
      }
      if (isSingleLevelFile(name, "schemas/") && "json".equals(extension(name))) {
        continue;
      }
      if (isSingleLevelFile(name, "references/") && "md".equals(extension(name))) {
        continue;
      }
      if (isSingleLevelFile(name, "assets/") && SCRIPTED_ASSETS.contains(extension(name))) {
        continue;
      }
      if (name.startsWith("tests/fixtures/") && !name.substring("tests/fixtures/".length()).contains("/")) {
        continue;
      }
      throw new IllegalArgumentException("脚本型 Skill 包含未允许的文件");
    }
  }

  private static boolean isSingleLevelFile(String name, String directory) {
    return name.startsWith(directory) && !name.substring(directory.length()).isBlank()
        && !name.substring(directory.length()).contains("/");
  }

  private static String extension(String name) {
    int index = name.lastIndexOf('.');
    return index < 0 ? "" : name.substring(index + 1).toLowerCase(Locale.ROOT);
  }

  private static SkillManifest parseManifest(byte[] bytes) {
    if (bytes == null) {
      return null;
    }
    try {
      return OBJECT_MAPPER.readValue(bytes, SkillManifest.class);
    } catch (Exception exception) {
      throw new IllegalArgumentException("manifest.json 不是有效的 Skill Package 2.0 清单", exception);
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
      throw new IllegalArgumentException("SKILL.md 必须以前置元数据开头");
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

  public record ValidatedSkillPackage(String skillName, String description, String markdown,
      String analysisInstructions, String analysisSchema, String checksum, SkillManifest manifest) {}

  @JsonIgnoreProperties(ignoreUnknown = true)
  public record SkillManifest(@JsonProperty("format_version") String formatVersion, String name,
      @JsonProperty("runtime_profile") String runtimeProfile,
      Map<String, String> contracts, Map<String, String> entrypoints,
      List<String> modules, Map<String, Boolean> permissions) {}
}
