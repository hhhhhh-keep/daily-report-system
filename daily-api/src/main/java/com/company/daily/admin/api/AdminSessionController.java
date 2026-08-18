package com.company.daily.admin.api;

import com.company.daily.admin.api.dto.AdminLoginRequest;
import com.company.daily.admin.api.dto.AdminPasswordRequest;
import com.company.daily.admin.api.dto.AdminSessionResponse;
import com.company.daily.admin.security.AdminSessionAuthenticationFilter;
import com.company.daily.admin.service.AdminIdentity;
import com.company.daily.admin.service.AdminSessionService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import java.security.Principal;
import java.time.Duration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin")
public class AdminSessionController {
  private static final Duration REMEMBER_ME_TTL = Duration.ofDays(30);
  private final AdminSessionService sessionService;

  public AdminSessionController(AdminSessionService sessionService) {
    this.sessionService = sessionService;
  }

  @PostMapping("/session")
  public AdminSessionResponse login(
      @Valid @RequestBody AdminLoginRequest request, HttpServletRequest servletRequest,
      HttpServletResponse servletResponse) {
    AdminIdentity identity = sessionService.authenticate(request.username(), request.password());
    HttpSession previousSession = servletRequest.getSession(false);
    if (previousSession != null) {
      previousSession.invalidate();
    }
    HttpSession session = servletRequest.getSession(true);
    session.setAttribute(AdminSessionAuthenticationFilter.SESSION_ATTRIBUTE, identity.username());
    if (request.rememberMe()) {
      session.setMaxInactiveInterval((int) REMEMBER_ME_TTL.toSeconds());
      String cookieName = servletRequest.getServletContext().getSessionCookieConfig().getName();
      servletResponse.addHeader("Set-Cookie", ResponseCookie
          .from(cookieName == null || cookieName.isBlank() ? "JSESSIONID" : cookieName, session.getId())
          .httpOnly(true)
          .secure(servletRequest.isSecure())
          .sameSite("Strict")
          .path(servletRequest.getContextPath().isBlank() ? "/" : servletRequest.getContextPath())
          .maxAge(REMEMBER_ME_TTL)
          .build()
          .toString());
    }
    return new AdminSessionResponse(identity.username(), true);
  }

  @GetMapping("/session")
  public AdminSessionResponse current(Principal principal) {
    return new AdminSessionResponse(principal.getName(), true);
  }

  @DeleteMapping("/session")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void logout(HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    if (session != null) {
      session.invalidate();
    }
  }

  @PutMapping("/password")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void changePassword(
      Principal principal, @Valid @RequestBody AdminPasswordRequest request) {
    sessionService.changePassword(
        principal.getName(), request.currentPassword(), request.newPassword());
  }
}
