package com.company.daily.email;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/configuration/email")
public class SmtpTestEmailController {
  private final SmtpTestEmailService service;

  public SmtpTestEmailController(SmtpTestEmailService service) {
    this.service = service;
  }

  @PostMapping("/test")
  public SmtpTestEmailResponse test() {
    return service.send();
  }
}
