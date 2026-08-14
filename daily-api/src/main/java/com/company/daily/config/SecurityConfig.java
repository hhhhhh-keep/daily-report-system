package com.company.daily.config;

import com.company.daily.admin.security.AdminSessionAuthenticationFilter;
import org.springframework.http.HttpMethod;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AnonymousAuthenticationFilter;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
  @Bean
  SecurityFilterChain securityFilterChain(
      HttpSecurity http, AdminSessionAuthenticationFilter adminSessionFilter) throws Exception {
    return http
        .csrf(csrf -> csrf.disable())
        .requestCache(cache -> cache.disable())
        .formLogin(login -> login.disable())
        .httpBasic(basic -> basic.disable())
        .exceptionHandling(exceptions -> exceptions.authenticationEntryPoint(
            (request, response, exception) -> response.sendError(401)))
        .sessionManagement(session -> session
            .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            .sessionFixation(fixation -> fixation.none()))
        .addFilterBefore(adminSessionFilter, AnonymousAuthenticationFilter.class)
        .authorizeHttpRequests(authorize -> authorize
            .requestMatchers("/api/report/**", "/api/reports/**", "/actuator/health", "/error")
            .permitAll()
            .requestMatchers(HttpMethod.POST, "/api/admin/session")
            .permitAll()
            .requestMatchers("/api/admin/**")
            .hasRole("ADMIN")
            .anyRequest().authenticated())
        .build();
  }

  @Bean
  PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

  @Bean
  UserDetailsService userDetailsService() {
    return username -> {
      throw new UsernameNotFoundException(username);
    };
  }
}
