package com.company.daily.common.api;

import java.util.List;

/**
 * 分页响应包装。Spring Data 的 {@code Page<T>} 在 JSON 上既有 {@code content} 又有
 * {@code pageable / sort}，体积大且对前端不友好；这里给前端一个轻量契约：
 *
 * <pre>
 * { items: T[], totalItems: number, page: number, pageSize: number, totalPages: number }
 * </pre>
 *
 * <p>{@code page} 是 0-based；{@code pageSize} 来自请求，{@code totalItems} 来自数据库
 * 的 COUNT 查询（独立窗口，不混入 {@code items}）。
 */
public record PageResponse<T>(
    List<T> items,
    long totalItems,
    int page,
    int pageSize,
    int totalPages) {

  public static <T> PageResponse<T> of(List<T> items, long totalItems, int page, int pageSize) {
    int totalPages = pageSize <= 0
        ? 0
        : (int) Math.max(0L, (totalItems + pageSize - 1) / pageSize);
    return new PageResponse<>(items, totalItems, page, pageSize, totalPages);
  }
}
