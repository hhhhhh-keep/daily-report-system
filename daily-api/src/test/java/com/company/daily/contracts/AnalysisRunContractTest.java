package com.company.daily.contracts;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.company.daily.configuration.AnalysisConfigurationRequest;
import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import tools.jackson.databind.ObjectMapper;

@SpringBootTest(properties = "spring.quartz.auto-startup=false")
@AutoConfigureMockMvc
class AnalysisRunContractTest extends PostgresIntegrationTest {
  @Autowired MockMvc mockMvc;
  @Autowired JdbcTemplate jdbcTemplate;
  @Autowired ObjectMapper objectMapper;

  @Test
  void validatesConfigurationAndRequiresPublishedSkillsForManualAnalysis() throws Exception {
    LocalDate date = LocalDate.of(2026, 8, 10);
    seedReport(date);
    MockHttpSession session = login();

    mockMvc.perform(get("/api/admin/configuration/analysis").session(session))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.promptVersion").value("V1.0"));
    AnalysisConfigurationRequest invalidCron = new AnalysisConfigurationRequest(
        true, "not-a-cron", List.of("project-risk"), Map.of("highTaskCount", 6),
        "V1", "仅提供建议", true, true, false, List.of(), List.of(),
        "日报 {{date}}", "{{content}}", null, null, null, null, null, null, null, null);
    mockMvc.perform(put("/api/admin/configuration/analysis").session(session)
            .contentType(MediaType.APPLICATION_JSON)
            .content(objectMapper.writeValueAsString(invalidCron)))
        .andExpect(status().isBadRequest());
    mockMvc.perform(get("/api/admin/configuration/analysis").session(session))
        .andExpect(jsonPath("$.cronExpression").value("0 0 22 * * ?"));

    mockMvc.perform(post("/api/admin/runs")
            .session(session).param("date", date.toString()))
        .andExpect(status().isBadRequest())
        .andExpect(jsonPath("$.code").value("INVALID_REQUEST"));
  }

  private MockHttpSession login() throws Exception {
    MvcResult result = mockMvc.perform(post("/api/admin/session")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"username\":\"admin\",\"password\":\"integration-test-only\"}"))
        .andExpect(status().isOk()).andReturn();
    return (MockHttpSession) result.getRequest().getSession(false);
  }

  private void seedReport(LocalDate date) {
    long employee = jdbcTemplate.queryForObject("insert into employees(name,team_name,position_type) "
        + "values ('分析员工','分析组','顾问') returning id", Long.class);
    long project = jdbcTemplate.queryForObject("insert into projects(name,status,code,formal,active) "
        + "values ('分析项目','active','ANALYSIS-1',true,true) returning id", Long.class);
    long report = jdbcTemplate.queryForObject("insert into daily_reports(report_date,employee_id,"
        + "attendance_status,status,submitted_at) values (?,?,'full-day','submitted',current_timestamp) "
        + "returning id", Long.class, date, employee);
    jdbcTemplate.update("insert into daily_tasks(report_id,time_period,project_id,work_type,"
        + "participation_role,progress_result,current_status,issue_type,collaboration_role,"
        + "collaboration_requirement) values (?, 'full-day', ?, 'project-support', 'owner',"
        + "'完成分析流程并识别风险', 'blocked', 'quality', 'manager', '请管理者评估')",
        report, project);
  }
}
