package com.company.daily.skills;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import org.springframework.stereotype.Component;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

@Component
public class DailyDataPackageAssembler {
  private static final ZoneId BUSINESS_ZONE = ZoneId.of("Asia/Shanghai");
  private static final List<String> PACKAGE_FILES = List.of("roster.json", "attendance.json", "reports.json",
      "tasks.json", "task-relations.json", "projects.json", "source-snapshot.json", "statistics.json",
      "project-status.json", "workdays.json");
  private final ObjectMapper objectMapper;

  public DailyDataPackageAssembler(ObjectMapper objectMapper) {
    this.objectMapper = objectMapper;
  }

  public byte[] assemble(String sourceSnapshot) {
    try {
      JsonNode root = objectMapper.readTree(sourceSnapshot);
      String start = root.path("coverageStart").asText(root.path("periodStart").asText());
      String end = root.path("coverageEnd").asText(root.path("periodEnd").asText());
      String reportDate = root.path("reportDate").asText(root.path("periodEnd").asText());
      Map<String, List<JsonNode>> tasksByReport = tasksByReport(root.path("tasks"));
      Map<String, byte[]> files = new LinkedHashMap<>();
      files.put("roster.json", json(roster(root.path("roster"), start)));
      files.put("attendance.json", json(attendance(root.path("reports"))));
      files.put("reports.json", json(reports(root.path("reports"), tasksByReport)));
      TaskDocuments taskDocuments = taskDocuments(root.path("tasks"), root.path("projectStates"));
      files.put("tasks.json", json(taskDocuments.tasks()));
      files.put("task-relations.json", json(taskDocuments.relations()));
      files.put("projects.json", json(taskDocuments.projects()));
      files.put("source-snapshot.json", json(sourceSnapshots(root.path("reports"), tasksByReport)));
      files.put("statistics.json", json(statistics(root.path("statistics"))));
      files.put("project-status.json", json(projectStatuses(root.path("projectStates"))));
      files.put("workdays.json", json(workdays(root.path("workdays"))));
      files.put("manifest.json", json(manifest(sourceSnapshot, root, start, end, reportDate, files)));
      return zip(files);
    } catch (Exception exception) {
      throw new IllegalArgumentException("Unable to assemble daily DataPackage", exception);
    }
  }

  private List<Map<String, Object>> roster(JsonNode nodes, String start) {
    List<Map<String, Object>> rows = new ArrayList<>();
    nodes.forEach(node -> rows.add(map(
        "person_id", id("employee", node.path("employee_id")),
        "name", node.path("employee_name").asText(),
        "group", node.path("team_name").asText(""),
        "personnel_type", node.path("position_type").asText("unknown"),
        "effective_start_date", start,
        "effective_end_date", null,
        "include_in_statistics", true)));
    return rows;
  }

  private List<Map<String, Object>> attendance(JsonNode nodes) {
    List<Map<String, Object>> rows = new ArrayList<>();
    nodes.forEach(node -> {
      String status = node.path("attendance_status").asText("present");
      String leavePeriod = switch (status) {
        case "leave" -> "full_day";
        case "leave-morning" -> "morning";
        case "leave-afternoon" -> "afternoon";
        default -> "none";
      };
      rows.add(map(
          "person_id", id("employee", node.path("employee_id")),
          "date", businessDate(node.path("report_date")),
          "morning_status", Set.of("leave", "leave-morning").contains(status) ? "leave" : "working",
          "afternoon_status", Set.of("leave", "leave-afternoon").contains(status) ? "leave" : "working",
          "leave_type", "none".equals(leavePeriod) ? null : "leave",
          "leave_period", leavePeriod,
          "source_record_id", id("report", node.path("report_id"))));
    });
    return rows;
  }

  private List<Map<String, Object>> reports(JsonNode nodes, Map<String, List<JsonNode>> tasksByReport) {
    List<Map<String, Object>> rows = new ArrayList<>();
    nodes.forEach(node -> {
      String reportId = id("report", node.path("report_id"));
      String submittedAt = nullableText(node.path("submitted_at"));
      String updatedAt = nullableText(node.path("updated_at"));
      rows.add(map(
          "report_id", reportId,
          "person_id", id("employee", node.path("employee_id")),
          "date", businessDate(node.path("report_date")),
          "submission_status", "submitted",
          "first_submitted_at", submittedAt,
          "final_submitted_at", updatedAt == null ? submittedAt : updatedAt,
          "raw_text", rawReport(node, tasksByReport.getOrDefault(reportId, List.of())),
          "snapshot_id", "snapshot-" + reportId));
    });
    return rows;
  }

