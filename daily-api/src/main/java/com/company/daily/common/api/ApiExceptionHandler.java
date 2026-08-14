package com.company.daily.common.api;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.ConstraintViolationException;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import com.company.daily.admin.service.InvalidCredentialsException;

@RestControllerAdvice
public class ApiExceptionHandler {
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
    return response(HttpStatus.BAD_REQUEST, "VALIDATION_ERROR", "请求参数无效", fields, request);
  }

  @ExceptionHandler(ConstraintViolationException.class)
  ResponseEntity<ApiError> constraint(ConstraintViolationException exception, HttpServletRequest request) {
    Map<String, String> fields = new LinkedHashMap<>();
    exception.getConstraintViolations().forEach(
        violation -> fields.put(violation.getPropertyPath().toString(), violation.getMessage()));
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
    return response(HttpStatus.BAD_REQUEST, "INVALID_REQUEST", exception.getMessage(), Map.of(), request);
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
    Object attribute = request.getAttribute(CorrelationIdFilter.ATTRIBUTE);
    String correlationId = attribute == null ? "unavailable" : attribute.toString();
    return ResponseEntity.status(status)
        .body(new ApiError(code, message, fields, correlationId, Instant.now()));
  }
}
