package com.company.daily.workday;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.stereotype.Service;

@Service
public class OfficialWorkdayCalendarNoticeService {
  private static final Pattern NUMERIC_ENTITY = Pattern.compile("&#(?:x([0-9a-fA-F]+)|(\\d+));?");
  private final HttpClient httpClient;
  private final OfficialWorkdayCalendarNoticeParser parser = new OfficialWorkdayCalendarNoticeParser();

  public OfficialWorkdayCalendarNoticeService() {
    this(HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10))
        .followRedirects(HttpClient.Redirect.NORMAL).build());
  }

  OfficialWorkdayCalendarNoticeService(HttpClient httpClient) {
    this.httpClient = httpClient;
  }

  public OfficialWorkdayCalendarPreviewResponse preview(
      OfficialWorkdayCalendarPreviewRequest request) {
    URI uri = officialUri(request.noticeUrl());
    try {
      HttpResponse<String> response = httpClient.send(HttpRequest.newBuilder(uri)
          .timeout(Duration.ofSeconds(15)).header("User-Agent", "DailyReportCalendar/1.0")
          .GET().build(), HttpResponse.BodyHandlers.ofString());
      officialUri(response.uri().toString());
      if (response.statusCode() < 200 || response.statusCode() >= 300) {
        throw new IllegalArgumentException("官方公告链接访问失败，HTTP " + response.statusCode());
      }
      return new OfficialWorkdayCalendarPreviewResponse(request.year(), response.uri().toString(),
          parser.parse(request.year(), textFromHtml(response.body())));
    } catch (InterruptedException exception) {
      Thread.currentThread().interrupt();
      throw new IllegalArgumentException("获取官方公告被中断");
    } catch (IllegalArgumentException exception) {
      throw exception;
    } catch (Exception exception) {
      throw new IllegalArgumentException("获取或解析官方公告失败", exception);
    }
  }

  private URI officialUri(String value) {
    URI uri;
    try {
      uri = URI.create(value.trim());
    } catch (IllegalArgumentException exception) {
      throw new IllegalArgumentException("请输入有效的官方公告链接", exception);
    }
    String host = uri.getHost();
    if (!"https".equalsIgnoreCase(uri.getScheme()) || host == null
        || !(host.equalsIgnoreCase("gov.cn") || host.toLowerCase(Locale.ROOT).endsWith(".gov.cn"))) {
      throw new IllegalArgumentException("仅支持 https://*.gov.cn 的官方公告链接");
    }
    return uri;
  }

  private String textFromHtml(String value) {
    String plain = value.replaceAll("(?is)<(script|style)[^>]*>.*?</\\1>", " ")
        .replaceAll("(?is)</(p|div|li|h[1-6])\\s*>|<br\\s*/?>", "\n")
        .replaceAll("(?is)<[^>]+>", " ").replace("&nbsp;", " ")
        .replaceAll("[\\t\\x0B\\f ]+", " ").replaceAll(" *\\r?\\n *", "\n");
    Matcher entities = NUMERIC_ENTITY.matcher(plain);
    StringBuffer decoded = new StringBuffer();
    while (entities.find()) {
      int codePoint = Integer.parseInt(entities.group(1) == null ? entities.group(2) : entities.group(1),
          entities.group(1) == null ? 10 : 16);
      entities.appendReplacement(decoded, Matcher.quoteReplacement(new String(Character.toChars(codePoint))));
    }
    entities.appendTail(decoded);
    return decoded.toString().trim();
  }
}
