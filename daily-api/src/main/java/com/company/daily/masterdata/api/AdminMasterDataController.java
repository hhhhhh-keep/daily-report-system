package com.company.daily.masterdata.api;

import com.company.daily.common.api.PageResponse;
import com.company.daily.masterdata.api.dto.AdminDictionaryRequest;
import com.company.daily.masterdata.api.dto.AdminDictionaryResponse;
import com.company.daily.masterdata.api.dto.AdminEmployeeRequest;
import com.company.daily.masterdata.api.dto.AdminEmployeeResponse;
import com.company.daily.masterdata.api.dto.AdminProjectRequest;
import com.company.daily.masterdata.api.dto.AdminProjectResponse;
import com.company.daily.masterdata.api.dto.ProjectActivityResponse;
import com.company.daily.masterdata.service.AdminMasterDataService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin")
public class AdminMasterDataController {
  private final AdminMasterDataService service;

  public AdminMasterDataController(AdminMasterDataService service) {
    this.service = service;
  }

  @GetMapping("/employees")
  public PageResponse<AdminEmployeeResponse> employees(
      @RequestParam(required = false, defaultValue = "0") int page,
      @RequestParam(required = false, defaultValue = "20") int size) {
    return service.employees(page, size);
  }

  @PostMapping("/employees")
  @ResponseStatus(HttpStatus.CREATED)
  public AdminEmployeeResponse createEmployee(@Valid @RequestBody AdminEmployeeRequest request) {
    return service.createEmployee(request);
  }

  @PutMapping("/employees/{id}")
  public AdminEmployeeResponse updateEmployee(
      @PathVariable Long id, @Valid @RequestBody AdminEmployeeRequest request) {
    return service.updateEmployee(id, request);
  }

  @DeleteMapping("/employees/{id}")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void deleteEmployee(@PathVariable Long id) { service.deleteEmployee(id); }

  @GetMapping("/projects")
  public PageResponse<AdminProjectResponse> projects(
      @RequestParam(required = false, defaultValue = "0") int page,
      @RequestParam(required = false, defaultValue = "20") int size) {
    return service.projects(page, size);
  }

  @GetMapping("/projects/{id}/activity")
  public ProjectActivityResponse projectActivity(
      @PathVariable Long id,
      @RequestParam(defaultValue = "30") int days,
      @RequestParam(required = false, defaultValue = "0") int page,
      @RequestParam(required = false, defaultValue = "50") int size) {
    return service.projectActivity(id, days, page, size);
  }

  @PostMapping("/projects")
  @ResponseStatus(HttpStatus.CREATED)
  public AdminProjectResponse createProject(@Valid @RequestBody AdminProjectRequest request) {
    return service.createProject(request);
  }

  @PutMapping("/projects/{id}")
  public AdminProjectResponse updateProject(
      @PathVariable Long id, @Valid @RequestBody AdminProjectRequest request) {
    return service.updateProject(id, request);
  }

  @DeleteMapping("/projects/{id}")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void deleteProject(@PathVariable Long id) { service.deleteProject(id); }

  @GetMapping("/dictionaries")
  public PageResponse<AdminDictionaryResponse> dictionaries(
      @RequestParam(required = false, defaultValue = "0") int page,
      @RequestParam(required = false, defaultValue = "20") int size) {
    return service.dictionaries(page, size);
  }

  @PostMapping("/dictionaries")
  @ResponseStatus(HttpStatus.CREATED)
  public AdminDictionaryResponse createDictionary(
      @Valid @RequestBody AdminDictionaryRequest request) {
    return service.createDictionary(request);
  }

  @PutMapping("/dictionaries/{id}")
  public AdminDictionaryResponse updateDictionary(
      @PathVariable Long id, @Valid @RequestBody AdminDictionaryRequest request) {
    return service.updateDictionary(id, request);
  }

  @DeleteMapping("/dictionaries/{id}")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void deleteDictionary(@PathVariable Long id) { service.deleteDictionary(id); }
}