  private TaskDocuments taskDocuments(JsonNode nodes, JsonNode projectStates) {
    List<Map<String, Object>> tasks = new ArrayList<>();
    List<Map<String, Object>> relations = new ArrayList<>();
    Map<String, Map<String, Object>> projects = new LinkedHashMap<>();
    nodes.forEach(node -> {
      String sourceTaskId = id("task", node.path("task_id"));
      List<String> periods = normalizedPeriods(node.path("time_period").asText("fragmented"));
      for (String period : periods) {
        String taskId = periods.size() == 1 ? sourceTaskId : sourceTaskId + "-" + period;
        String projectId = id("project", node.path("project_id"));
        String currentStatus = node.path("current_status").asText();
        tasks.add(map(
            "task_id", taskId,
            "report_id", id("report", node.path("report_id")),
            "date", businessDate(node.path("report_date")),
            "time_period", period,
            "raw_text", node.path("progress_result").asText(),
            "task_type", taskType(node.path("work_type").asText()),
            "project_candidate_id", projectId,
            "status", normalizedStatus(currentStatus),
            "output", nullableText(node.path("progress_result")),
            "risk", "at-risk".equals(currentStatus) ? nullableText(node.path("issue_type")) : null,
            "blocker", "blocked".equals(currentStatus)
                ? nullableText(node.path("collaboration_requirement")) : null,
            "next_step", "waiting-feedback".equals(currentStatus)
                ? nullableText(node.path("collaboration_requirement")) : null));
        String ownerRole = "owner".equals(node.path("participation_role").asText()) ? "lead" : "collaborator";
        relations.add(map(
            "relation_id", "relation-" + taskId,
            "task_id", taskId,
            "parent_task_id", null,
            "related_task_id", null,
            "relation_type", "lead".equals(ownerRole) ? "lead" : "collaborate",
            "person_id", id("employee", node.path("employee_id")),
            "role", ownerRole,
            "evidence_id", "snapshot-" + id("report", node.path("report_id"))));
        projects.putIfAbsent(projectId, map(
            "project_id", projectId,
            "standard_name", nullableText(node.path("project_name")),
            "candidate_names", List.of(node.path("project_name").asText()),
            "merge_status", "unmerged",
            "manual_confirmation_status", "pending"));
      }
    });
    projectStates.forEach(node -> {
      String projectId = id("project", node.path("project_id"));
      Map<String, Object> project = projects.computeIfAbsent(projectId, ignored -> map(
          "project_id", projectId,
          "standard_name", nullableText(node.path("project_name")),
          "candidate_names", List.of(node.path("project_name").asText()),
          "merge_status", "merged",
          "manual_confirmation_status", "confirmed"));
      project.put("formal", node.path("formal").asBoolean(false));
      project.put("active", node.path("active").asBoolean(true));
      project.put("source_status", nullableText(node.path("status")));
      project.put("priority", nullableText(node.path("priority")));
      project.put("state", nullableText(node.path("state")));
      project.put("lifecycle", nullableText(node.path("lifecycle")));
      project.put("current_stage", nullableText(node.path("current_stage")));
      project.put("state_started_date", nullableBusinessDate(node.path("state_started_date")));
      project.put("owner_name", nullableText(node.path("owner_name")));
      project.put("participant_count", node.path("participant_count").asInt());
      project.put("blocked_task_count", node.path("blocked_task_count").asInt());
      project.put("latest_report_date", nullableBusinessDate(node.path("latest_report_date")));
    });
    return new TaskDocuments(tasks, relations, new ArrayList<>(projects.values()));
  }

  private List<Map<String, Object>> sourceSnapshots(JsonNode reports, Map<String, List<JsonNode>> tasksByReport) {
    List<Map<String, Object>> rows = new ArrayList<>();
    reports.forEach(node -> {
      String reportId = id("report", node.path("report_id"));
      rows.add(map(
          "snapshot_id", "snapshot-" + reportId,
          "source_system", "daily-report-system",
          "source_record_id", reportId,
          "raw_record", rawReport(node, tasksByReport.getOrDefault(reportId, List.of())),
          "evidence_quality", "source-record-id"));
    });
    return rows;
  }

