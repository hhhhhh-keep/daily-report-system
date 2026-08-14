package com.company.daily.workday;

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
import java.time.LocalDate;

@Entity
@Table(name = "workday_calendar", uniqueConstraints = @UniqueConstraint(
    name = "uk_workday_calendar_date_source", columnNames = {"calendar_date", "source"}))
public class WorkdayCalendar extends AuditedEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "calendar_date", nullable = false)
  private LocalDate calendarDate;

  @Column(nullable = false)
  private boolean workday;

  @Enumerated(EnumType.STRING)
  @Column(nullable = false, length = 40)
  private WorkdaySource source;

  @Column(length = 500)
  private String note;

  @Column(nullable = false)
  private boolean active;

  protected WorkdayCalendar() {}

  private WorkdayCalendar(
      LocalDate calendarDate, boolean workday, WorkdaySource source, String note) {
    update(calendarDate, workday, source, note);
    this.active = true;
  }

  public static WorkdayCalendar administratorOverride(
      LocalDate date, boolean workday, String note) {
    return new WorkdayCalendar(date, workday, WorkdaySource.ADMIN_OVERRIDE, note);
  }

  public static WorkdayCalendar imported(
      LocalDate date, boolean workday, WorkdaySource source, String note) {
    if (source == WorkdaySource.ADMIN_OVERRIDE) {
      throw new IllegalArgumentException("导入记录不能使用管理员覆盖来源");
    }
    return new WorkdayCalendar(date, workday, source, note);
  }

  public void update(LocalDate date, boolean isWorkday, WorkdaySource newSource, String newNote) {
    this.calendarDate = date;
    this.workday = isWorkday;
    this.source = newSource;
    this.note = newNote;
  }

  public void reactivate(boolean isWorkday, String newNote) {
    this.workday = isWorkday;
    this.note = newNote;
    this.active = true;
  }

  public void deactivate() {
    this.active = false;
  }

  public Long getId() {
    return id;
  }

  public LocalDate getCalendarDate() {
    return calendarDate;
  }

  public boolean isWorkday() {
    return workday;
  }

  public WorkdaySource getSource() {
    return source;
  }

  public String getNote() {
    return note;
  }

  public boolean isActive() {
    return active;
  }

  int priority() {
    return source.priority();
  }
}
