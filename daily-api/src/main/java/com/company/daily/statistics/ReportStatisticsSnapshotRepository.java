package com.company.daily.statistics;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportStatisticsSnapshotRepository
    extends JpaRepository<ReportStatisticsSnapshot, Long> {
  Optional<ReportStatisticsSnapshot> findBySnapshotTypeAndSnapshotDate(
      ReportStatisticsSnapshotType snapshotType, LocalDate snapshotDate);

  List<ReportStatisticsSnapshot> findAllBySnapshotDateBetweenOrderBySnapshotDateDescCapturedAtDesc(
      LocalDate startDate, LocalDate endDate);
}