  private List<Map<String, Object>> statistics(JsonNode nodes) throws IOException {
    List<Map<String, Object>> rows = new ArrayList<>();
    for (JsonNode node : nodes) {
      rows.add(map(
          "snapshot_type", node.path("snapshot_type").asText(),
          "snapshot_date", businessDate(node.path("snapshot_date")),
          "captured_at", nullableText(node.path("captured_at")),
          "expected_count", node.path("expected_count").asInt(),
          "submitted_count", node.path("submitted_count").asInt(),
          "missing_count", node.path("missing_count").asInt(),
          "submission_rate", node.path("submission_rate").decimalValue(),
          "submitted_people", parsedJsonArray(node.path("submitted_employees_json")),
          "missing_people", parsedJsonArray(node.path("missing_employees_json")),
          "late_submitted_people", parsedJsonArray(node.path("late_submitted_employees_json")),
          "team_statistics", parsedJsonArray(node.path("team_statistics_json"))));
    }
    return rows;
  }

  private List<Map<String, Object>> projectStatuses(JsonNode nodes) {
    List<Map<String, Object>> rows = new ArrayList<>();
    nodes.forEach(node -> {
      String snapshotDate = businessDate(node.path("snapshot_date"));
      String capturedAt = nullableText(node.path("captured_at"));
      rows.add(map(
          "project_id", id("project", node.path("project_id")),
          "project_name", node.path("project_name").asText(),
          "snapshot_date", snapshotDate,
          "snapshot_captured_at", capturedAt,
          "snapshot_origin", snapshotOrigin(snapshotDate, capturedAt),
          "state", nullableText(node.path("state")),
          "lifecycle", nullableText(node.path("lifecycle")),
          "current_stage", nullableText(node.path("current_stage")),
          "state_started_date", nullableBusinessDate(node.path("state_started_date")),
          "owner_name", nullableText(node.path("owner_name")),
          "participant_count", node.path("participant_count").asInt(),
          "blocked_task_count", node.path("blocked_task_count").asInt(),
          "latest_report_date", nullableBusinessDate(node.path("latest_report_date")),
          "formal", node.path("formal").asBoolean(false),
          "active", node.path("active").asBoolean(true),
          "source_status", nullableText(node.path("status")),
          "priority", nullableText(node.path("priority"))));
    });
    return rows;
  }

  private List<Map<String, Object>> workdays(JsonNode nodes) {
    List<Map<String, Object>> rows = new ArrayList<>();
    nodes.forEach(node -> rows.add(map(
        "date", businessDate(node.path("calendar_date")),
        "workday", node.path("workday").asBoolean(false),
        "source", nullableText(node.path("source")),
        "note", nullableText(node.path("note")))));
    return rows;
  }

  private Map<String, Object> manifest(
      String sourceSnapshot, JsonNode root, String start, String end, String reportDate,
      Map<String, byte[]> files) {
    Map<String, String> hashes = new LinkedHashMap<>();
    PACKAGE_FILES.forEach(name -> hashes.put(name, sha256(files.get(name))));
    return map(
        "data_contract_version", "1.1.0",
        "package_id", "daily-" + end + "-" + sha256(sourceSnapshot.getBytes(StandardCharsets.UTF_8)).substring(0, 12),
        "department_id", "department-default",
        "department_name", "默认部门",
        "period_type", root.path("period").asText("DAILY").toLowerCase(),
        "report_date", reportDate,
        "start_date", start,
        "end_date", end,
        "working_dates", workingDates(root.path("workdays"), start, end),
        "timezone", "Asia/Shanghai",
        "generated_at", Instant.now().toString(),
        "stale_project_threshold_workdays", 3,
        "file_sha256", hashes);
  }

  private static List<String> workingDates(JsonNode nodes, String start, String end) {
    Set<String> dates = new LinkedHashSet<>();
    LocalDate first = LocalDate.parse(start);
    LocalDate last = LocalDate.parse(end);
    nodes.forEach(node -> {
      LocalDate date = LocalDate.parse(businessDate(node.path("calendar_date")));
      if (!date.isBefore(first) && !date.isAfter(last) && node.path("workday").asBoolean(false)) {
        dates.add(date.toString());
      }
    });
    if (dates.isEmpty()) {
      LocalDate current = first;
      while (!current.isAfter(last)) {
        dates.add(current.toString());
        current = current.plusDays(1);
      }
    }
    return new ArrayList<>(dates);
  }

  private static Map<String, List<JsonNode>> tasksByReport(JsonNode tasks) {
    Map<String, List<JsonNode>> result = new LinkedHashMap<>();
    tasks.forEach(task -> result.computeIfAbsent(id("report", task.path("report_id")), ignored -> new ArrayList<>())
        .add(task));
    return result;
  }

