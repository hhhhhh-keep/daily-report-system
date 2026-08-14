package com.company.daily.report.repository;

import com.company.daily.report.domain.DailyReport;
import java.time.LocalDate;
import java.util.Optional;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface DailyReportRepository extends JpaRepository<DailyReport, Long> {
  @EntityGraph(attributePaths = "employee")
  Optional<DailyReport> findByEmployeeIdAndReportDate(Long employeeId, LocalDate reportDate);

  @Query("select report from DailyReport report join fetch report.employee employee "
      + "order by report.reportDate desc, employee.name asc")
  List<DailyReport> findAllForAdministration();

  @Query("select report from DailyReport report join fetch report.employee employee "
      + "where report.reportDate = :date order by employee.name asc")
  List<DailyReport> findAllForAdministrationByDate(@Param("date") LocalDate date);

  @Query("select report from DailyReport report join fetch report.employee employee "
      + "where employee.id = :employeeId order by report.reportDate desc")
  List<DailyReport> findAllForAdministrationByEmployee(@Param("employeeId") Long employeeId);

  @Query("select report from DailyReport report join fetch report.employee employee "
      + "where report.reportDate = :date and employee.id = :employeeId "
      + "order by report.reportDate desc")
  List<DailyReport> findAllForAdministrationByDateAndEmployee(
      @Param("date") LocalDate date, @Param("employeeId") Long employeeId);

  /**
   * 统一检索（分页版）：根据 date / employeeId / attendance / keyword 任意组合过滤；
   * keyword 模糊匹配项目名（project.name）或任务内容（progress_result），用 exists 子查询
   * 避免笛卡尔积。Pageable 携带排序（默认 report_date desc, employee.name asc）。
   *
   * <p>{@code countQuery} 与主查询使用同一套过滤条件，保证 total 与 items 一致；
   * 主查询用 {@code distinct} 抵消 join fetch 重复行；{@code Pageable} 接收 Spring Data
   * 翻译的 LIMIT/OFFSET，与 JOIN FETCH 协作正常（ManyToOne 不触发 in-memory 分页警告）。
   */
  @Query(value = "select distinct report from DailyReport report "
      + "join fetch report.employee employee "
      + "where coalesce(:date, report.reportDate) = report.reportDate "
      + "and coalesce(:employeeId, employee.id) = employee.id "
      + "and (coalesce(:attendanceCount, 0) = 0 or report.attendanceStatus in :attendances) "
      + "and (coalesce(:hasKeyword, false) = false or exists ("
      + "  select 1 from DailyTask task join task.project project "
      + "  where task.report = report "
      + "    and (lower(project.name) like lower(concat('%', :keyword, '%')) "
      + "      or lower(task.progressResult) like lower(concat('%', :keyword, '%')))))",
      countQuery = "select count(distinct report) from DailyReport report "
      + "join report.employee employee "
      + "where coalesce(:date, report.reportDate) = report.reportDate "
      + "and coalesce(:employeeId, employee.id) = employee.id "
      + "and (coalesce(:attendanceCount, 0) = 0 or report.attendanceStatus in :attendances) "
      + "and (coalesce(:hasKeyword, false) = false or exists ("
      + "  select 1 from DailyTask task join task.project project "
      + "  where task.report = report "
      + "    and (lower(project.name) like lower(concat('%', :keyword, '%')) "
      + "      or lower(task.progressResult) like lower(concat('%', :keyword, '%')))))")
  Page<DailyReport> searchForAdministration(
      @Param("date") LocalDate date,
      @Param("employeeId") Long employeeId,
      @Param("attendances") List<String> attendances,
      @Param("attendanceCount") Integer attendanceCount,
      @Param("keyword") String keyword,
      @Param("hasKeyword") Boolean hasKeyword,
      Pageable pageable);
}
