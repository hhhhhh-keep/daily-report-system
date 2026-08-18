package com.company.daily.report.service;

import com.company.daily.report.api.dto.PersonReportPeriodStatistics;
import com.company.daily.report.api.dto.ReportPeriodStatisticsResponse;
import com.company.daily.workday.WorkdayService;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

@Service
public class ReportPeriodStatisticsService {
  private static final ZoneId BUSINESS_ZONE = ZoneId.of("Asia/Shanghai");
  private static final LocalTime EARLY_CUTOFF = LocalTime.of(17, 30);

  private final JdbcTemplate jdbcTemplate;
  private final ObjectMapper objectMapper;
  private final WorkdayService workdayService;

  public ReportPeriodStatisticsService(
      JdbcTemplate jdbcTemplate, ObjectMapper objectMapper, WorkdayService workdayService) {
    this.jdbcTemplate = jdbcTemplate;
    this.objectMapper = objectMapper;
    this.workdayService = workdayService;
  }

  @Transactional(readOnly = true)
  public ReportPeriodStatisticsResponse statistics(String period, LocalDate anchor) {
    return statistics(periodWindow(period, anchor));
  }

  @Transactional(readOnly = true)
  public ReportPeriodStatisticsResponse statistics(LocalDate start, LocalDate end) {
    if (start == null || end == null) {
      throw new IllegalArgumentException("统计开始日期和结束日期不能为空");
    }
    if (start.isAfter(end)) {
      throw new IllegalArgumentException("统计开始日期不能晚于结束日期");
    }
    return statistics(new PeriodWindow("CUSTOM", start, end));
  }

  private ReportPeriodStatisticsResponse statistics(PeriodWindow window) {
    List<LocalDate> workdays = window.start().datesUntil(window.end().plusDays(1))
        .filter(workdayService::isWorkday)
        .toList();

    Map<Long, Identity> identities = activeIdentities();
    Set<Long> activeIds = new LinkedHashSet<>(identities.keySet());
    Map<LocalDate, Set<Long>> frozenExpected = frozenExpected(window, identities);
    Map<LocalDate, Set<Long>> expectedByDate = new LinkedHashMap<>();
    for (LocalDate workday : workdays) {
      expectedByDate.put(workday,
          frozenExpected.getOrDefault(workday, activeIds));
    }

    Map<Long, MutableStatistics> statistics = new LinkedHashMap<>();
    expectedByDate.values().forEach(ids -> ids.forEach(id -> statistics
        .computeIfAbsent(id, ignored -> new MutableStatistics()).expected++));

    jdbcTemplate.query("select r.employee_id,e.name,e.team_name,r.report_date,r.attendance_status,"
            + "r.submitted_at,r.updated_at from daily_reports r join employees e on e.id=r.employee_id "
            + "where r.report_date between ? and ? order by r.report_date,r.employee_id",
        resultSet -> {
          long employeeId = resultSet.getLong("employee_id");
          LocalDate date = resultSet.getObject("report_date", LocalDate.class);
          if (!expectedByDate.getOrDefault(date, Set.of()).contains(employeeId)) {
            return;
          }
          identities.putIfAbsent(employeeId, new Identity(employeeId,
              resultSet.getString("name"), resultSet.getString("team_name")));
          MutableStatistics item = statistics.computeIfAbsent(employeeId,
              ignored -> new MutableStatistics());
          item.submitted++;
          Timestamp submittedTimestamp = resultSet.getTimestamp("submitted_at");
          Instant cutoff = date.atTime(EARLY_CUTOFF).atZone(BUSINESS_ZONE).toInstant();
          if (submittedTimestamp != null && !submittedTimestamp.toInstant().isAfter(cutoff)) {
            item.early++;
          }
          String attendance = resultSet.getString("attendance_status");
          if ("leave".equals(attendance)) {
            item.leaveOccurrences++;
            item.leaveEquivalentDays = item.leaveEquivalentDays.add(BigDecimal.ONE);
          } else if ("leave-morning".equals(attendance) || "leave-afternoon".equals(attendance)) {
            item.leaveOccurrences++;
            item.leaveEquivalentDays = item.leaveEquivalentDays.add(new BigDecimal("0.5"));
          } else if ("training".equals(attendance)) {
            item.training++;
          }
        }, window.start(), window.end());

    List<PersonReportPeriodStatistics> people = new ArrayList<>();
    for (Map.Entry<Long, MutableStatistics> entry : statistics.entrySet()) {
      Identity identity = identities.getOrDefault(entry.getKey(),
          new Identity(entry.getKey(), "未知人员", ""));
      MutableStatistics item = entry.getValue();
      people.add(new PersonReportPeriodStatistics(identity.id(), identity.name(), identity.team(),
          item.expected, item.early, rate(item.early, item.expected),
          Math.max(0, item.expected - item.submitted), item.leaveOccurrences,
          item.leaveEquivalentDays, item.training));
    }
    people.sort(Comparator.comparing(PersonReportPeriodStatistics::teamName)
        .thenComparing(PersonReportPeriodStatistics::employeeName));

    int expected = people.stream().mapToInt(PersonReportPeriodStatistics::expectedReportCount).sum();
    int early = people.stream().mapToInt(PersonReportPeriodStatistics::earlySubmittedCount).sum();
    int missing = people.stream().mapToInt(PersonReportPeriodStatistics::missingCount).sum();
    int leaveOccurrences = people.stream().mapToInt(PersonReportPeriodStatistics::leaveOccurrences).sum();
    BigDecimal leaveDays = people.stream().map(PersonReportPeriodStatistics::leaveEquivalentDays)
        .reduce(BigDecimal.ZERO, BigDecimal::add);
    int training = people.stream().mapToInt(PersonReportPeriodStatistics::trainingCount).sum();
    ReportPeriodStatisticsResponse.Totals totals = new ReportPeriodStatisticsResponse.Totals(
        expected, early, rate(early, expected), missing, leaveOccurrences, leaveDays, training);
    return new ReportPeriodStatisticsResponse(window.period(), window.start(), window.end(),
        workdays.size(), coverageMode(workdays, frozenExpected), totals, List.copyOf(people));
  }

