package com.company.daily.masterdata.service;

import com.company.daily.common.api.PageResponse;
import com.company.daily.common.api.ResourceNotFoundException;
import com.company.daily.masterdata.api.dto.AdminDictionaryRequest;
import com.company.daily.masterdata.api.dto.AdminDictionaryResponse;
import com.company.daily.masterdata.api.dto.AdminEmployeeRequest;
import com.company.daily.masterdata.api.dto.AdminEmployeeResponse;
import com.company.daily.masterdata.api.dto.AdminProjectRequest;
import com.company.daily.masterdata.api.dto.AdminProjectResponse;
import com.company.daily.masterdata.api.dto.ProjectActivityResponse;
import com.company.daily.masterdata.api.dto.ProjectActivityTaskResponse;
import com.company.daily.masterdata.domain.BusinessDictionary;
import com.company.daily.masterdata.domain.Employee;
import com.company.daily.masterdata.domain.Project;
import com.company.daily.masterdata.repository.BusinessDictionaryRepository;
import com.company.daily.masterdata.repository.EmployeeRepository;
import com.company.daily.masterdata.repository.ProjectRepository;
import com.company.daily.masterdata.state.ProjectDerivedStateService;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class AdminMasterDataService {
  private final EmployeeRepository employeeRepository;
  private final ProjectRepository projectRepository;
  private final BusinessDictionaryRepository dictionaryRepository;
  private final JdbcTemplate jdbcTemplate;
  private final ProjectDerivedStateService derivedStateService;

  public AdminMasterDataService(
      EmployeeRepository employeeRepository,
      ProjectRepository projectRepository,
      BusinessDictionaryRepository dictionaryRepository,
      JdbcTemplate jdbcTemplate,
      ProjectDerivedStateService derivedStateService) {
    this.employeeRepository = employeeRepository;
    this.projectRepository = projectRepository;
    this.dictionaryRepository = dictionaryRepository;
    this.jdbcTemplate = jdbcTemplate;
    this.derivedStateService = derivedStateService;
  }

  @Transactional(readOnly = true)
  public PageResponse<AdminEmployeeResponse> employees(int page, int size) {
    PageRequest req = PageRequest.of(Math.max(0, page), clampSize(size));
    Page<Employee> result = employeeRepository.findAll(req);
    List<AdminEmployeeResponse> items = result.getContent().stream().map(this::employee).toList();
    return PageResponse.of(items, result.getTotalElements(), req.getPageNumber(), req.getPageSize());
  }

  @Transactional
  public AdminEmployeeResponse createEmployee(AdminEmployeeRequest request) {
    return employee(employeeRepository.save(new Employee(trim(request.name()), trim(request.teamName()),
        trim(request.positionType()), request.active())));
  }

  @Transactional
  public AdminEmployeeResponse updateEmployee(Long id, AdminEmployeeRequest request) {
    Employee value = employeeRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("人员不存在"));
    value.update(trim(request.name()), trim(request.teamName()), trim(request.positionType()),
        request.active());
    return employee(value);
  }

  @Transactional
  public void deleteEmployee(Long id) {
    Employee value = employeeRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("人员不存在"));
    value.deactivate();
  }

  @Transactional(readOnly = true)
  public PageResponse<AdminProjectResponse> projects(int page, int size) {
    PageRequest req = PageRequest.of(Math.max(0, page), clampSize(size));
    Page<Project> result = projectRepository.findAll(req);
    List<AdminProjectResponse> items = result.getContent().stream().map(this::project).toList();
    return PageResponse.of(items, result.getTotalElements(), req.getPageNumber(), req.getPageSize());
  }

  @Transactional(readOnly = true)
  public ProjectActivityResponse projectActivity(Long projectId, int days, int page, int size) {
    if (!projectRepository.existsById(projectId)) {
      throw new ResourceNotFoundException("项目不存在");
    }
    int safePage = Math.max(0, page);
    int safeSize = clampSize(size, 50);
    ProjectActivityWindow window = ProjectActivityWindow.of(
        LocalDate.now(ZoneId.of("Asia/Shanghai")), days);
    String periodClause = window.startDate() == null ? "" : " and r.report_date >= ?";
    Object[] baseArgs = queryArguments(projectId, window);
    // 先数总条数，给前端分页控件用
    String countSql = "select count(*) from daily_tasks t "
        + "join daily_reports r on r.id=t.report_id "
        + "where t.project_id=?" + (window.startDate() == null ? "" : " and r.report_date >= ? and r.report_date <= ?");
    long total = jdbcTemplate.queryForObject(countSql, Long.class, baseArgs);
    int offset = safePage * safeSize;
    Object[] pageArgs = new Object[baseArgs.length + 2];
    System.arraycopy(baseArgs, 0, pageArgs, 0, baseArgs.length);
    pageArgs[baseArgs.length] = safeSize;
    pageArgs[baseArgs.length + 1] = offset;
    List<ProjectActivityTaskResponse> tasks = jdbcTemplate.query("""
        select t.id, r.report_date, e.id, e.name, t.work_stage, t.current_status,
          t.progress_result, t.issue_type, t.collaboration_requirement
        from daily_tasks t
        join daily_reports r on r.id=t.report_id
        join employees e on e.id=r.employee_id
        where t.project_id=? and r.report_date <= ?""" + periodClause
        + " order by r.report_date desc, e.name, t.id limit ? offset ?",
        (rs, row) -> new ProjectActivityTaskResponse(rs.getLong(1), rs.getObject(2, LocalDate.class),
            rs.getLong(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
            rs.getString(8), rs.getString(9)), pageArgs);
    // 注意：参与者数 / blocked 数 / 最新日期仍然按当前页计算；
    // 如果数据跨多页需要全量聚合，可后续在 SQL 里以窗口函数实现，但当前 UI 隐含按页展示，保留即可。
    LocalDate latest = tasks.isEmpty() ? null : tasks.getFirst().reportDate();
    int participants = (int) tasks.stream().map(ProjectActivityTaskResponse::employeeId).distinct().count();
    int blocked = (int) tasks.stream().filter(task -> "blocked".equals(task.currentStatus())
        || "paused".equals(task.currentStatus())).count();
    return new ProjectActivityResponse(projectId, participants, latest, blocked,
        derivedStateService.current(projectId).orElse(null), derivedStateService.events(projectId),
        tasks, safePage, safeSize, total);
  }

  private Object[] queryArguments(Long projectId, ProjectActivityWindow window) {
    return window.startDate() == null ? new Object[] {projectId, window.endDate()}
        : new Object[] {projectId, window.endDate(), window.startDate()};
  }

  @Transactional
  public AdminProjectResponse createProject(AdminProjectRequest request) {
    validateProject(request);
    Project value = new Project(trim(request.name()), optional(request.customerName()),
        optional(request.industry()), optional(request.projectStage()), optional(request.ownerName()),
        optional(request.priority()), trim(request.status()), optional(request.code()), request.formal(),
        optional(request.systemKey()), request.active());
    return project(projectRepository.save(value));
  }

  @Transactional
  public AdminProjectResponse updateProject(Long id, AdminProjectRequest request) {
    validateProject(request);
    Project value = projectRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("项目不存在"));
    value.update(trim(request.name()), optional(request.customerName()), optional(request.industry()),
        optional(request.projectStage()), optional(request.ownerName()), optional(request.priority()),
        trim(request.status()), optional(request.code()), request.formal(), optional(request.systemKey()),
        request.active());
    return project(value);
  }

  @Transactional
  public void deleteProject(Long id) {
    Project value = projectRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("项目不存在"));
    value.deactivate();
  }

  @Transactional(readOnly = true)
  public PageResponse<AdminDictionaryResponse> dictionaries(int page, int size) {
    PageRequest req = PageRequest.of(Math.max(0, page), clampSize(size));
    Page<BusinessDictionary> result = dictionaryRepository.findAll(req);
    List<AdminDictionaryResponse> items = result.getContent().stream().map(this::dictionary).toList();
    return PageResponse.of(items, result.getTotalElements(), req.getPageNumber(), req.getPageSize());
  }

  @Transactional
  public AdminDictionaryResponse createDictionary(AdminDictionaryRequest request) {
    BusinessDictionary value = new BusinessDictionary(trim(request.category()), trim(request.code()),
        trim(request.label()), request.sortOrder(), request.active());
    return dictionary(dictionaryRepository.save(value));
  }

  @Transactional
  public AdminDictionaryResponse updateDictionary(Long id, AdminDictionaryRequest request) {
    BusinessDictionary value = dictionaryRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("字典项不存在"));
    value.update(trim(request.category()), trim(request.code()), trim(request.label()),
        request.sortOrder(), request.active());
    return dictionary(value);
  }

  @Transactional
  public void deleteDictionary(Long id) {
    BusinessDictionary value = dictionaryRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("字典项不存在"));
    value.deactivate();
  }

  private static int clampSize(int size) {
    return clampSize(size, 200);
  }

  private static int clampSize(int size, int max) {
    if (size <= 0) {
      return 20;
    }
    return Math.min(size, max);
  }

  private void validateProject(AdminProjectRequest request) {
    if (request.formal() && StringUtils.hasText(request.systemKey())) {
      throw new IllegalArgumentException("正式项目不能设置系统标识");
    }
    if (!request.formal() && !StringUtils.hasText(request.systemKey())) {
      throw new IllegalArgumentException("非正式项目必须设置系统标识");
    }
  }

  private AdminEmployeeResponse employee(Employee value) {
    return new AdminEmployeeResponse(value.getId(), value.getName(), value.getTeamName(),
        value.getPositionType(), value.isActive());
  }

  private AdminProjectResponse project(Project value) {
    return new AdminProjectResponse(value.getId(), value.getName(), value.getCustomerName(),
        value.getIndustry(), value.getProjectStage(), value.getOwnerName(), value.getPriority(),
        value.getStatus(), value.getCode(), value.isFormal(), value.getSystemKey(), value.isActive());
  }

  private AdminDictionaryResponse dictionary(BusinessDictionary value) {
    return new AdminDictionaryResponse(value.getId(), value.getCategory(), value.getCode(),
        value.getLabel(), value.getSortOrder(), value.isActive());
  }

  private static String trim(String value) { return value.trim(); }

  private static String optional(String value) {
    return StringUtils.hasText(value) ? value.trim() : null;
  }
}
