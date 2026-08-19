package com.company.daily.email;

import java.util.List;

public record SmtpTestEmailRequest(List<String> recipients, List<String> ccRecipients) {}
