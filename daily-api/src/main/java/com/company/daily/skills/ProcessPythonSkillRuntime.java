package com.company.daily.skills;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ProcessPythonSkillRuntime implements SkillScriptRuntime {
  private static final Duration TIMEOUT = Duration.ofSeconds(90);
  private final String executable;
  private final boolean enabled;
  private final SkillPackageValidator validator;

  public ProcessPythonSkillRuntime(
      @Value("${skills.python.executable:python}") String executable,
      @Value("${skills.scripted.enabled:false}") boolean enabled,
      SkillPackageValidator validator) {
    this.executable = executable;
    this.enabled = enabled;
    this.validator = validator;
  }

  @Override
  public byte[] prepareFacts(byte[] skillPackage, byte[] dataPackage, String reportDate) {
    return withPackage(skillPackage, (root, manifest) -> {
      Path input = root.resolve("work/data-package.zip");
      Path output = root.resolve("work/daily-facts.json");
      Files.createDirectories(input.getParent());
      Files.write(input, dataPackage);
      run(root, manifest.entrypoints().get("prepare_facts"), List.of(
          "--input", input.toString(), "--date", reportDate, "--output", output.toString()), 2);
      return Files.readAllBytes(output);
    });
  }

  @Override
  public void validateAnalysis(byte[] skillPackage, byte[] facts, byte[] analysis) {
    withPackage(skillPackage, (root, manifest) -> {
      Path work = root.resolve("work");
      Files.createDirectories(work);
      Path factsPath = work.resolve("daily-facts.json");
      Path analysisPath = work.resolve("daily-analysis.json");
      Files.write(factsPath, facts);
      Files.write(analysisPath, analysis);
      run(root, manifest.entrypoints().get("validate_analysis"), List.of(
          "--facts", factsPath.toString(), "--analysis", analysisPath.toString()), 3);
      return new byte[0];
    });
  }

  @Override
  public byte[] renderDocument(byte[] skillPackage, byte[] facts, byte[] analysis) {
    return withPackage(skillPackage, (root, manifest) -> {
      Path work = root.resolve("work");
      Files.createDirectories(work);
      Path factsPath = work.resolve("daily-facts.json");
      Path analysisPath = work.resolve("daily-analysis.json");
      Path output = work.resolve("report.docx");
      Files.write(factsPath, facts);
      List<String> arguments = new ArrayList<>(List.of("--facts", factsPath.toString()));
      if (analysis != null) {
        Files.write(analysisPath, analysis);
        arguments.addAll(List.of("--analysis", analysisPath.toString()));
      }
      arguments.addAll(List.of("--template", root.resolve("assets/daily-report-template.docx").toString(),
          "--output", output.toString()));
      run(root, manifest.entrypoints().get("render_docx"), arguments, 4);
      return Files.readAllBytes(output);
    });
  }

  private byte[] withPackage(byte[] skillPackage, PackageOperation operation) {
    if (!enabled) {
      throw new IllegalStateException("Scripted Skill runtime is disabled");
    }
    SkillPackageValidator.ValidatedSkillPackage validated = validator.validate(skillPackage);
    if (validated.manifest() == null) {
      throw new IllegalArgumentException("Scripted Skill package requires manifest.json");
    }
    Path root = null;
    try {
      root = Files.createTempDirectory("daily-skill-");
      extract(skillPackage, root);
      return operation.run(root, validated.manifest());
    } catch (IOException exception) {
      throw new IllegalStateException("Scripted Skill file operation failed", exception);
    } finally {
      deleteTree(root);
    }
  }

  private void run(Path root, String entrypoint, List<String> arguments, int failureCode) throws IOException {
    if (entrypoint == null) {
      throw new IllegalArgumentException("Skill manifest is missing required entrypoint");
    }
    List<String> command = new ArrayList<>();
    command.add(executable);
    command.add(root.resolve(entrypoint).toString());
    command.addAll(arguments);
    Path outputLog = root.resolve("work/script-output.log");
    ProcessBuilder builder = new ProcessBuilder(command).directory(root.toFile())
        .redirectErrorStream(true).redirectOutput(outputLog.toFile());
    Map<String, String> environment = builder.environment();
    environment.clear();
    String systemPath = System.getenv("PATH");
    environment.put("PATH", systemPath == null || systemPath.isBlank()
        ? "/usr/local/bin:/usr/bin:/bin" : systemPath);
    environment.put("PYTHONNOUSERSITE", "1");
    environment.put("PYTHONUTF8", "1");
    Process process = builder.start();
    boolean finished;
    try {
      finished = process.waitFor(TIMEOUT.toSeconds(), TimeUnit.SECONDS);
    } catch (InterruptedException exception) {
      Thread.currentThread().interrupt();
      process.destroyForcibly();
      throw new IllegalStateException("Scripted Skill execution interrupted", exception);
    }
    if (!finished) {
      process.destroyForcibly();
      throw new IllegalStateException("Scripted Skill execution timed out");
    }
    String output;
    try (var input = Files.newInputStream(outputLog)) {
      output = new String(input.readNBytes(64 * 1024), StandardCharsets.UTF_8);
    }
    if (process.exitValue() != 0) {
      throw new SkillScriptException(failureCode, output.isBlank() ? "Scripted Skill failed" : output.trim());
    }
  }

  private static void extract(byte[] archive, Path root) throws IOException {
    try (ZipInputStream input = new ZipInputStream(new ByteArrayInputStream(archive))) {
      ZipEntry entry;
      while ((entry = input.getNextEntry()) != null) {
        if (entry.isDirectory()) {
          continue;
        }
        Path target = root.resolve(entry.getName().replace('\\', '/')).normalize();
        if (!target.startsWith(root)) {
          throw new IllegalArgumentException("Unsafe Skill package path");
        }
        Files.createDirectories(target.getParent());
        Files.copy(input, target, StandardCopyOption.REPLACE_EXISTING);
      }
    }
  }

  private static void deleteTree(Path root) {
    if (root == null || !Files.exists(root)) {
      return;
    }
    try (var paths = Files.walk(root)) {
      paths.sorted(Comparator.reverseOrder()).forEach(path -> {
        try {
          Files.deleteIfExists(path);
        } catch (IOException ignored) {
          // Best-effort cleanup of a per-run temporary directory.
        }
      });
    } catch (IOException ignored) {
      // Best-effort cleanup of a per-run temporary directory.
    }
  }

  @FunctionalInterface
  private interface PackageOperation {
    byte[] run(Path root, SkillPackageValidator.SkillManifest manifest) throws IOException;
  }

  public static final class SkillScriptException extends IllegalStateException {
    private final int exitCode;

    SkillScriptException(int exitCode, String message) {
      super(message);
      this.exitCode = exitCode;
    }

    public int exitCode() {
      return exitCode;
    }
  }
}
