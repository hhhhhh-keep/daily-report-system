package com.company.daily.contracts;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.company.daily.support.PostgresIntegrationTest;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

@SpringBootTest
@AutoConfigureMockMvc
class AdminManagementContractTest extends PostgresIntegrationTest {
  @Autowired MockMvc mockMvc;
  @Autowired ObjectMapper objectMapper;

  @Test
  void rejectsUnauthenticatedAdministrationRequests() throws Exception {
    mockMvc.perform(get("/api/admin/employees"))
        .andExpect(status().isUnauthorized());
  }

  @Test
  void remembersAdministratorSessionForThirtyDaysWhenRequested() throws Exception {
    MvcResult result = mockMvc.perform(post("/api/admin/session")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"username\":\"admin\",\"password\":\"integration-test-only\",\"rememberMe\":true}"))
        .andExpect(status().isOk())
        .andReturn();

    MockHttpSession session = (MockHttpSession) result.getRequest().getSession(false);
    assertEquals(30 * 24 * 60 * 60, session.getMaxInactiveInterval());
    assertTrue(result.getResponse().getHeaders("Set-Cookie").stream()
        .anyMatch(cookie -> cookie.contains("Max-Age=2592000") && cookie.contains("HttpOnly")));
  }

  @Test
  void administersMasterDataReportsAndDashboardThroughOneSession() throws Exception {
    MockHttpSession session = login();

    long employeeId = id(mockMvc.perform(post("/api/admin/employees")
            .session(session)
            .contentType(MediaType.APPLICATION_JSON)
            .content("""
                {"name":"契约员工","teamName":"交付一组","positionType":"顾问","active":true}
                """))
        .andExpect(status().isCreated())
        .andExpect(jsonPath("$.name").value("契约员工"))
        .andReturn());

    mockMvc.perform(put("/api/admin/employees/{id}", employeeId)
            .session(session)
            .contentType(MediaType.APPLICATION_JSON)
            .content("""
                {"name":"契约员工","teamName":"交付二组","positionType":"高级顾问","active":true}
                """))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.teamName").value("交付二组"));

    long projectId = id(mockMvc.perform(post("/api/admin/projects")
            .session(session)
            .contentType(MediaType.APPLICATION_JSON)
            .content("""
                {"name":"契约项目","customerName":"契约客户","industry":"软件",
                 "projectStage":"交付","ownerName":"契约员工","priority":"high",
                 "status":"active","code":"CONTRACT-001","formal":true,
                 "systemKey":null,"active":true}
                """))
        .andExpect(status().isCreated())
        .andReturn());

    long dictionaryId = id(mockMvc.perform(post("/api/admin/dictionaries")
            .session(session)
            .contentType(MediaType.APPLICATION_JSON)
            .content("""
                {"category":"work_type","code":"contract-work","label":"契约工作",
                 "sortOrder":99,"active":true}
                """))
        .andExpect(status().isCreated())
        .andReturn());

    LocalDate reportDate = LocalDate.now();
    while (reportDate.getDayOfWeek().getValue() > 5) {
      reportDate = reportDate.plusDays(1);
    }
    String date = reportDate.toString();
    MvcResult saved = mockMvc.perform(put("/api/reports/current")
            .contentType(MediaType.APPLICATION_JSON)
            .content("""
                {"employeeId":%d,"date":"%s","attendance":"full-day","note":"契约日报",
                 "tasks":[{"timePeriod":"full-day","projectId":%d,
                 "workType":"contract-work","participationRole":"owner",
                 "progressResult":"完成管理契约验证","currentStatus":"completed"}]}
                """.formatted(employeeId, date, projectId)
                .replace("\"attendance\":\"full-day\"", "\"attendance\":\"present\"")))
        .andExpect(status().isOk())
        .andReturn();
    long reportId = id(saved);

    mockMvc.perform(get("/api/admin/reports")
            .session(session)
            .param("date", date)
            .param("employeeId", Long.toString(employeeId)))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.items[0].id").value(reportId))
        .andExpect(jsonPath("$.items[0].taskCount").value(1));

    mockMvc.perform(get("/api/admin/reports/{id}", reportId).session(session))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.tasks[0].progressResult").value("完成管理契约验证"));

    mockMvc.perform(get("/api/admin/dashboard").session(session).param("date", date))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.submittedReportCount").value(1))
        .andExpect(jsonPath("$.taskCount").value(1))
        .andExpect(jsonPath("$.projectCount").value(1));

    mockMvc.perform(delete("/api/admin/dictionaries/{id}", dictionaryId).session(session))
        .andExpect(status().isNoContent());
    mockMvc.perform(delete("/api/admin/projects/{id}", projectId).session(session))
        .andExpect(status().isNoContent());
    mockMvc.perform(delete("/api/admin/employees/{id}", employeeId).session(session))
        .andExpect(status().isNoContent());
    mockMvc.perform(get("/api/admin/employees").session(session))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.items[?(@.id == %d)].active".formatted(employeeId)).value(false));
  }

  private MockHttpSession login() throws Exception {
    MvcResult result = mockMvc.perform(post("/api/admin/session")
            .contentType(MediaType.APPLICATION_JSON)
            .content("""
                {"username":"admin","password":"integration-test-only"}
                """))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.authenticated").value(true))
        .andReturn();
    return (MockHttpSession) result.getRequest().getSession(false);
  }

  private long id(MvcResult result) throws Exception {
    JsonNode body = objectMapper.readTree(result.getResponse().getContentAsByteArray());
    return body.path("id").asLong();
  }
}
