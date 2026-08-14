package com.company.daily.report.repository;

import com.company.daily.report.domain.DailyTask;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface DailyTaskRepository extends JpaRepository<DailyTask, Long> {
  @EntityGraph(attributePaths = "project")
  List<DailyTask> findAllByReportIdOrderById(Long reportId);

  /**
   * 批量统计一批日报各自的任务条数，避免 N+1：
   * 单条 SELECT + GROUP BY 把 N 次往返压成 1 次。
   * 返回的 {@code (report_id, count)} 元组；调用方按 report_id 查表填充。
   */
  @Query("select task.report.id as reportId, count(task) as taskCount "
      + "from DailyTask task where task.report.id in :reportIds "
      + "group by task.report.id")
  List<ReportTaskCount> countByReportIdIn(@Param("reportIds") Collection<Long> reportIds);

  interface ReportTaskCount {
    Long getReportId();
    long getTaskCount();
  }

  @Modifying
  @Query("delete from DailyTask task where task.report.id = :reportId")
  int deleteByReportId(@Param("reportId") Long reportId);
}
