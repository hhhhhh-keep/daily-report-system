package com.company.daily.statistics;

import com.company.daily.workday.WorkdayService;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Clock;
import java.time.Instant;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import tools.jackson.core.type.TypeReference;
import tools.jackson.databind.ObjectMapper;

@Service
public class ReportStatisticsService {
  private static final TypeReference<List<SnapshotEmployee>> EMPLOYEE_LIST = new TypeReference<>() {};
  private static final TypeReference<List<TeamSubmissionStatistics>> TEAM_LIST =
      new TypeReference<>() {};

  private final WorkdayService workdayService;
  private final ReportStatisticsSnapshotRepository snapshotRepository;
  private final ReportStatisticsQueryRepository queryRepository;
  private final ObjectMapper objectMapper;
  private final Clock clock;

  @Autowired
  public ReportStatisticsService(
      WorkdayService workdayService,
      ReportStatisticsSnapshotRepository snapshotRepository,
      ReportStatisticsQueryRepository queryRepository,
      ObjectMapper objectMapper) {
    this(workdayService, snapshotRepository, queryRepository, objectMapper, Clock.systemDefaultZone());
  }

  ReportStatisticsService(
      WorkdayService workdayService,
      ReportStatisticsSnapshotRepository snapshotRepository,
      ReportStatisticsQueryRepository queryRepository,
      ObjectMapper objectMapper,
      Clock clock) {
    this.workdayService = workdayService;
    this.snapshotRepository = snapshotRepository;
    this.queryRepository = queryRepository;
    this.objectMapper = objectMapper;
    this.clock = clock;
  }

  @Transactional
  public Optional<ReportStatisticsSnapshotResponse> capture(
      LocalDate date, ReportStatisticsSnapshotType type) {
    if (!workdayService.isWorkday(date)) {
      return Optional.empty();
    }
    Optional<ReportStatisticsSnapshot> existing =
        snapshotRepository.findBySnapshotTypeAndSnapshotDate(type, date);
    if (existing.isPresent()) {
      return Optional.of(response(existing.get()));
    }

    Instant capturedAt = clock.instant();
    Map<Long, StatisticsSubmission> submissions = queryRepository.submittedReports(date).stream()
        .filter(submission -> !submission.submittedAt().isAfter(capturedAt))
        .collect(Collectors.toMap(StatisticsSubmission::employeeId, submission -> submission));
    List<StatisticsEmployee> employees = queryRepository.activeEmployees();
    List<SnapshotEmployee> submitted = employees.stream()
        .filter(employee -> submissions.containsKey(employee.employeeId()))
        .map(employee -> snapshot(employee, submissions.get(employee.employeeId()).submittedAt()))
        .toList();
    List<SnapshotEmployee> missing = employees.stream()
        .filter(employee -> !submissions.containsKey(employee.employeeId()))
        .map(employee -> snapshot(employee, null)).toList();
    List<TeamSubmissionStatistics> teams = teamStatistics(employees, submissions.keySet());
    BigDecimal submissionRate = ratio(submitted.size(), employees.size());
    ReportStatisticsSnapshot created = ReportStatisticsSnapshot.capture(type, date, capturedAt,
        employees.size(), submitted.size(), missing.size(), submissionRate, json(submitted), json(missing),
        json(teams), "[]");
    return Optional.of(response(snapshotRepository.save(created)));
  }

  @Transactional(readOnly = true)
  public List<ReportStatisticsSnapshotResponse> list(LocalDate startDate, LocalDate endDate) {
    return snapshotRepository.findAllBySnapshotDateBetweenOrderBySnapshotDateDescCapturedAtDesc(
        startDate, endDate).stream().map(this::response).toList();
  }

  private List<TeamSubmissionStatistics> teamStatistics(
      List<StatisticsEmployee> employees, Set<Long> submittedEmployeeIds) {
    Map<String, List<StatisticsEmployee>> byTeam = employees.stream().collect(Collectors.groupingBy(
        employee -> employee.teamName() == null ? "" : employee.teamName(), LinkedHashMap::new,
        Collectors.toList()));
    return byTeam.entrySet().stream().map(entry -> {
      int expected = entry.getValue().size();
      int submitted = (int) entry.getValue().stream().map(StatisticsEmployee::employeeId)
          .filter(submittedEmployeeIds::contains).count();
      return new TeamSubmissionStatistics(entry.getKey(), expected, submitted, expected - submitted,
          ratio(submitted, expected));
    }).sorted(Comparator.comparing(TeamSubmissionStatistics::teamName)).toList();
  }

  private SnapshotEmployee snapshot(StatisticsEmployee employee, Instant submittedAt) {
    return new SnapshotEmployee(employee.employeeId(), employee.name(), employee.teamName(), submittedAt);
  }

  private BigDecimal ratio(int numerator, int denominator) {
    return denominator == 0 ? BigDecimal.ZERO : BigDecimal.valueOf(numerator)
        .divide(BigDecimal.valueOf(denominator), 4, RoundingMode.HALF_UP);
  }

  private String json(Object value) {
    try {
      return objectMapper.writeValueAsString(value);
    } catch (Exception exception) {
      throw new IllegalStateException("Unable to serialize statistics snapshot", exception);
    }
  }

  private List<SnapshotEmployee> employees(String json) {
    try {
      return objectMapper.readValue(json, EMPLOYEE_LIST);
    } catch (Exception exception) {
      throw new IllegalStateException("Unable to read statistics snapshot employees", exception);
    }
  }

  private ReportStatisticsSnapshotResponse response(ReportStatisticsSnapshot snapshot) {
    return new ReportStatisticsSnapshotResponse(snapshot.getId(), snapshot.getSnapshotType(),
        snapshot.getSnapshotDate(), snapshot.getCapturedAt(), snapshot.getExpectedCount(),
        snapshot.getSubmittedCount(), snapshot.getMissingCount(), snapshot.getSubmissionRate(),
        employees(snapshot.getSubmittedEmployeesJson()), employees(snapshot.getMissingEmployeesJson()),
        employees(snapshot.getLateSubmittedEmployeesJson()), teams(snapshot.getTeamStatisticsJson()));
  }

  private List<TeamSubmissionStatistics> teams(String json) {
    try {
      return objectMapper.readValue(json, TEAM_LIST);
    } catch (Exception exception) {
      throw new IllegalStateException("Unable to read statistics snapshot teams", exception);
    }
  }
}
