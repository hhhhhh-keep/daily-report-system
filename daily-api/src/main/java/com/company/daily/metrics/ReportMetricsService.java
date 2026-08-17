package com.company.daily.metrics;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReportMetricsService {
  private final JdbcTemplate jdbcTemplate;

  public ReportMetricsService(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
  }

  @Transactional(readOnly = true)
  public ReportMetrics calculate(LocalDate date) {
    return calculate(date, 8);
  }

  @Transactional(readOnly = true)
  public ReportMetrics calculate(LocalDate date, int vagueResultLength) {
    return calculate(date, date, vagueResultLength);
  }

  @Transactional(readOnly = true)
  public ReportMetrics calculate(LocalDate startDate, LocalDate endDate, int vagueResultLength) {
    int employees = scalar("select count(*) from employees where active", endDate, false);
    int reports = rangeScalar("select count(*) from daily_reports where report_date between ? and ?", startDate, endDate);
    String taskBase = " from daily_tasks t join daily_reports r on r.id=t.report_id "
        + "where r.report_date between ? and ?";
    int tasks = rangeScalar("select count(*)" + taskBase, startDate, endDate);
    int projects = rangeScalar("select count(distinct t.project_id)" + taskBase, startDate, endDate);
    int morning = rangeScalar("select count(*)" + taskBase
        + " and t.time_period in ('morning','full-day')", startDate, endDate);
    int afternoon = rangeScalar("select count(*)" + taskBase
        + " and t.time_period in ('afternoon','full-day')", startDate, endDate);
    int abnormal = rangeScalar("select count(*)" + taskBase
        + " and t.current_status in ('at-risk','blocked')", startDate, endDate);
    int waiting = rangeScalar("select count(*)" + taskBase
        + " and t.current_status='in-progress'"
        + " and t.progress_result like '%等待%反馈%'", startDate, endDate);
    int support = rangeScalar("select count(*)" + taskBase
        + " and t.participation_role='temporary-support'", startDate, endDate);
    int vague = jdbcTemplate.queryForObject("select count(*)" + taskBase
        + " and length(trim(t.progress_result)) < ?", Integer.class, startDate, endDate, vagueResultLength);
    int multiProject = rangeScalar("select count(*) from (select r.employee_id" + taskBase
        + " group by r.employee_id having count(distinct t.project_id)>1) value", startDate, endDate);
    int multiPerson = rangeScalar("select count(*) from (select t.project_id" + taskBase
        + " group by t.project_id having count(distinct r.employee_id)>1) value", startDate, endDate);
    return new ReportMetrics(endDate, employees, reports, Math.max(0, employees - reports), tasks,
        projects, morning, afternoon, abnormal, waiting, support, vague, multiProject, multiPerson,
        consecutive("temporary-support", endDate, true),
        consecutiveWaitingFeedback(endDate));
  }

  private int consecutiveWaitingFeedback(LocalDate date) {
    List<GroupedDate> dates = jdbcTemplate.query(
        "select distinct t.project_id group_id,r.report_date from daily_tasks t "
            + "join daily_reports r on r.id=t.report_id "
            + "where t.current_status='in-progress' "
            + "and t.progress_result like '%等待%反馈%' and r.report_date<=? "
            + "order by group_id,r.report_date",
        (rs, row) -> new GroupedDate(rs.getLong("group_id"), rs.getObject("report_date", LocalDate.class)),
        date);
    return maximumConsecutiveDays(dates);
  }

  private int consecutive(String value, LocalDate date, boolean participation) {
    String field = participation ? "t.participation_role" : "t.current_status";
    String grouping = participation ? "r.employee_id" : "t.project_id";
    List<GroupedDate> dates = jdbcTemplate.query(
        "select distinct " + grouping + " group_id,r.report_date from daily_tasks t "
            + "join daily_reports r on r.id=t.report_id where " + field + "=? "
            + "and r.report_date<=? order by group_id,r.report_date",
        (rs, row) -> new GroupedDate(rs.getLong("group_id"), rs.getObject("report_date", LocalDate.class)),
        value, date);
    return maximumConsecutiveDays(dates);
  }

  private int maximumConsecutiveDays(List<GroupedDate> dates) {
    Map<Long, List<LocalDate>> grouped = new HashMap<>();
    dates.forEach(item -> grouped.computeIfAbsent(item.groupId(), ignored -> new ArrayList<>()).add(item.date()));
    int maximum = 0;
    for (List<LocalDate> groupDates : grouped.values()) {
      int current = 0;
      LocalDate previous = null;
      for (LocalDate currentDate : groupDates) {
        current = previous != null && ChronoUnit.DAYS.between(previous, currentDate) == 1
            ? current + 1 : 1;
        maximum = Math.max(maximum, current);
        previous = currentDate;
      }
    }
    return maximum;
  }

  private int scalar(String sql, LocalDate date, boolean usesDate) {
    Integer result = usesDate ? jdbcTemplate.queryForObject(sql, Integer.class, date)
        : jdbcTemplate.queryForObject(sql, Integer.class);
    return result == null ? 0 : result;
  }

  private int rangeScalar(String sql, LocalDate startDate, LocalDate endDate) {
    Integer result = jdbcTemplate.queryForObject(sql, Integer.class, startDate, endDate);
    return result == null ? 0 : result;
  }

  private record GroupedDate(long groupId, LocalDate date) {}
}
