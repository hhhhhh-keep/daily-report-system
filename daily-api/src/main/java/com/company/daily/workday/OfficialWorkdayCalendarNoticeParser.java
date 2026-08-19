package com.company.daily.workday;

import java.time.DateTimeException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.util.StringUtils;

final class OfficialWorkdayCalendarNoticeParser {
  private static final Pattern HOLIDAY_SECTION = Pattern.compile(
      "(?s)[一二三四五六七八九十]+、\\s*([^：:]{1,20})[：:]\\s*(.*?)(?=(?:[一二三四五六七八九十]+、\\s*[^：:]{1,20}[：:])|\\z)");
  private static final Pattern HOLIDAY_CLAUSE = Pattern.compile("(?s).{0,200}?放假(?:调休)?");
  private static final Pattern WORKDAY_SENTENCE = Pattern.compile("[^。！？\\r\\n]*上班[^。！？\\r\\n]*[。！？]?");
  private static final Pattern DATE = Pattern.compile("(?:(\\d{1,2})月)?(\\d{1,2})日");

  List<WorkdayCalendarImportItem> parse(int year, String notice) {
    if (!StringUtils.hasText(notice) || !notice.contains(year + "年")
        || !notice.contains("部分节假日安排")) {
      throw new IllegalArgumentException("链接内容不是指定年度的节假日官方公告");
    }
    Map<LocalDate, WorkdayCalendarImportItem> entries = new LinkedHashMap<>();
    Matcher sections = HOLIDAY_SECTION.matcher(notice);
    while (sections.find()) {
      String holiday = sections.group(1).trim();
      String content = sections.group(2);
      Matcher holidays = HOLIDAY_CLAUSE.matcher(content);
      while (holidays.find()) {
        addHolidayDates(entries, year, holiday, holidays.group());
      }
      Matcher workdays = WORKDAY_SENTENCE.matcher(content);
      while (workdays.find()) {
        for (LocalDate date : dates(year, workdays.group())) {
          entries.put(date, new WorkdayCalendarImportItem(
              date, true, WorkdaySource.MAKE_UP_WORKDAY, holiday + "补班"));
        }
      }
    }
    if (entries.isEmpty()) {
      throw new IllegalArgumentException("未从公告中识别到节假日或补班日期");
    }
    return entries.values().stream()
        .sorted(Comparator.comparing(WorkdayCalendarImportItem::date))
        .toList();
  }

  private void addHolidayDates(Map<LocalDate, WorkdayCalendarImportItem> entries,
      int year, String holiday, String sentence) {
    List<LocalDate> dates = dates(year, sentence);
    if (dates.isEmpty()) {
      return;
    }
    if (dates.size() >= 2 && sentence.contains("至")) {
      LocalDate start = dates.getFirst();
      LocalDate end = dates.get(1);
      if (end.isBefore(start) || end.isAfter(start.plusDays(31))) {
        throw new IllegalArgumentException("公告中的节假日日期范围无效");
      }
      for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
        entries.put(date, new WorkdayCalendarImportItem(
            date, false, WorkdaySource.LEGAL_HOLIDAY, holiday));
      }
      return;
    }
    for (LocalDate date : dates) {
      entries.put(date, new WorkdayCalendarImportItem(
          date, false, WorkdaySource.LEGAL_HOLIDAY, holiday));
    }
  }

  private List<LocalDate> dates(int year, String text) {
    List<LocalDate> dates = new ArrayList<>();
    Matcher matcher = DATE.matcher(text);
    Integer month = null;
    while (matcher.find()) {
      if (matcher.group(1) != null) {
        month = Integer.valueOf(matcher.group(1));
      }
      if (month == null) {
        throw new IllegalArgumentException("公告日期缺少月份");
      }
      try {
        dates.add(LocalDate.of(year, month, Integer.parseInt(matcher.group(2))));
      } catch (DateTimeException exception) {
        throw new IllegalArgumentException("公告日期无效", exception);
      }
    }
    return dates;
  }
}
