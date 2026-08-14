-- 把 model_api_key_reference 重命名为 model_api_key：旧字段名暗示存的是环境变量名，
-- 但运行时并未解析；现在改成直接存 API key，留空则回落到 LLM_API_KEY 环境变量。
alter table analysis_configurations rename column model_api_key_reference to model_api_key;
alter table analysis_configurations alter column model_api_key drop not null;
alter table analysis_configurations alter column model_api_key drop default;

-- SMTP 发件箱全量配置：host / port / username / password / from。
-- 任一字段为空就回落到 spring.mail.* / daily.smtp.from 对应的环境变量。
alter table analysis_configurations add column smtp_host varchar(255);
alter table analysis_configurations add column smtp_port int;
alter table analysis_configurations add column smtp_username varchar(255);
alter table analysis_configurations add column smtp_password varchar(500);
alter table analysis_configurations add column smtp_from varchar(255);