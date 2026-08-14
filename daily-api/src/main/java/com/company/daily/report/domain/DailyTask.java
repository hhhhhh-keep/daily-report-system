package com.company.daily.report.domain;

import com.company.daily.common.persistence.AuditedEntity;
import com.company.daily.masterdata.domain.Project;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "daily_tasks")
public class DailyTask extends AuditedEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "report_id", nullable = false)
  private DailyReport report;

  @Column(name = "time_period", nullable = false)
  private TimePeriod timePeriod;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "project_id", nullable = false)
  private Project project;

  @Column(name = "work_type", nullable = false)
  private String workType;

  @Column(name = "work_stage")
  private String workStage;

  @Column(name = "participation_role", nullable = false)
  private ParticipationRole participationRole;

  @Column(name = "progress_result", nullable = false)
  private String progressResult;

  @Column(name = "current_status", nullable = false)
  private CurrentStatus currentStatus;

  @Column(name = "issue_type")
  private String issueType;

  @Column(name = "collaboration_role")
  private String collaborationRole;

  @Column(name = "collaboration_requirement")
  private String collaborationRequirement;

  protected DailyTask() {}

  private DailyTask(
      DailyReport report,
      Project project,
      TimePeriod timePeriod,
      String workType,
      String workStage,
      ParticipationRole participationRole,
      String progressResult,
      CurrentStatus currentStatus,
      String issueType,
      String collaborationRole,
      String collaborationRequirement) {
    this.report = report;
    this.project = project;
    this.timePeriod = timePeriod;
    this.workType = workType;
    this.workStage = workStage;
    this.participationRole = participationRole;
    this.progressResult = progressResult;
    this.currentStatus = currentStatus;
    this.issueType = issueType;
    this.collaborationRole = collaborationRole;
    this.collaborationRequirement = collaborationRequirement;
  }

  public static DailyTask create(
      DailyReport report,
      Project project,
      TimePeriod timePeriod,
      String workType,
      String workStage,
      ParticipationRole participationRole,
      String progressResult,
      CurrentStatus currentStatus,
      String issueType,
      String collaborationRole,
      String collaborationRequirement) {
    return new DailyTask(
        report,
        project,
        timePeriod,
        workType,
        workStage,
        participationRole,
        progressResult,
        currentStatus,
        issueType,
        collaborationRole,
        collaborationRequirement);
  }

  public static DailyTask create(
      DailyReport report,
      Project project,
      TimePeriod timePeriod,
      String workType,
      ParticipationRole participationRole,
      String progressResult,
      CurrentStatus currentStatus,
      String issueType,
      String collaborationRole,
      String collaborationRequirement) {
    return create(report, project, timePeriod, workType, null, participationRole, progressResult,
        currentStatus, issueType, collaborationRole, collaborationRequirement);
  }

  public Long getId() {
    return id;
  }

  public DailyReport getReport() {
    return report;
  }

  public TimePeriod getTimePeriod() {
    return timePeriod;
  }

  public Project getProject() {
    return project;
  }

  public String getWorkType() {
    return workType;
  }

  public String getWorkStage() { return workStage; }

  public ParticipationRole getParticipationRole() {
    return participationRole;
  }

  public String getProgressResult() {
    return progressResult;
  }

  public CurrentStatus getCurrentStatus() {
    return currentStatus;
  }

  public String getIssueType() {
    return issueType;
  }

  public String getCollaborationRole() {
    return collaborationRole;
  }

  public String getCollaborationRequirement() {
    return collaborationRequirement;
  }
}
