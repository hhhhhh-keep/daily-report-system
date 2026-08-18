package com.company.daily.email;

import java.util.List;

public record EmailMessage(
    List<String> recipients,
    List<String> ccRecipients,
    String subject,
    String html,
    byte[] attachment,
    String attachmentFileName,
    String attachmentMimeType) {}
