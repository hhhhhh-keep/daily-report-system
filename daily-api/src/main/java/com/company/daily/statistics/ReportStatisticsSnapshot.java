package com.company.daily.statistics;

import com.company.daily.common.persistence.AuditedEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;

@Entity
@Table(name = "report_statistics_snapshots", uniqueConstraints = @UniqueConstraint(
    name = "uk_report_statistics_snapshot_type_date",
    columnNames = {"snapshot_type", "snapshot_date"}))
public class ReportStatisticsSnapshot extends AuditedEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Enumerated(EnumType.STRING)
  @Column(name = "snapshot_type", nullable = false, length = 20)
  private ReportStatisticsSnapshotType snapshotType;

  @Column(name = "snapshot_date", nullable = false)
  private LocalDate snapshotDate;

  @Column(name = "captured_at", nullable = false, updatable = false)
  private Instant capturedAt;

  @Column(name = "expected_count", nullable = false)
  private int expectedCount;

  @Column(name = "submitted_count", nullable = false)
  private int submittedCount;

  @Column(name = "missing_count", nullable = false)
  private int missingCount;

  @Column(name = "submission_rate", nullable = false, precision = 6, scale = 4)
  private BigDecimal submissionRate;

  @Column(name = "submitted_employees_json", nullable = false, columnDefinition = "text")
  private String submittedEmployeesJson;

  @Column(name = "missing_employees_json", nullable = false, columnDefinition = "text")
  private String missingEmployeesJson;

  @Column(name = "team_statistics_json", nullable = false, columnDefinition = "text")
  private String teamStatisticsJson;

  @Column(name = "late_submitted_employees_json", nullable = false, columnDefinition = "text")
  private String lateSubmittedEmployeesJson;

  protected ReportStatisticsSnapshot() {}

  private ReportStatisticsSnapshot(
      ReportStatisticsSnapshotType snapshotType,
      LocalDate snapshotDate,
      Instant capturedAt,
      int expectedCount,
      int submittedCount,
      int missingCount,
      BigDecimal submissionRate,
      String submittedEmployeesJson,
      String missingEmployeesJson,
      String teamStatisticsJson,
      String lateSubmittedEmployeesJson) {
    this.snapshotType = snapshotType;
    this.snapshotDate = snapshotDate;
    this.capturedAt = capturedAt;
    this.expectedCount = expectedCount;
    this.submittedCount = submittedCount;
    this.missingCount = missingCount;
    this.submissionRate = submissionRate;
    this.submittedEmployeesJson = submittedEmployeesJson;
    this.missingEmployeesJson = missingEmployeesJson;
    this.teamStatisticsJson = teamStatisticsJson;
    this.lateSubmittedEmployeesJson = lateSubmittedEmployeesJson;
  }

  public static ReportStatisticsSnapshot capture(
      ReportStatisticsSnapshotType snapshotType,
      LocalDate snapshotDate,
      Instant capturedAt,
      int expectedCount,
      int submittedCount,
      int missingCount,
      BigDecimal submissionRate,
      String submittedEmployeesJson,
      String missingEmployeesJson,
      String teamStatisticsJson,
      String lateSubmittedEmployeesJson) {
    return new ReportStatisticsSnapshot(snapshotType, snapshotDate, capturedAt, expectedCount,
        submittedCount, missingCount, submissionRate, submittedEmployeesJson, missingEmployeesJson,
        teamStatisticsJson, lateSubmittedEmployeesJson);
  }

  public Long getId() { return id; }
  public ReportStatisticsSnapshotType getSnapshotType() { return snapshotType; }
  public LocalDate getSnapshotDate() { return snapshotDate; }
  public Instant getCapturedAt() { return capturedAt; }
  public int getExpectedCount() { return expectedCount; }
  public int getSubmittedCount() { return submittedCount; }
  public int getMissingCount() { return missingCount; }
  public BigDecimal getSubmissionRate() { return submissionRate; }
  public String getSubmittedEmployeesJson() { return submittedEmployeesJson; }
  public String getMissingEmployeesJson() { return missingEmployeesJson; }
  public String getTeamStatisticsJson() { return teamStatisticsJson; }
  public String getLateSubmittedEmployeesJson() { return lateSubmittedEmployeesJson; }
}
