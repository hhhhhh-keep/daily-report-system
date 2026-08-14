package com.company.daily.report.domain;

import com.company.daily.common.persistence.AuditedEntity;
import com.company.daily.masterdata.domain.Employee;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.Instant;
import java.time.LocalDate;

@Entity
@Table(name = "daily_reports")
public class DailyReport extends AuditedEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "report_date", nullable = false)
  private LocalDate reportDate;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "employee_id", nullable = false)
  private Employee employee;

  @Column(name = "attendance_status", nullable = false)
  private String attendanceStatus;

  private String note;

  @Column(nullable = false)
  private String status;

  @Column(name = "submitted_at", nullable = false, updatable = false)
  private Instant submittedAt;

  @Column(name = "locked_at")
  private Instant lockedAt;

  protected DailyReport() {}

  private DailyReport(Employee employee, LocalDate reportDate, String attendanceStatus, String note) {
    this.employee = employee;
    this.reportDate = reportDate;
    this.attendanceStatus = attendanceStatus;
    this.note = note;
    this.status = "submitted";
    this.submittedAt = Instant.now();
  }

  public static DailyReport create(
      Employee employee, LocalDate reportDate, String attendanceStatus, String note) {
    return new DailyReport(employee, reportDate, attendanceStatus, note);
  }

  public void update(String attendanceStatus, String note) {
    if (isLocked()) {
      throw new IllegalStateException("This daily report is locked");
    }
    this.attendanceStatus = attendanceStatus;
    this.note = note;
  }

  public void lock(Instant lockedAt) {
    this.lockedAt = lockedAt;
  }

  public boolean isLocked() {
    return lockedAt != null;
  }

  public Long getId() {
    return id;
  }

  public LocalDate getReportDate() {
    return reportDate;
  }

  public Employee getEmployee() {
    return employee;
  }

  public String getAttendanceStatus() {
    return attendanceStatus;
  }

  public String getNote() {
    return note;
  }

  public String getStatus() {
    return status;
  }

  public Instant getSubmittedAt() {
    return submittedAt;
  }

  public Instant getLockedAt() {
    return lockedAt;
  }
}
