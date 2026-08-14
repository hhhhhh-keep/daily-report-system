package com.company.daily.masterdata.repository;

import com.company.daily.masterdata.domain.Project;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectRepository extends JpaRepository<Project, Long> {
  List<Project> findAllByFormalTrueAndActiveTrueOrderByNameAsc();
  List<Project> findAllByFormalFalseAndActiveTrueOrderByIdAsc();
  List<Project> findAllByOrderByNameAsc();
  Optional<Project> findFirstByNameAndActiveTrue(String name);
}
