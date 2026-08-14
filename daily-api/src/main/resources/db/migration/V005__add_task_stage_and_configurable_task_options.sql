alter table daily_tasks add column work_stage varchar(100);

alter table daily_tasks drop constraint ck_daily_tasks_current_status;
update daily_tasks
set current_status = case current_status
  when 'progressing' then 'in-progress'
  when 'waiting-feedback' then 'in-progress'
  when 'at-risk' then 'blocked'
  else current_status
end;
alter table daily_tasks add constraint ck_daily_tasks_current_status
  check (current_status in ('started', 'in-progress', 'completed', 'blocked', 'paused'));

update business_dictionaries set active = false where category = 'work_type';
insert into business_dictionaries(category, code, label, sort_order, active) values
  ('work_type', 'project-support', '行业/项目支撑', 10, true),
  ('work_type', 'special-work', '专项工作', 20, true),
  ('work_stage', 'requirements-analysis', '需求调研与分析', 10, true),
  ('work_stage', 'solution-design', '方案编写/设计', 20, true),
  ('work_stage', 'bid-quotation', '投标/报价支持', 30, true),
  ('work_stage', 'technical-presentation', '技术交流/演示汇报', 40, true),
  ('work_stage', 'implementation', '开发/配置/实施', 50, true),
  ('work_stage', 'testing-deployment', '测试/上线部署', 60, true),
  ('work_stage', 'training-acceptance', '培训/验收交付', 70, true),
  ('work_stage', 'operations-support', '运维保障', 80, true),
  ('work_stage', 'incident-handling', '故障/问题处理', 90, true),
  ('work_stage', 'optimization-upgrade', '优化升级', 100, true),
  ('work_stage', 'customer-support', '客户持续支撑', 110, true),
  ('participation_role', 'owner', '主责', 10, true),
  ('participation_role', 'collaborator', '协同', 20, true),
  ('participation_role', 'temporary-support', '临时支撑', 30, true),
  ('current_status', 'started', '已启动', 10, true),
  ('current_status', 'in-progress', '进行中', 20, true),
  ('current_status', 'completed', '已完成', 30, true),
  ('current_status', 'blocked', '遇到阻碍', 40, true),
  ('current_status', 'paused', '暂停/搁置', 50, true);
