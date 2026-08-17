package com.company.daily.common.api;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;

import com.company.daily.email.EmailDeliveryException;
import jakarta.servlet.http.HttpServletRequest;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;

class ApiExceptionHandlerTest {
  @Test
  void returnsSafeActionableErrorWhenSmtpDeliveryFails() {
    var response = new ApiExceptionHandler().emailDelivery(
        new EmailDeliveryException("SMTP 邮件发送失败", new RuntimeException("provider detail")),
        mock(HttpServletRequest.class));

    assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_GATEWAY);
    assertThat(response.getBody()).isNotNull();
    assertThat(response.getBody().code()).isEqualTo("EMAIL_DELIVERY_FAILED");
    assertThat(response.getBody().message())
        .isEqualTo("SMTP 服务器未接受测试邮件，请检查端口、授权码及发件箱反垃圾策略");
  }
}
