package com.company.daily.contracts;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
class CurrentReportContractTest extends PostgresIntegrationTest {
  @Autowired private MockMvc mockMvc;
  @Autowired private JdbcTemplate jdbcTemplate;

  private long employeeId;
  private long projectId;

  @BeforeEach
  void insertReferences() {
    jdbcTemplate.update("delete from project_state_snapshots");
    jdbcTemplate.update("delete from project_state_events");
    jdbcTemplate.update("delete from project_derived_states");
    jdbcTemplate.update("delete from daily_tasks");
    jdbcTemplate.update("delete from daily_reports");
    jdbcTemplate.update("delete from projects where formal = true");
    jdbcTemplate.update("delete from employees");
    employeeId = jdbcTemplate.queryForObject(
        "insert into employees(name, team_name, position_type, active) "
            + "values ('日报员工', '交付组', '顾问', true) returning id",
        Long.class);
    projectId = jdbcTemplate.queryForObject(
        "insert into projects(name, project_stage, priority, status, formal, active) "
            + "values ('日报项目', 'delivery', 'high', 'active', true, true) returning id",
        Long.class);
  }

  @Test
  void createsReadsAndReplacesTheSingleCurrentReport() throws Exception {
    String today = nextWorkday().toString();

    mockMvc.perform(put("/api/reports/current")
            .contentType(MediaType.APPLICATION_JSON)
            .content(payload(today, "首次提交", true)))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.employeeId").value(employeeId))
        .andExpect(jsonPath("$.tasks.length()").value(2));

    mockMvc.perform(put("/api/reports/current")
            .contentType(MediaType.APPLICATION_JSON)
            .content(payload(today, "覆盖更新", false)))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.note").value("覆盖更新"))
        .andExpect(jsonPath("$.tasks.length()").value(1));

    mockMvc.perform(get("/api/reports")
            .param("employeeId", Long.toString(employeeId))
            .param("date", today))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.note").value("覆盖更新"))
        .andExpect(jsonPath("$.tasks[0].timePeriod").value("morning"));

    org.assertj.core.api.Assertions.assertThat(
        jdbcTemplate.queryForObject("select count(*) from daily_reports", Integer.class)).isEqualTo(1);
    org.assertj.core.api.Assertions.assertThat(
        jdbcTemplate.queryForObject("select count(*) from daily_tasks", Integer.class)).isEqualTo(1);
  }

  @Test
  void rejectsNonCurrentDatesAndIncompleteAbnormalTasks() throws Exception {
    mockMvc.perform(put("/api/reports/current")
            .contentType(MediaType.APPLICATION_JSON)
            .content(payload(LocalDate.now().minusDays(1).toString(), "历史日报", false)))
        .andExpect(status().isBadRequest())
        .andExpect(jsonPath("$.code").value("INVALID_REQUEST"));

    String invalidAbnormalTask = """
        {
          "employeeId": %d,
          "date": "%s",
          "attendance": "present",
          "tasks": [{
            "timePeriod": "morning",
            "projectId": %d,
            "workType": "project-support",
            "workStage": "delivery-implementation",
            "participationRole": "owner",
            "progressResult": "发现交付风险",
            "currentStatus": "blocked"
          }]
        }
        """.formatted(employeeId, nextWorkday(), projectId);

    mockMvc.perform(put("/api/reports/current")
            .contentType(MediaType.APPLICATION_JSON)
            .content(invalidAbnormalTask))
        .andExpect(status().isBadRequest())
        .andExpect(jsonPath("$.code").value("INVALID_REQUEST"));
  }

  @Test
  void preservesTheStageForProjectSupportAndClearsItForSpecialWork() throws Exception {
    String today = nextWorkday().toString();
    String projectSupportTask = """
        {
          "employeeId": %d,
          "date": "%s",
          "attendance": "present",
          "tasks": [{
            "timePeriod": "morning",
            "projectId": %d,
            "workType": "project-support",
            "workStage": "presales-requirements-analysis",
            "participationRole": "owner",
            "progressResult": "stage contract",
            "currentStatus": "in-progress"
          }]
        }
        """.formatted(employeeId, today, projectId);

    mockMvc.perform(put("/api/reports/current")
            .contentType(MediaType.APPLICATION_JSON)
            .content(projectSupportTask))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.tasks[0].workStage").value("presales-requirements-analysis"));

    String specialTask = projectSupportTask
        .replace("project-support", "special-work")
        .replace("\"workStage\": \"presales-requirements-analysis\",",
            "\"workStage\": \"presales-requirements-analysis\",");
    mockMvc.perform(put("/api/reports/current")
            .contentType(MediaType.APPLICATION_JSON)
            .content(specialTask))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.tasks[0].workStage").doesNotExist());
  }

  private String payload(String date, String note, boolean twoTasks) {
    String secondTask = twoTasks
        ? """
          ,{
            "timePeriod": "afternoon",
            "projectId": %d,
            "workType": "project-support",
            "workStage": "delivery-implementation",
            "participationRole": "collaborator",
            "progressResult": "完成联调并等待反馈",
            "currentStatus": "in-progress"
          }
          """.formatted(projectId)
        : "";
    return """
        {
          "employeeId": %d,
          "date": "%s",
          "attendance": "present",
          "note": "%s",
          "tasks": [{
            "timePeriod": "morning",
            "projectId": %d,
            "workType": "project-support",
            "workStage": "delivery-implementation",
            "participationRole": "owner",
            "progressResult": "完成日报核心流程",
            "currentStatus": "in-progress"
          }%s]
        }
        """.formatted(employeeId, date, note, projectId, secondTask);
  }

  private LocalDate nextWorkday() {
    LocalDate date = LocalDate.now();
    while (date.getDayOfWeek().getValue() > 5) {
      date = date.plusDays(1);
    }
    return date;
  }
}
