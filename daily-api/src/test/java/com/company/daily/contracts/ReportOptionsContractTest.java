package com.company.daily.contracts;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.company.daily.support.PostgresIntegrationTest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
class ReportOptionsContractTest extends PostgresIntegrationTest {
  @Autowired private MockMvc mockMvc;

  @Test
  @Sql(statements = {
      "insert into employees(name, team_name, position_type, active) values ('测试员工', '交付组', '顾问', true)",
      "insert into projects(name, customer_name, industry, project_stage, owner_name, priority, status, formal) "
          + "values ('测试项目', '测试客户', '制造业', 'delivery', '测试负责人', 'high', 'active', true)"
  })
  void returnsActiveEmployeesProjectsDictionariesAndNonFormalOptions() throws Exception {
    mockMvc.perform(get("/api/report/options"))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.employees[0].name").value("测试员工"))
        .andExpect(jsonPath("$.projects[0].name").value("测试项目"))
        .andExpect(jsonPath("$.dictionaries.work_type[0].code").value("project-support"))
        .andExpect(jsonPath("$.nonFormalOptions.length()").value(6));
  }

  @Test
  void usesUnifiedErrorShapeAndCorrelationId() throws Exception {
    mockMvc.perform(post("/api/report/options"))
        .andExpect(status().isMethodNotAllowed())
        .andExpect(header().exists("X-Request-ID"))
        .andExpect(jsonPath("$.code").value("METHOD_NOT_ALLOWED"))
        .andExpect(jsonPath("$.correlationId").isNotEmpty())
        .andExpect(jsonPath("$.timestamp").isNotEmpty());
  }
}
