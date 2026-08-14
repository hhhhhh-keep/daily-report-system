package com.company.daily.masterdata.repository;

import com.company.daily.masterdata.domain.BusinessDictionary;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BusinessDictionaryRepository extends JpaRepository<BusinessDictionary, Long> {
  List<BusinessDictionary> findAllByActiveTrueOrderByCategoryAscSortOrderAsc();
  List<BusinessDictionary> findAllByOrderByCategoryAscSortOrderAsc();

  boolean existsByCategoryAndCodeAndActiveTrue(String category, String code);
}
