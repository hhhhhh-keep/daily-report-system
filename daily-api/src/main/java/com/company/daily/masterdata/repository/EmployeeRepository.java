package com.company.daily.masterdata.repository;

import com.company.daily.masterdata.domain.Employee;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
  List<Employee> findAllByActiveTrueOrderByNameAsc();
  List<Employee> findAllByOrderByNameAsc();
}