  private Map<Long, Identity> activeIdentities() {
    Map<Long, Identity> identities = new LinkedHashMap<>();
    jdbcTemplate.query("select id,name,team_name from employees where active=true order by id", rs -> {
      long id = rs.getLong("id");
      identities.put(id, new Identity(id, rs.getString("name"), rs.getString("team_name")));
    });
    return identities;
  }

  private Map<LocalDate, Set<Long>> frozenExpected(
      PeriodWindow window, Map<Long, Identity> identities) {
    Map<LocalDate, Set<Long>> result = new LinkedHashMap<>();
    jdbcTemplate.query("select snapshot_date,submitted_employees_json,missing_employees_json "
            + "from report_statistics_snapshots where snapshot_type='FINAL' "
            + "and snapshot_date between ? and ? order by snapshot_date",
        rs -> {
          LocalDate date = rs.getObject("snapshot_date", LocalDate.class);
          Set<Long> ids = new LinkedHashSet<>();
          readSnapshotPeople(rs.getString("submitted_employees_json"), ids, identities);
          readSnapshotPeople(rs.getString("missing_employees_json"), ids, identities);
          result.put(date, ids);
        }, window.start(), window.end());
    return result;
  }

  private void readSnapshotPeople(
      String json, Set<Long> ids, Map<Long, Identity> identities) {
    try {
      JsonNode root = objectMapper.readTree(json);
      for (JsonNode person : root) {
        long id = person.path("employeeId").asLong();
        if (id <= 0) {
          continue;
        }
        ids.add(id);
        identities.putIfAbsent(id, new Identity(id, person.path("name").asText("未知人员"),
            person.path("teamName").asText("")));
      }
    } catch (Exception exception) {
      throw new IllegalStateException("Invalid report statistics snapshot JSON", exception);
    }
  }

  private static String coverageMode(
      List<LocalDate> workdays, Map<LocalDate, Set<Long>> frozenExpected) {
    long frozen = workdays.stream().filter(frozenExpected::containsKey).count();
    if (frozen == 0) {
      return "CURRENT_ROSTER_FALLBACK";
    }
    return frozen == workdays.size() ? "FROZEN_SNAPSHOTS" : "MIXED_SNAPSHOT_FALLBACK";
  }

  private static PeriodWindow periodWindow(String rawPeriod, LocalDate anchor) {
    String period = rawPeriod == null ? "WEEKLY" : rawPeriod.trim().toUpperCase();
    if ("WEEKLY".equals(period)) {
      LocalDate start = anchor.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
      return new PeriodWindow(period, start, start.plusDays(6));
    }
    if ("MONTHLY".equals(period)) {
      LocalDate start = anchor.withDayOfMonth(1);
      return new PeriodWindow(period, start, anchor.with(TemporalAdjusters.lastDayOfMonth()));
    }
    throw new IllegalArgumentException("period must be WEEKLY or MONTHLY");
  }

  private static BigDecimal rate(int numerator, int denominator) {
    if (denominator == 0) {
      return BigDecimal.ZERO.setScale(2);
    }
    return BigDecimal.valueOf(numerator).multiply(BigDecimal.valueOf(100))
        .divide(BigDecimal.valueOf(denominator), 2, RoundingMode.HALF_UP);
  }

  private record PeriodWindow(String period, LocalDate start, LocalDate end) {}
  private record Identity(long id, String name, String team) {}

  private static final class MutableStatistics {
    private int expected;
    private int submitted;
    private int early;
    private int leaveOccurrences;
    private BigDecimal leaveEquivalentDays = BigDecimal.ZERO;
    private int training;
  }
}
