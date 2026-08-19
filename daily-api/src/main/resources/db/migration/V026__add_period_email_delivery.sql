alter table analysis_period_configurations
  add column email_enabled boolean not null default false,
  add column email_recipients text not null default '',
  add column email_cc_recipients text not null default '',
  add column email_subject_template varchar(500) not null default '{{period}}分析报告｜{{date}}',
  add column report_title_template varchar(500) not null default '{{period}}工作分析报告（截至{{date}}）';

update analysis_period_configurations
set email_enabled = configuration.email_enabled,
    email_recipients = coalesce(configuration.recipients, ''),
    email_cc_recipients = coalesce(configuration.cc_recipients, ''),
    email_subject_template = coalesce(configuration.email_subject_template, '{{period}}分析报告｜{{date}}')
from analysis_configurations configuration
where analysis_period = 'DAILY';
