alter table analysis_period_configurations
  add column email_enabled boolean not null default false,
  add column email_recipients text not null default '',
  add column email_cc_recipients text not null default '',
  add column email_subject_template varchar(500) not null default '{{period}}分析报告｜{{date}}',
  add column report_title_template varchar(500) not null default '{{period}}工作分析报告（截至{{date}}）';

update analysis_period_configurations
set email_enabled = configuration.email_enabled,
    email_recipients = configuration.recipients,
    email_cc_recipients = configuration.cc_recipients,
    email_subject_template = configuration.email_subject_template
from analysis_configurations configuration
where analysis_period = 'DAILY';
