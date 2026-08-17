package com.company.daily.skills;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import org.junit.jupiter.api.Test;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

class DailyDataPackageAssemblerTest {
  private final ObjectMapper objectMapper = new ObjectMapper();
  private final DailyDataPackageAssembler assembler = new DailyDataPackageAssembler(objectMapper);

  @Test
  void assemblesVersionedPackageWithLeaveFactsAndEvidence() throws Exception {
    byte[] archive = assembler.assemble("""
        {"period":"DAILY","periodStart":"2026-07-31","periodEnd":"2026-07-31",
         "reportDate":"2026-07-31","coverageStart":"2026-07-27","coverageEnd":"2026-07-31",
         "workdays":[{"calendar_date":"2026-07-24","workday":true,"source":"LEGAL_HOLIDAY","note":""},
                     {"calendar_date":"2026-07-31","workday":true,"source":"DEFAULT","note":""}],
         "statistics":[{"snapshot_type":"PROGRESS_1730","snapshot_date":"2026-07-31",
                         "captured_at":"2026-07-31T17:30:00+08:00","expected_count":1,
                         "submitted_count":1,"missing_count":0,"submission_rate":1.0,
                         "submitted_employees_json":"[]","missing_employees_json":"[]",
                         "late_submitted_employees_json":"[]","team_statistics_json":"[]"}],
         "projectStates":[
           {"snapshot_date":"2026-07-31","captured_at":"2026-07-31T22:00:00+08:00",
            "project_id":31,"project_name":"A项目","state":"DELIVERY_IN_PROGRESS",
            "lifecycle":"delivery","current_stage":"implementation","state_started_date":"2026-07-30",
            "owner_name":"李经理","participant_count":1,"blocked_task_count":0,
            "latest_report_date":"2026-07-31","formal":true,"active":true,"status":"active","priority":"high"},
           {"snapshot_date":"2026-07-31","captured_at":"2026-08-14T10:00:00+08:00",
            "project_id":32,"project_name":"B项目","state":"PRESALES_IN_PROGRESS",
            "lifecycle":"presales","current_stage":"solution-design","state_started_date":"2026-07-20",
            "owner_name":"王经理","participant_count":2,"blocked_task_count":1,
            "latest_report_date":"2026-07-24","formal":true,"active":true,"status":"active","priority":"medium"}],
         "roster":[{"employee_id":1,"employee_name":"张三","team_name":"交付组",
                    "position_type":"自有"}],
         "reports":[{"report_id":11,"report_date":"2026-07-31","employee_id":1,
                     "attendance_status":"leave-morning","note":"下午推进项目","status":"submitted",
                     "submitted_at":"2026-07-31T17:00:00+08:00",
                     "updated_at":"2026-07-31T19:15:00+08:00"}],
         "tasks":[{"task_id":21,"report_id":11,"report_date":"2026-07-31","employee_id":1,
                   "employee_name":"张三","team_name":"交付组","attendance_status":"leave-morning",
                   "submitted_at":"2026-07-31T17:00:00+08:00","project_id":31,
                   "project_name":"A项目","time_period":"afternoon","work_type":"delivery",
                   "participation_role":"owner","progress_result":"完成方案","current_status":"completed"}]}
        """);

    Map<String, String> files = unzip(archive);

    assertThat(files.keySet()).containsExactlyInAnyOrder("manifest.json", "roster.json", "attendance.json",
        "reports.json", "tasks.json", "task-relations.json", "projects.json", "source-snapshot.json",
        "statistics.json", "project-status.json", "workdays.json");
    JsonNode manifest = objectMapper.readTree(files.get("manifest.json"));
    assertThat(manifest.path("data_contract_version").asText()).isEqualTo("1.1.0");
    assertThat(manifest.path("report_date").asText()).isEqualTo("2026-07-31");
    assertThat(manifest.path("start_date").asText()).isEqualTo("2026-07-27");
    assertThat(manifest.path("end_date").asText()).isEqualTo("2026-07-31");
    assertThat(manifest.path("file_sha256").has("project-status.json")).isTrue();
    JsonNode projectStatuses = objectMapper.readTree(files.get("project-status.json"));
    assertThat(projectStatuses).hasSize(2);
    assertThat(projectStatuses.get(0).path("snapshot_origin").asText()).isEqualTo("captured");
    assertThat(projectStatuses.get(1).path("snapshot_origin").asText()).isEqualTo("reconstructed");
    assertThat(projectStatuses.get(1).path("project_id").asText()).isEqualTo("project-32");
    JsonNode attendance = objectMapper.readTree(files.get("attendance.json")).get(0);
    assertThat(attendance.path("leave_period").asText()).isEqualTo("morning");
    assertThat(attendance.path("morning_status").asText()).isEqualTo("leave");
    assertThat(attendance.path("afternoon_status").asText()).isEqualTo("working");
    JsonNode task = objectMapper.readTree(files.get("tasks.json")).get(0);
    assertThat(task.path("status").asText()).isEqualTo("completed");
    assertThat(task.path("project_candidate_id").asText()).isEqualTo("project-31");
    JsonNode report = objectMapper.readTree(files.get("reports.json")).get(0);
    assertThat(report.path("first_submitted_at").asText()).isEqualTo("2026-07-31T17:00:00+08:00");
    assertThat(report.path("final_submitted_at").asText()).isEqualTo("2026-07-31T19:15:00+08:00");
    JsonNode projects = objectMapper.readTree(files.get("projects.json"));
    JsonNode maintainedProject = null;
    for (JsonNode project : projects) {
      if ("project-32".equals(project.path("project_id").asText())) {
        maintainedProject = project;
      }
    }
    assertThat(maintainedProject).isNotNull();
    assertThat(maintainedProject.path("formal").asBoolean()).isTrue();
    assertThat(maintainedProject.path("state").asText()).isEqualTo("PRESALES_IN_PROGRESS");
    assertThat(maintainedProject.path("latest_report_date").asText()).isEqualTo("2026-07-24");
  }