  private static String rawReport(JsonNode report, List<JsonNode> tasks) {
    List<String> parts = new ArrayList<>();
    String note = report.path("note").asText("");
    if (!note.isBlank()) {
      parts.add(note);
    }
    tasks.forEach(task -> parts.add(task.path("progress_result").asText("")));
    return String.join("；", parts);
  }

  private static List<String> normalizedPeriods(String value) {
    return switch (value) {
      case "morning" -> List.of("morning");
      case "afternoon" -> List.of("afternoon");
      default -> List.of("morning", "afternoon");
    };
  }

  private static String normalizedStatus(String value) {
    return switch (value) {
      case "completed" -> "completed";
      case "blocked" -> "blocked";
      default -> "in_progress";
    };
  }

  private static String taskType(String value) {
    return switch (value) {
      case "delivery", "presales" -> "project";
      case "internal" -> "internal";
      default -> "other";
    };
  }

  private byte[] json(Object value) throws IOException {
    return objectMapper.writeValueAsBytes(value);
  }

  private static byte[] zip(Map<String, byte[]> files) throws IOException {
    ByteArrayOutputStream output = new ByteArrayOutputStream();
    try (ZipOutputStream zip = new ZipOutputStream(output)) {
      List<String> names = new ArrayList<>();
      names.add("manifest.json");
      names.addAll(PACKAGE_FILES);
      for (String name : names) {
        zip.putNextEntry(new ZipEntry(name));
        zip.write(files.get(name));
        zip.closeEntry();
      }
    }
    return output.toByteArray();
  }

  private static String id(String prefix, JsonNode value) {
    return prefix + "-" + value.asText();
  }

  private static String nullableText(JsonNode value) {
    String text = value.asText("");
    return text.isBlank() ? null : text;
  }

  private JsonNode parsedJsonArray(JsonNode value) throws IOException {
    if (value == null || value.isNull() || value.asText("").isBlank()) {
      return objectMapper.createArrayNode();
    }
    JsonNode parsed = objectMapper.readTree(value.asText());
    return parsed != null && parsed.isArray() ? parsed : objectMapper.createArrayNode();
  }

  private static String nullableBusinessDate(JsonNode value) {
    return value == null || value.isNull() || value.asText("").isBlank() ? null : businessDate(value);
  }

  private static String snapshotOrigin(String snapshotDate, String capturedAt) {
    if (capturedAt == null) {
      return "reconstructed";
    }
    try {
      LocalDate capturedDate = OffsetDateTime.parse(capturedAt).atZoneSameInstant(BUSINESS_ZONE).toLocalDate();
      return capturedDate.isAfter(LocalDate.parse(snapshotDate).plusDays(1)) ? "reconstructed" : "captured";
    } catch (DateTimeParseException ignored) {
      return "reconstructed";
    }
  }

  private static String businessDate(JsonNode value) {
    String text = value.asText();
    try {
      return LocalDate.parse(text).toString();
    } catch (DateTimeParseException ignored) {
      // JDBC date values can be serialized as UTC midnight; restore the configured business date.
    }
    try {
      return Instant.parse(text).atZone(BUSINESS_ZONE).toLocalDate().toString();
    } catch (DateTimeParseException ignored) {
      // Offset timestamps are handled below.
    }
    try {
      return OffsetDateTime.parse(text).atZoneSameInstant(BUSINESS_ZONE).toLocalDate().toString();
    } catch (DateTimeParseException exception) {
      throw new IllegalArgumentException("Invalid business date: " + text, exception);
    }
  }

  private static Map<String, Object> map(Object... pairs) {
    Map<String, Object> result = new LinkedHashMap<>();
    for (int index = 0; index < pairs.length; index += 2) {
      result.put((String) pairs[index], pairs[index + 1]);
    }
    return result;
  }

  private static String sha256(byte[] bytes) {
    try {
      byte[] digest = MessageDigest.getInstance("SHA-256").digest(bytes);
      StringBuilder value = new StringBuilder();
      for (byte item : digest) {
        value.append(String.format("%02x", item));
      }
      return value.toString();
    } catch (NoSuchAlgorithmException exception) {
      throw new IllegalStateException("SHA-256 unavailable", exception);
    }
  }

  private record TaskDocuments(List<Map<String, Object>> tasks, List<Map<String, Object>> relations,
      List<Map<String, Object>> projects) {}
}
