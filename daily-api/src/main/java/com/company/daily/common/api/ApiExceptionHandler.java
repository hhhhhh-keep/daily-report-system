package com.company.daily.common.api;

import com.company.daily.admin.service.InvalidCredentialsException;
import com.company.daily.email.EmailDeliveryException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.ConstraintViolationException;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ApiExceptionHandler {
  private static final Logger LOG = LoggerFactory.getLogger(ApiExceptionHandler.class);

  @ExceptionHandler(InvalidCredentialsException.class)
  ResponseEntity<ApiError> invalidCredentials(
      InvalidCredentialsException exception, HttpServletRequest request) {
    return response(HttpStatus.UNAUTHORIZED, "INVALID_CREDENTIALS", exception.getMessage(), Map.of(), request);
  }

  @ExceptionHandler(MethodArgumentNotValidException.class)
  ResponseEntity<ApiError> validation(MethodArgumentNotValidException exception, HttpServletRequest request) {
    Map<String, String> fields = new LinkedHashMap<>();
    exception.getBindingResult().getFieldErrors()
        .forEach(error -> fields.putIfAbsent(error.getField(), error.getDefaultMessage()));
    logValidationFailure(request, "VALIDATION_ERROR", fields);
    return response(HttpStatus.BAD_REQUEST, "VALIDATION_ERROR", "请求参数无效", fields, request);
  }

  @ExceptionHandler(ConstraintViolationException.class)
  ResponseEntity<ApiError> constraint(ConstraintViolationException exception, HttpServletRequest request) {
    Map<String, String> fields = new LinkedHashMap<>();
    exception.getConstraintViolations().forEach(
        violation -> fields.put(violation.getPropertyPath().toString(), violation.getMessage()));
    logValidationFailure(request, "VALIDATION_ERROR", fields);
    return response(HttpStatus.BAD_REQUEST, "VALIDATION_ERROR", "请求参数无效", fields, request);
  }

  @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
  ResponseEntity<ApiError> methodNotAllowed(
      HttpRequestMethodNotSupportedException exception, HttpServletRequest request) {
    return response(
        HttpStatus.METHOD_NOT_ALLOWED, "METHOD_NOT_ALLOWED", "请求方法不受支持", Map.of(), request);
  }

  @ExceptionHandler(IllegalArgumentException.class)
  ResponseEntity<ApiError> illegalArgument(IllegalArgumentException exception, HttpServletRequest request) {
    logInvalidRequest(request);
    return response(HttpStatus.BAD_REQUEST, "INVALID_REQUEST", exception.getMessage(), Map.of(), request);
  }

  @ExceptionHandler(EmailDeliveryException.class)
  ResponseEntity<ApiError> emailDelivery(
      EmailDeliveryException exception, HttpServletRequest request) {
    return response(
        HttpStatus.BAD_GATEWAY,
        "EMAIL_DELIVERY_FAILED",
        "SMTP 服务器未接受测试邮件，请检查端口、授权码及发件箱反垃圾策略",
        Map.of(),
        request);
  }

  @ExceptionHandler(ResourceNotFoundException.class)
  ResponseEntity<ApiError> notFound(ResourceNotFoundException exception, HttpServletRequest request) {
    return response(HttpStatus.NOT_FOUND, "NOT_FOUND", exception.getMessage(), Map.of(), request);
  }

  private ResponseEntity<ApiError> response(
      HttpStatus status,
      String code,
      String message,
      Map<String, String> fields,
      HttpServletRequest request) {
    String correlationId = correlationId(request);
    return ResponseEntity.status(status)
        .body(new ApiError(code, message, fields, correlationId, Instant.now()));
  }

  private static void logValidationFailure(
      HttpServletRequest request, String code, Map<String, String> fields) {
    LOG.warn(
        "Request validation failed method={} path={} correlationId={} code={} fields={}",
        request.getMethod(),
        request.getRequestURI(),
        correlationId(request),
        code,
        fields);
  }

  private static void logInvalidRequest(HttpServletRequest request) {
    LOG.warn(
        "Invalid request method={} path={} correlationId={} code=INVALID_REQUEST",
        request.getMethod(),
        request.getRequestURI(),
        correlationId(request));
  }

  private static String correlationId(HttpServletRequest request) {
    Object attribute = request.getAttribute(CorrelationIdFilter.ATTRIBUTE);
    return attribute == null ? "unavailable" : attribute.toString();
  }
}
