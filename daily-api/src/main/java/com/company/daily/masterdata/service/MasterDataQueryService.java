package com.company.daily.masterdata.service;

import com.company.daily.masterdata.api.dto.DictionaryOption;
import com.company.daily.masterdata.api.dto.EmployeeOption;
import com.company.daily.masterdata.api.dto.NonFormalOption;
import com.company.daily.masterdata.api.dto.ProjectOption;
import com.company.daily.masterdata.domain.BusinessDictionary;
import com.company.daily.masterdata.domain.Employee;
import com.company.daily.masterdata.domain.Project;
import com.company.daily.masterdata.repository.BusinessDictionaryRepository;
import com.company.daily.masterdata.repository.EmployeeRepository;
import com.company.daily.masterdata.repository.ProjectRepository;
import com.company.daily.report.api.dto.ReportOptionsResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class MasterDataQueryService {
  private final EmployeeRepository employeeRepository;
  private final ProjectRepository projectRepository;
  private final BusinessDictionaryRepository dictionaryRepository;

  public MasterDataQueryService(
      EmployeeRepository employeeRepository,
      ProjectRepository projectRepository,
      BusinessDictionaryRepository dictionaryRepository) {
    this.employeeRepository = employeeRepository;
    this.projectRepository = projectRepository;
    this.dictionaryRepository = dictionaryRepository;
  }

  public ReportOptionsResponse getReportOptions() {
    List<EmployeeOption> employees = employeeRepository.findAllByActiveTrueOrderByNameAsc().stream()
        .map(this::toEmployeeOption)
        .toList();
    List<ProjectOption> projects = projectRepository.findAllByFormalTrueAndActiveTrueOrderByNameAsc().stream()
        .map(this::toProjectOption)
        .toList();
    List<NonFormalOption> nonFormalOptions =
        projectRepository.findAllByFormalFalseAndActiveTrueOrderByIdAsc().stream()
            .map(project -> new NonFormalOption(project.getId(), project.getSystemKey(), project.getName()))
            .toList();
    Map<String, List<DictionaryOption>> dictionaries = new LinkedHashMap<>();
    for (BusinessDictionary item : dictionaryRepository.findAllByActiveTrueOrderByCategoryAscSortOrderAsc()) {
      dictionaries.computeIfAbsent(item.getCategory(), ignored -> new java.util.ArrayList<>())
          .add(new DictionaryOption(item.getId(), item.getCode(), item.getLabel()));
    }
    return new ReportOptionsResponse(employees, projects, dictionaries, nonFormalOptions);
  }

  private EmployeeOption toEmployeeOption(Employee employee) {
    return new EmployeeOption(
        employee.getId(), employee.getName(), employee.getTeamName(), employee.getPositionType());
  }

  private ProjectOption toProjectOption(Project project) {
    return new ProjectOption(
        project.getId(), project.getName(), project.getCustomerName(), project.getIndustry(),
        project.getProjectStage(), project.getOwnerName(), project.getPriority(), project.getStatus(),
        project.getCode());
  }
}