  @Test
  void convertsJdbcUtcMidnightTimestampsBackToShanghaiBusinessDates() throws Exception {
    byte[] archive = assembler.assemble("""
        {"period":"DAILY","periodStart":"2026-08-11","periodEnd":"2026-08-11","workdays":[],
         "roster":[{"employee_id":1,"employee_name":"张三","team_name":"交付组","position_type":"自有"}],
         "reports":[{"report_id":11,"report_date":"2026-08-10T16:00:00.000Z","employee_id":1,
                     "attendance_status":"present","note":"","status":"submitted",
                     "submitted_at":"2026-08-11T09:00:00.000Z"}],
         "tasks":[{"task_id":21,"report_id":11,"report_date":"2026-08-10T16:00:00.000Z",
                   "employee_id":1,"employee_name":"张三","team_name":"交付组",
                   "attendance_status":"present","submitted_at":"2026-08-11T09:00:00.000Z",
                   "project_id":31,"project_name":"A项目","time_period":"morning","work_type":"delivery",
                   "participation_role":"owner","progress_result":"完成方案","current_status":"completed"}]}
        """);

    Map<String, String> files = unzip(archive);

    assertThat(objectMapper.readTree(files.get("attendance.json")).get(0).path("date").asText())
        .isEqualTo("2026-08-11");
    assertThat(objectMapper.readTree(files.get("reports.json")).get(0).path("date").asText())
        .isEqualTo("2026-08-11");
    assertThat(objectMapper.readTree(files.get("tasks.json")).get(0).path("date").asText())
        .isEqualTo("2026-08-11");
  }

  private static Map<String, String> unzip(byte[] archive) throws Exception {
    Map<String, String> files = new LinkedHashMap<>();
    try (ZipInputStream input = new ZipInputStream(new ByteArrayInputStream(archive))) {
      ZipEntry entry;
      while ((entry = input.getNextEntry()) != null) {
        files.put(entry.getName(), new String(input.readAllBytes(), StandardCharsets.UTF_8));
      }
    }
    return files;
  }
}
