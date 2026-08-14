package com.company.daily.email;

public interface EmailGateway {
  void send(EmailMessage message, SmtpSettings settings);
}
