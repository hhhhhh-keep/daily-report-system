package com.company.daily.report.service;

import com.company.daily.report.repository.DailyReportRepository;
import com.company.daily.statistics.ReportStatisticsSnapshotRepository;
import com.company.daily.statistics.ReportStatisticsSnapshotType;
import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DailyReportLockService {
  private final DailyReportRepository reportRepository;
  private final ReportStatisticsSnapshotRepository snapshotRepository;
  private final Clock clock;

  @Autowired
  public DailyReportLockService(
      DailyReportRepository reportRepository,
      ReportStatisticsSnapshotRepository snapshotRepository) {
    this(reportRepository, snapshotRepository, Clock.system(ZoneId.of("Asia/Shanghai")));
  }

  DailyReportLockService(
      DailyReportRepository reportRepository,
      ReportStatisticsSnapshotRepository snapshotRepository,
      Clock clock) {
    this.reportRepository = reportRepository;
    this.snapshotRepository = snapshotRepository;
    this.clock = clock;
  }

  @Transactional
  public void lockDate(LocalDate date) {
    reportRepository.findAllForAdministrationByDate(date)
        .forEach(report -> report.lock(clock.instant()));
  }

  @Transactional(readOnly = true)
  public void requireOpen(LocalDate date) {
    if (snapshotRepository
        .findBySnapshotTypeAndSnapshotDate(ReportStatisticsSnapshotType.FINAL, date)
        .isPresent()) {
      throw new IllegalStateException("The daily report is locked after final statistics");
    }
  }
}
