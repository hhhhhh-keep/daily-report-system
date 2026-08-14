package com.company.daily.admin.service;

public class InvalidCredentialsException extends IllegalArgumentException {
  public InvalidCredentialsException() {
    super("用户名或密码错误");
  }
}
