package com.company.daily.admin.repository;

import com.company.daily.admin.domain.Administrator;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdministratorRepository extends JpaRepository<Administrator, Short> {
  Optional<Administrator> findByUsername(String username);
}
