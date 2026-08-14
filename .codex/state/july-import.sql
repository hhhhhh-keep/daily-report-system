begin;
delete from project_state_events;
delete from project_derived_states;
delete from report_statistics_snapshots;
delete from daily_reports;
delete from employees;
delete from projects where formal=true;
insert into projects(name,code,formal,status,active,owner_name,priority) values ('省高院执行局智能化项目','JUL-TEST-01',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('公安数据湖项目','JUL-TEST-02',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('机场公安OA项目','JUL-TEST-03',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('省疾控AI项目','JUL-TEST-04',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('军总运维项目','JUL-TEST-05',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('省医保五期项目','JUL-TEST-06',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('省消防救援总队智能指挥系统项目','JUL-TEST-07',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('商务厅网络安全设备项目','JUL-TEST-08',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('江苏中烟专有云平台三期项目','JUL-TEST-09',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('江苏省高校招生就业指导服务中心项目','JUL-TEST-10',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('医疗行业数据要素项目','JUL-TEST-11',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('麒麟平台项目','JUL-TEST-12',true,'active',true,'July Import','medium');
insert into projects(name,code,formal,status,active,owner_name,priority) values ('待确认项目归属','JUL-UNMATCHED',true,'active',true,'July Import','medium');
insert into employees(name,team_name,position_type,active) values ('丁德胜','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('丁金龙','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('付园园','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('倪静','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘延明','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘志栋','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘斌','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘月','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘涛','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘炜','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘玲','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('刘立军','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('刘茜','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('卜文豪','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('卞月林','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('叶小舟','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('吴承云','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('吴浩','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('吴海宁','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('吴鹏','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('周俊凤','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('周菁','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('周超','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('唐展','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('孙晓星','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('孙璐','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('崔悦','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('常允城','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('应万峰','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('张加勉','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('张正一','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('张沈玲','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('张涛','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('张贵民','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('张雪雅','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('徐剑宏','战客驻场','自有',true);
insert into employees(name,team_name,position_type,active) values ('徐博文','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('戴云平','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('施翔','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('曹雯莉','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('李孝雨','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('李岩','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('李悦','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('李晶','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('李鑫','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('李锡明','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('杨一','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('杨杨','战客驻场','自有',true);
insert into employees(name,team_name,position_type,active) values ('杨煜倩','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('杨瑞','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('殷文杰','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('毕爱梓','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('毕雪','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('江爱','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('江磊','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('汤梦寒','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('沈云','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('沙政兵','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('洪玉','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('王帆','战客驻场','自有',true);
insert into employees(name,team_name,position_type,active) values ('王思乐','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('王改霞','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('王海娜','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('王睿栋','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('王达伟','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('王雪峰','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('田金川','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('申士','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('祝力','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('窦文阳','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('肖明','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('胡宇','行业解决方案','自有',true);
insert into employees(name,team_name,position_type,active) values ('胡蕾蕾','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('苗数','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('茆胜华','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('薛新成','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('薛鸿毅','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('袁浩','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('许刘晓','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('赵伟凯','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('赵春燕','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('钱晨','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('钱程','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('陈怡','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('陈恺','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('陈秀华','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('陈笑','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('陈耀龙','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('陈苏','战客驻场','一体化',true);
insert into employees(name,team_name,position_type,active) values ('陈雪松','售中交付','一体化',true);
insert into employees(name,team_name,position_type,active) values ('韩威','售中交付','自有',true);
insert into employees(name,team_name,position_type,active) values ('高翔','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('麻鑫宁','行业解决方案','一体化',true);
insert into employees(name,team_name,position_type,active) values ('黄思华','战客驻场','自有',true);
insert into employees(name,team_name,position_type,active) values ('黄静茹','售中交付','一体化',true);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1 南京江北新区生物医药谷数据要素空间项目需求交流
2 江苏省医保局客户交流江苏移动云网算力与行业解决汇报方案编制','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','2026年上半年医疗行业大单丢标与份额下降原因分析','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：信创集采项目案例更行','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：信创专项培训数据库材料支撑
下午：信创优秀案例后推广材料填报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：制造业生态梳理，完成10条
下午：修订细分领域场景方案并提交；参加工信厅组织的卓越级领航级智能工厂的宣贯会议。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、1-6月行一二工作量需求提出人复核；2、更新行一二工作日程管理在线表，发布通知；下午：1、售中软集周报内容规范性审核，关注项目验收时间；2、编写优化“一点调度”系统自有产品协同交付流程需求文档','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源敲门行动项目组例会；省林业局政务信息系统专项清理工作支撑；省林业局目录信息核查及下线申请
下午：档案馆互联网区数据库资源核查；一本账系统问题核查处理；省信访局数据申请记录迁移清单更新；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','商贸行业素材整理交接','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','调休','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：
江苏省数据集团有限公司数据流通交易平台项目投标文件打印、扫描、封装
下午：
参加江苏省数据集团有限公司数据流通交易平台项目现场开标会、述标会','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、工业行业生态拓展：完成苏州同凯、青岛三态比特（轻琏）2家交流；
下午：1、工业行业场景方案编写，完成服饰制造产品数字化设计、服饰制造产品精准营销2个场景方案。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1、上半年三大行业拓展情况分析；
2、中烟培训材料根据客户方反馈继续优化。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、记录机关党建云平台用户使用问题反馈并修改
2、修改用户手册格式和内容并打印
3、对接机关党建云党费缴纳背景图设计的事宜','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','汇报每日全省签约情况','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.参加每日归集例会
2.梳理新老公共数据平台数据资源对应关系
3.梳理淮安的20个垂管对接需求，并通过工单提供
下午：
1.跟进并更新13个设区市水气欠费数据归集情况
2.核实部门省级政务信息系统复核工作进度
3.讨论市监企业年报申报信息数据重新同步方案','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-TEST-11'),'project-support','customer-support','owner','上午：医疗行业数据要素应用场景及生态储备资料整理；
下午：光华杯决赛材料定稿；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：医疗行业上半年签约情况分析梳理；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','JCB-2026-070项目投标支撑
JCB-2026-071项目投标支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、江苏脑机接口研究院实验室综合智控平台项目：与战客及厂家开展述标材料检查会议，讨论和修改述标材料。
2、国家（江苏）紧急医学救援队无人机及管理系统购置项目：修改招标技术参数，完善技术参数，完成终稿
3、南京医科大学附属口腔医院数据中心交换机项目，完成最终响应文件，盖章封标。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：麒麟平台过期基础方案处理，AI场景方案反馈
下午：智慧医院高价值雷达解决方案编制
江苏省茅台酒业前向合同处理','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','苏政源数据治理项目支撑。
上午：1、梳理南京海关及省自然资源厅17类数据资源，开展治理任务；2、完成国网电力5个大表的治理工作，同时梳理并统计已完成治理任务；3、统一数据运营对接工作跟进；
下午：1、数据质量模块原型评审及优化；2、苏晓慧-一本账-数据治理对接接口规范解读和指导，处理数据治理对接工作；3、排查司法厅律师管理信息不对称问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：政府网站与新媒体传播影响力平台解决方案修改、配套材料编制；党政生态可用性定期维护在线文档维护周期统筹讨论、政务等子领域生态维护；麒麟平台方案超期资源更新计划、麒麟平台新质生产力内容反馈党政内容统筹填写
下午：政府网站与新媒体传播影响力平台解决方案配套材料编制；党政生态可用性定期维护在线文档政务等子领域生态维护','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：FY国产化改造项目对接生态厂家，技术方案及报价跟进整理
下午：GT信息化系统建设供应商推荐表素材收集及编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：对接连云港、苏州等地市客户经理，交流推广纪委AI辅助审理解决方案；
下午：法院云迁移软著材料补充编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、林海集团智能排产、辅助设计、视觉识别检测、知识库需求对接，同步推荐自有工互平台能力，近期交流。
2、江苏兴达钢帘线“工艺智能体+定制知识库+工业大模型”需求对接，协同分别对接朗坤、卡奥斯、南大五维，拉通近期交流。
3、大生集团资源协调。
下午：
1、盐城国投制造、环保、能源等行业需求对接，沟通汇报材料编制。
2、江苏中烟汇报材料素材梳理，根据最新要求对接海澜之家、苏州中试基地项目素材。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、船舶专利素材收集。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='周俊凤'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周俊凤') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1.上午检查组件超市门户菜单调整情况，处理处室领导反馈的问题建议，根据监理意见修改组件超市概设部分内容
2.下午继续完善修改组件超市祥设和数据库设计部分内容','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-TEST-06'),'project-support','bid-quotation','owner','全天：江苏省卫健委云影像平台扩容项目，项目效益预测算。
江苏省教育科学研究院宽带网络接入及无线网络一体化服务项目，编写项目投标文件。
下午：江苏省医保五期项目，沟通后向采购流程。
省人医雨花院区至广州路院区互联光缆服务项目，转签合同用印。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-TEST-07'),'project-support','solution-design','owner','省消防救援总队智能指挥系统项目支撑：针对多系统、多厂商建设的一体管控问题，完成基础平台产品融合建设方案评估、总体架构设计','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','应急区域安全生产风险管控解决方案编制；党政生态可用性定期维护','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：无锡惠山交流材料整合编写
下午：东航语音标注进展同步','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：信创培训材料编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、省人大信创改造升级项目AI复刻汇报交流；
2、连云港市新一代电子政务外网5G移动平面的售前支撑调度；
3、徐州市政府人工智能+路演的售前支撑调度；
4、盐城市XC终端基础软硬件采购与集成服务的售前支撑调度；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1、CCIA资质换证材料对接梳理。
2、对新质生产力相关资源，以及麒麟平台内超期未更新资源进行核实与更新
3、麒麟平台行业解决方案专题建设汇报材料','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 专项清理：协助省供销社进行低效系统情况说明。
3. 组件超市：第五批组件回收最终整理确认，并发送给中台人员处理。
下午：
1. 专项清理：(1) 协助省检察院拆分数据目录所属系统 (2) 联络省委组织部更新数据并核对 (3) 协助省侨联上传情况说明文件
2. 数据迁移：整理数据申请记录迁移清单（省药监目录）
3. 敲门行动：系统核查清单整理与遗留问题处理（市监局、税务局、药监局）','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、参加数据归集周例会，总结上周工作进展，明确本周重点工作内容和任务分工；
2、参加数据申请记录迁移相关事项培训，沟通老平台目录申请共享记录的迁移方案及具体实施操作；
3、完成国动办和省文旅厅的数据申请记录迁移清单整理工作。
下午：
1、统计所有部门清单质检结果，全面梳理现有的系统问题、数据目录问题、云资源关联问题等；
2、对部分厅局存在的目录和资源问题启动整改工作；
3、整理各部门问题处理进度台账，准备向领导汇报相关情况。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、省人医临床研究患者精细化数据采集系统项目汇总每周工作周报，沟通项目实时进度；
2、残疾人康复中心配套设施采购项目，汇总每周工作周报，准备本周二项目启动会汇报材料；
下午：
1、省统筹平台（一期）项目卫生资源和应急值守系统用户使用问题答疑解决；
2、省统筹平台（二期）项目症候群系统和舆情监测系统功能评审并验证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：制作在线表格统计收集行业支撑一部26年8月份资金计划、修改通用应急保障方案Word文档                                         下午：打印特快寄件登记表、处理OA账号的报账待办、去通信行业协会拿信息通讯网络甲级资质证书','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：宿迁港中心港区陆运河作业区陆集中心港一期工程智慧化项目支撑；腾龙大道AI+建设管理场景项目支撑；
下午：人工智能学会科技兴安应用解决方案赛道申报书编写','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','人工智能学会人工智能科技成果奖申报工作','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','全天：25-091，26-009后向采购项目审批会签支撑；2026-016采购流程支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、确定工信厅平台对接事宜；
2、联系算力平台，处理平台跳转问题；
3、配合产品中心、战客中心，确认工信厅算力业务合作事宜；
4、对接云智部，确认部门算力对接需求。
下午：
1、联系各地市，对接平台推广事宜；
2、搜集麒麟商场事宜场景比对。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：徐州NB-HYB-2026-001项目合同流程支撑
下午：淮安JCB-2026-061项目投标支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1、商贸政策及能力图谱梳理；2、商业物联网平台相关解决方案内容梳理；3、科拓停车管理系统相关方案梳理学习','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1）和海致沟通情指行交流时间；
2）厅机关平时考核(二期)应用系统审核修改；
下午：1）HJZD执法调度平台解决方案的制作和修改。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1，药监局信息系统清理工作，协调客户签字盖章等事；2，和战客对齐东航CVR项目上周进展，和东航客户沟通项目需求确认事项；
下午：和讯飞，客户沟通数据标注进展。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.行三人员转入战客驻场团队规范流程研究分析；战客驻场代招问题分析；
2.FDE团队与项目清单更新，反馈政企部；
3.PMO管理制度推进；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.江苏中烟研发一体化平台建设项目:推进项目售前，围绕数字化研发设计章节，优化完善一体化平台建设技术方案。
2.处理以下项目的费用相关流程：江苏中烟2026-2028年总部信息化基础环境系统运维服务项目(标段一服务器、网络、机房环境等设备)代理服务费支付材料整理及流程申请；江苏国信数智服务有限公司安全访问接入运维服务项目中标服务费提前支付材料整理及流程申请；江苏苏美达集团有限公司虚拟化存储更替采购项目报名费核销材料整理及流程申请。
下午：
1.江苏中烟工业有限责任公司门户及办公系统升级改造建设项目：结合对门户、办公系统及邮箱系统建设需求的理解，重点编写门户及办公系统升级改造技术方案和共享服务中心建设技术方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1、上午：CCIA资质换证材料对接梳理。
2、下午：与市场部开会一线直通车规范流程梳理
3、下午：麒麟平台行业解决方案专题建设汇报材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：JCB-2026-062项目投标支撑','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源项目。整理异议处理初验功能核查表，检查上周未通过功能的修改情况；与统一监测平台沟通首页下钻的指标内容，确定需要提供的数据；
下午：苏政源项目。总体组开会沟通苏政源标书的性能要求，按照要求评估异议处理和风险防控的性能指标说明，估算系统在要求下的最大并发量；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：常州妇幼高质量数据集后项方案协调
下午：1，苏州区域合理用药方案推荐
2，中能盛康区域健康信息平台建设采购项目（标包1），投标方案支撑：医疗部分补充','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1.参加归集日例会，了解并确认老平台目录申请共享记录的迁移方案及具体实施操作
2.配合苏政源迁移，整理商务厅、科学技术厅老平台的申请记录，并补充关键字段
3.整理科技厅合并目录之间的数据项对应关系
4.协助省外办在苏政源订阅数据资源，配置对应订阅库','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会布置接下来项目事项。
2.筹备项目启动会相关事项。
3.梳理现有SKILLS，并汇报给到战客中心。
4.请示客户演示安排，根据安排针对性准备。
5.明确新来人员现场分工，明确各自负责事项。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、上午对接GA客户，确认7月22日演示取消事宜；组织现场团队，明确近一周的重点工作；组织对缓存优化方案进行讨论；
2、下午协助沟通江苏中烟项目完善徐州卷烟厂模型；
3、下午配合初步检查公安HY项目GHGY改造的软件造价清单；
4、下午牵头检察院项目后向金鼎与聚微，提供互联网服务推动安全检测报价工作。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、下午编写部门领导两条查摆工作改进措施；
2、下午根据领导关于一点调度自有产品协同交付子流程修改建议，组织讨论形成“4+1”需求，安排完成功能初设，计划周四前完成。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.整理脚本任务导出数据，准备excel数据
2.和省委老干部局进行对接沟通，准备目录清单
下午：
1.撰写7月份数据治理运营月报
2.撰写7月13-7月17数据治理周报
3.和省红十字会进行对接，指导部门技术人员对数据库进行清洗','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：江苏中烟工业有限责任公司2026-2028年总部信息化基础环境系统运维服务项目，招标代理对接参数要求','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：数据要素大赛材料编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：徐州分公司某HZ小区智能化建设受托代销合作协议合同系统流程处理；2026年徐州市某医药产业园机房综合备电服务项目合同系统流程处理；徐州分公司战客某单位2026年徐州市某医药产业园机房综合备电服务项目合同系统流程处理　
下午：1、徐州分公司战客某单位运维研判系统ICT项目合同系统流程处理；2、融合创新行业麒麟平台过期方案梳理，智慧干休所方案内容整理','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：熟悉人大项目现场巡检流程，巡检新闻模块。医保反欺诈项目总集审核材料反馈，补充材料。
下午：支撑医保反欺诈项目提供线索。人大项目联系中江处理要闻模块新闻条目重复、缺失新闻等问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
沟通确认南京河西中央科创区室内AI场景项目初步需求，完成需求分析及调度适配支撑。
下午：跟踪苏州人社AI+项目工单评价问题，跟踪回溯分析，完成项目支撑进展闭环。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：
党政行业一点调度工单全量台账深度梳理优化更新。
下午：
班组日常公共事务支撑、党政行业公共事务支撑（7.20一点调度新增工单维护）。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','下午：支撑互联网智慧教学平台服务采购项目，对接地市交流项目需求。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：麒麟平台维护，处理功能缺失工单，查缺补漏，补充场景方案。
下午：厂家交流，对接青果软件，沟通实验室软件平台需求。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、与客户侧陈主任沟通对高质量考核新增导入下划线匹配、导入字数限制功能优化；2、与软测对接人沟通，对软件报告，对报告中的功能进行核实补充
下午：1、与办公室主任沟通对常州工勘院异常流程问题修复；2、对新能源地质队组织异常问题修复；3、对已办导出功能发错，对系统进行优化。4、修复大批量数据导出网络超时问题','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、与南京公司沟通，修改SM项目材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：跟集团客户确认云资源算力要求，并与战客中心确认，跟进战客报价进度；核实专家调度系统中上海青峰公司的UI支撑工作量，并提交审核；
下午：跟集团客户侧介绍综合办公系统主兼职功能的设计思路，针对客户提出的使用问题，跟厂家进行技术讨论，目前方案还未确定。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','智慧印章系统：跟进提交给DI部的事件单进展，与厂家实施人员介绍事件单背景，以及需要他们协助的工作内容，目前待DI部运维厂商实施NAS挂载。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1、制造业生态梳理，完成14条；
2、跟进麒麟商城对接中小企业公共服务平台进展，麒麟能力商城入口界面设计。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','机关工委项目培训材料沟通定稿','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','安排跟踪内部培训
工会事宜
协助人力资源部政绩观查改工作','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1、日常服务器巡检，一切正常；
2、处理信创区域测试环境无效端口封禁事宜；
下午：
1、处理常州账号问题；
2、参与AI大模型的会议；
3、处理客户公文交换的问题。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','政府网站与新媒体传播影响力平台解决方案审核；民政殡葬监管平台解决方案解耦上架；无锡市城市信息模型基础平台项目精品案例梳理上架','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','麒麟试点地市素材整合；麒麟平台党政行业内容梳理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1.国家税务总局江苏省税务局互联网线路及服务租赁项目整理商务、技术等材料，形成初稿移交客户审核。
2.江苏省大数据局双平台项目分析投标风险点，跟客户侧进行确认，已有初步结论。待跟客户经理确认。
3.知识产权领域开发主体申报项目待签合同，目前不清楚后续流程，跟客户经理讨论处理办法。
4.国家统计局江苏调查总队四农普项目，跟客户侧确认项目招标细节，给客户提供合理建议。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','互联网智慧教学平台服务采购项目售前支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、沛县东南片区某B地块通信基础建设项目现场支撑
2、弱势行业分析汇总','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、参加归集日例会，与苏政源新平台一起沟通确认老平台目录申请共享记录的迁移方案及具体实施操作；
2、梳理已归集部门统计局和省残联的目录和下线目录的情况；
下午：
1、梳理老平台上目录归属系统以及老平台上的系统与新平台上系统的对应关系；
2、参与会议确认不同场景下的目录申请共享记录的迁移方案，比如老-新平台目录发生拆分（一对多，多对一），老平台有新平台无等场景','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','人社厅数据体系规划设计项目：沟通规划设计进度，计划本周四到客户对体系规划的初步方案进行汇报','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','麒麟精品案例规划，根据市场部邮件，整理缺口精品案例情况，评估是否可以作为精品案例。结合既有计划，更新精品案例上架计划','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：
1、海事局无纸化办公及智能体项目，对接会议厂家、战客，沟通方案报价、集成部分内容变更等。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：
1、对接研二沟通关于商客标准产品清单。
2、与研发部、盐城公司对接转研发项目标书等，及评标相关资质处理等。
下午：
1、盐城转研发项目现场评标。
2、数据要素X与云智对接，沟通数据局指导优化等。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：跟进中国银行重点商户智能终端通讯服务费用采购投标项目，完成全套投标文件合规审核，敲定最终报价，同步完成文件打印、盖章、封装全流程工作。
下午：开展招商银行南京分行 IT 开发服务项目前期筹备，深度拆解招标文件；针对两大标包匹配对应实施案例，对接宿迁地市项目经理调取案例结算单据；完成析标报告撰写，同步梳理拟定投标保证金、案例佐证发票等配套资料。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','customer-support','owner','1.江苏省商务厅网络安全设备与LED屏采购项目技术参数梳理，编制应标文件；2.跟进省气候中心网络设备与数据安全项目进展。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：
1、支撑省民政厅、淮安市行政审批局组件迁移对接工作。
2、协调三方人员，开展组件超市7个组件并发能力压测，沟通测试事项和要求。
3、整理组件超市接口设计说明书，补充组件超市系统组件接口和组件服务接口的接口详细信息。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','淮安公司、扬州公司特殊项目导入导出等现场支撑；镇江特殊项目后向采购流程沟通支撑。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','内部工作电脑报账资金计划、报账流程要求等工作，联系财务、综合等对后续流程要求沟通。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：
1、处理丁江离场事宜，注销苏网通、人脸识别等，带领丁江向客户汇报；
2、重写交接备忘录发给客户；
3、参照数据湖项目熟悉软件功能nesma估算法报价基本知识；
下午：
1、正式向客户提交丁江离场材料，客户认可走完全部流程；
2、回公司同钱程对接数据湖项目国产化改造事宜，过功能清单，了解相关知识，周二上午同客户过一遍调整后的报价清单。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','人社厅数据体系规划项目支撑；消防总队三全一大项目数据底座需求支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：12345项目投标文件编写；
下午：数交所项目现场投标、述标','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：中烟工户项目需规修改、海事无人机项目常州06601异常问题处理。下午：中烟工户项目模型工具，模型范例沟通、南烟端侧IP访问异常沟通处理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','跟进应急厅安全生产经济政策运维项目询价工作；优化应急厅应急指挥网项目招标文件并联系两后项开展招标方案技术交流','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','DCMM业绩筛查，并沟通地市项目负责人，代理机构','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1.全天：编辑、优化标书资质匹配系统
2.下午：
（1）参照行业案例修改要求，更新、修改麒麟平台行业案例1个
（2）在麒麟平台上传高校音视频采集与分析解决方案，并申请上架审核','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','1、江苏省省本级水质自动监测系统2026-2027运维服务合同、2026+年某区域自动站视频监控系统及网络维护（一期）采购项目（包1）合同、2026+年某区域自动站视频监控系统及网络维护（一期）采购项目（包8）合同签订，申请法人章、合同章，完成合同签订。
2、辐射类环评报告智能审批系统项目售前跟进','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午:
1.查看高价值定时调度失败的66个任务，解决sql开发提示表不存在、数据采集失败、质检失败、入标准表失败的问题。
下午：
1.记录省工业和信息化厅数据治理任务前后数据量以及异常数据量，对异常数量多的任务，进行删除部分规则，重新治理；
2.查看省工业和信息化厅剩余目录数据信息，并梳理治理规则。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：2026年镇江市普通国省道路网监测设施建设工程项目支撑；
下午：腾龙大道智慧快速路工程AI+建设管理场景服务项目支撑','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：麒麟超期及新质生产力方案核查
下午：麒麟行业场景方案编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：制造业生态联系人、公司介绍、对应行业解决方案、典型案例搜集整理；
下午：麒麟平台制造行业场景方案审核。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：线上参加2026年国家卓越级领航级智能工厂申报要点解读会。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.对齐智慧食堂最新进展，准备统一测试网络ip
下午：
2.一体化门户工作台系统功能测试
3.帮客户准备环保集团在职证明模板','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','12345民生智慧听项目：
1、与项目组成员沟通专报月报难点，并形成攻坚文档；
2、与数字政通、金讯沟通明日交流提纲
两平台项目：
1. 完成周末测试问题整改及前后端联调：修复及时性规则配置缺少爬虫字段问题，调整准确性规则标签填写位置，两项问题均已处理完毕。
2. 全面性规则中 爬虫数据与现有数据匹配功能 正在开发调试，当前进度60%，尚未完成。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1、GA厅数据湖项目造价复核（第二版）。
2、人工智能开发造价规范案例论证项目梳理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：修改调整疾控省统筹平台（二期）中重大和重点传染病管理系统（升级）和传染病病原监测系统（升级）设计开发方案和计划、概设（共4个文档）；
下午：归档2个验收项目文档（铁塔海洋项目和海事无人机项目）；支撑CCIA资质审核，协助查找验收项目的合同和验收报告；修改调整疾控省统筹平台（二期）中重大和重点传染病管理系统（升级）和传染病病原监测系统（升级）详设、数据库结构设计说明书（共4个文档）。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、组件超市日志审查与公共平台对接，协调奇安信的技术人员对接日志异常事件的应急处置预案的处理事项。
海事局：
1、处理差旅费报销流程改造、表单改造、打印单据改造、固定资产领用流程改造。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、开展组件超市7个应用场景的并发能力压测，沟通测试事项和要求。
3、协助大数据中心丁主任处理短信服务组件的申请表单字段无法必填的问题，协调组件超市的开发人员完成问题的修复，完成功能开发测试后交付客户并且对问题进行闭环验证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：梳理组内FDE项目清单
全天：沟通协调准备镇江转研发项目材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1、开展沿海集团验收准备工作2、中石油项目站点故障处理3、跟进检察院项目医保局项目审核进展
下午：1、省消防局指挥中心研判分析报告智能体展示，细化功能需求','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：优化agent 智能体，分析每日日报内容','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、数据流通交易平台项目标书制作打印盖章封箱
2、“数字人大”XC改造项目问卷部分XC改造可行性沟通
下午：1、“数字人大”XC改造项目客户现场交流AI复刻农业农村厅案例
2、省级枢纽管理“三统一”平台项目受托代销流程支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1.协助确认信创OA服务器数据库端口访问
2.继续对接档案题名和文件内容不一致问题
3.根据客户要求维护OA流程节点
下午：1.根据客户需求维护OA账号
2.维护OA前端表单字段
3.协助客户登录数字人大系统
4.加班重启档案服务，并继续测试验证题名和文件内容不一致问题','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 继续编制系统运行维护管理方案，今天已完成初稿。
3. 盘点未完成工作任务，与开发沟通本周工作目标。
4. 讨论一体化主职、兼职处理方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','出差连云港，支撑连云港国资项目，重点围绕投资板块整合生态，配合规划demo产品','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-20'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：江苏省领航级工厂申报材料培训；招商局重工申报书项目沟通','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-20'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：公安精品案例更新','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='黄思华'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-20',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-20'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：
1.协调跟进发改API网关环境安装；
2.盘点正式环境服务器，与厂家核实每台服务器现在使用情况，沟通缩减计划及回退措施，汇总输出生产环境服务器缩减方案；
3.输出发改上周周报。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1 江苏省医保局客户交流江苏移动云网算力与行业解决汇报方案编制
2 徐州口腔医院AI+智慧医院宣讲方案编写','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1  第四届 光华杯总决赛 医疗影像云项目路演方案优化修订
2 数据要素与高质量数据集合作生态方案交流–医渡云','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：太仓集宿区信创改造项目，支撑地市客户经理，讲解方案核心内容','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：麒麟平台历史方案更新
下午：南通专题会项目审核材料编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：参与中烟工业互联网项目汇报会议
下午：梳理中烟工业互联网项目的卷包工序生产工艺流程','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','下午：梳理制造业生态梳理，完成剩余3条，麒麟平台政研政策处理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、参加合同起草审核培训会议；2、编写优化“一点调度”系统自有产品协同交付流程需求文档；下午：1、复核1-6月行一二工作量数据；2、编写优化“一点调度”系统自有产品协同交付流程需求文档','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源敲门行动项目组例会；省林业局目录信息核查及下线申请；财政厅一本账清单质检问题处理；
下午：档案馆互联网区数据库问题交流；与云网处对接医保局、生态厅云网资源关联事宜；省监狱管理局数据申请记录迁移清单更新；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统功能全量测试
3、回归采购系统测试问题，跟踪问题整改进展
苏政源：
1、调整初验材料
2、交流性能压测问题','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.AI方向证书搜集，制作宣传文件（全天）
2.参加数字人大后项厂家交流会（下午）','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：
1、工业纺织行业生态拓展，完成2生态厂家沟通；
2、工业专班虚拟团队会议，大生集团项目情况汇报梳理，1h；
3、中烟培训材料优化，修改衡阳“431”数智烟站项目案例并按要求进行全部7个案例培训讲稿梳理；
4、教育行业江苏院专家支撑费结算沟通；
5、教育本周社会集成商中标信息采集。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、记录机关党建云平台用户使用问题反馈并修改
2、准备明天工委全省培训，修改机关党建云用户手册，宣传页，ppt格式和内容，和工委领导确认后并准备打印','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','汇报每日全省签约情况','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：
1.和处室汇报数据局投标信息汇聚情况
2.去处室现场开会沟通全省教师资格认证数据回流对接工作
下午：
1.核实历史对接链路，排查政务外网环境的接口地址
2.参会和数据局、教育部讨论后续垂管系统数据回流对接工作
3.和苏政源对接讨论后续推进方案','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：常州二院大模型软著申请材料编制；
下午：人工智能团标案例资料整理；','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：三化省内项目拓展支撑；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、JCB-2025-160项目合规性支撑
2、JCB-2026-042合同流程支撑
3、JCB-2025-017合同流程支撑
4、JCB-2025-091请购流程支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏脑机接口研究院实验室综合智控平台项目：审核报价文件、述标材料，开会讨论述标内容及材料。
2、南京医科大学附属口腔医院数据中心交换机项目，完成开标，测算二次报价等。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','江苏省茅台酒业协会智能化项目前向合同处理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：全省项目合同系统培训。麒麟医疗相关案例超期处理。
下午：智慧医院高价值雷达方案编制，麒麟平台售中造价模块测试。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源数据治理项目支撑。
上午：1、苏晓慧-数据治理对接方案推送频率沟通；2、设计数据治理推送数据表；3、数据治理整体流程介绍；
下午：1、OceanBase标准库性能问题沟通；2、排查数据治理效率慢问题，优化采集性能；3、统计治理情况，编制治理日报；4、与客户确认治理系统原型；5、沟通数据归档和备份方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：政府网站与新媒体传播影响力平台解决方案配套材料编制；党政生态可用性定期维护在线文档政务等子领域生态维护；麒麟平台方案党政超期资源更新计划方案搜集统筹；省人社厅AI+人社建议报告材料支撑部门协调
下午：政府网站与新媒体传播影响力平台解决方案配套材料编制；党政生态可用性定期维护在线文档政务等子领域生态维护','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：FY国产化改造项目对接生态厂家，技术方案及报价跟进整理；GT信息化系统建设供应商推荐表信息收集及编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：法院云迁移软著材料补充编写
下午：1、拜访可信数据服务邮箱公司，交流AI世界模型内容；
2、日报分析增加省直一线人员的评估，准备明日上线；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、中烟培训案例材料修改，对接苏州、无锡公司。
2、省工商联柔性织物抓取、服装AI设计图片标准库构想对接，沟通解决方案。
下午：
1、上研院天工平台生态运营思路对接，沟通店铺建设及生态维系。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','绽放杯6G素材收集、船舶领域专利编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='周俊凤'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周俊凤') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1.上午和安全技术处处室汇报即时通信大模型问题；统计组件二季度整体使用情况；跟踪处理刘处反馈的待办处理后跳转错误问题
2.继续更新验收文档，完成组件超市详设、数据库设计、用户手册、部署手册、迁移方案调整。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：江苏省卫健委云影像平台扩容项目，效益评估测算。
下午：江苏省教育科学研究院宽带网络接入及无线网络一体化服务项目，搜寻类似业绩，编写投标文件。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-TEST-07'),'project-support','solution-design','owner','省消防救援总队智能指挥系统项目支撑：AI数据底座嵌入方案评估；省应急厅面向突发事件的 5G-A 预警应急通信和指挥调度处置应用PPT素材梳理、准备','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','应急区域安全生产风险管控解决方案编制','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：东航 CVR 项目，与讯飞同步语音处理结果','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：对接摩卡，交流培训材料和确认培训讲师资源
下午：麒麟平台历史方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、省人大信创改造升级项目南京大数据集团可信数据公司项目对接沟通，评估可行性。
2、常州最佳实践案例复制推广《AI驱动政务服务平台-常州分公司最佳实践立项申请书》对接沟通；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、AI+能力建设研究，AI领域国家级、行业级、龙头级证书分析。
2、AI应用推进委员会2026 WAIC研讨会准备；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1.对新质生产力相关资源，以及麒麟平台内超期未更新资源进行核实与更新
2.行一行二证书资质维护名单实时更新
3.麒麟平台政研工单审核','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 敲门行动：联系常州药监追溯系统的运维进行一本账信息补充。协助省药监局开通审核账号
3. 组件超市：催促省市监局、淮安数据局推进组件迁移。
下午：
1. 敲门行动：(1) 为省药监常州分局收集并补充2个系统的一本账信息。(2) 梳理省委组织部101个云资源的系统划分
2. 整理老平台到新平台数据申请记录迁移清单（省税务局、省药监目录）
3. 更新组件超市迁移进度表，整理组件超市迁移完成的数量','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1、参加数据归集每日例会，梳理当日工作安排，同步各单位数据治理推进情况；
2、配合省生态环境厅解决一本账系统数据质量问题；
下午：
1、为人社厅302条智能编目数据目录进行手动替换下线操作，并核对目录信息。
2、完成省科学技术厅一本账数据质量问题处理工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、残疾人康复中心配套设施采购项目，和省人医信息处现场会议，沟通招标文件功能点和启动会汇报材料；
下午：
1、省统筹平台（一期）项目卫生资源和应急值守系统运维群用户使用问题答疑解决；
2、省统筹平台（二期）项目跨地区协查系统和隔离点系统功能评审并验证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：参加合同起草审核培训会议                           下午：处理用印故障生成应急用印码、处理行业内部报账问题、打印材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：宿迁港航智慧化项目报表核对，标书支撑；腾龙大道AI+服务项目备案支撑；
下午：科技兴安业绩、路网监测业绩收集整理、创新内容梳理，人工智能学会应用解决方案赛道申报书编写','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','人工智能学会人工智能科技成果奖申报工作','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','2025-097项目合同审批流程支撑；2026-016采购流程支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1、演示中小企业平台跳转；
2、联系研发二部优化麒麟商场部门内容；
3、组织商贸行业厂家交流。
下午
1、参加麒麟例会；
2、协调OPC、算力平台与中小企业平台讨论新平台对接事宜。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、支撑宿迁公司内部合同流程；
2、审核商贸行业技术方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：淮安JCB-2026-061项目投标支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：保密项目管理系统关于单据退回后特殊情况问题方案与保密办、摩卡确定，待摩卡排期制定需求书','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：编写商业智慧通行解决方案，已完成方案内容编制，整理24年至今相关项目，待完善方案项目案例','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1）参加部门周例会；
下午：1）和海致交流情指行项目；
2）到南京烟草进行项目交流。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1，协调药监集成平台联调问题；2，参加室内周例会。
下午：1，跟进东航CVR项目讯飞音频转写和东航的数据标注事项。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1.数字人大潜在供应商交流；
2.数智发改运维人员调度；
3.数据集团临时开发需求分析；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.FDE汇报材料修订；
2.规划软集项目安全生产规范与检查清单；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：
1）江苏中烟工业有限责任公司专有云平台三期项目：系统梳理母子公司近年与阿里云云平台相关项目的实施业绩，开展横向对比分析，并与行业室进行沟通。基于母公司业绩在应标中具有明显优势，已明确由母公司作为投标主体参与本项目应标工作。
下午：
1）江苏中烟工业有限责任公司门户及办公系统升级改造建设项目：与潜在合作方沟通设备售前选型，逐项核对招标文件中标注“●”的参数指标要求。同步推进投标文件技术方案编制工作，围绕电子签章签名平台建设需求，撰写技术方案相关内容；针对系统总体架构、安全性及性能等核心需求，完成技术设计方案内容的撰写。
2）江苏中烟工业有限责任公司专有云平台三期项目：启动以母公司为主体的投标文件编制工作，搭建投标文件整体框架结构，同步开展商务资质类证明文件的收集与整理工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、江苏海事局档案室改造方案沟通；
2、江苏海事无纸化会议系统方案沟通；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、参加室内周例会并进行例会工作整理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：JCB-2026-070/JCB-2026-071项目投标支撑','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：苏政源项目。协调后向厂商定位系统崩溃问题，确定为数据库磁盘空间耗尽后服务宕机，紧急协调云服务运维删除备份文件释放一些磁盘占用，恢复数据库服务；
下午：苏政源项目。找总集沟通给异议处理扩容资源，多番沟通确认流程后完成；与门户协调在其页面上按客户要求加入指标筛选功能，沟通需要的指标项我方接口提供；完成三方测试的7项压测场景的接口梳理，配合三方测试压测；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：苏州区域合理用药项目：后项（美康）方案沟通，协调现场汇报时间
下午：中能盛康区域健康信息平台建设采购项目（标包1），投标方案支撑：医疗部分补充','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：1.数据直达日报接口数据统计
2.完成公共数据平台运维运营服务工作周报
3.共数据共享和开放相关指标的二季度数据指标统计
下午：1.人社被申请资源统计
2.编写公共数据平台运行管理月报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会梳理现有工作，协调事项等。
2.到战客中心参加项目启动会，明确责任，确认进度等事宜。
3.慧诺厂家人员到现场沟通建设情况，讨论下一步计划。
4.生态能力寻源工作推进。
5、到慧诺厂家公司讨论后续项目解决方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、上午向客户汇报HY平台XC改造工作量清单，根据客户要求组织修改；
2、下午牵头GA苏小智项目启动会，明确团队人员职责、项目交付目标，细分演示版本、商用版本演进路线。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.整理脚本任务导出数据，准备excel数据
2.和省委老干部局进行对接沟通，准备目录清单
下午：
1.撰写7月份数据治理运营月报
2.撰写7月13-7月17数据治理周报
3.和省红十字会进行对接，指导部门技术人员对数据库进行清洗','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：省高院指挥中心智能化项目汇报材料审议。                          下午：江苏中烟工业有限责任公司南京卷烟厂新建备件库物流系统项目应标分析','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：徐州分公司某HZ小区智能化建设受托代销合作协议合同用印；2026年徐州市某医药产业园机房综合备电服务项目受托代销合作协议合同用印；徐州分公司战客某单位运维研判系统ICT项目合同系统流程处理　
下午：1、徐州分公司贾汪某单位（YR）监控智能化项目合同流程处理；2、智慧干休所解决方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','病假','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：巡检人大APP、互联网界面关于新闻内容、数观人大的数据一致性。熟悉数据管理平台交接文档。
下午：和医保监理沟通关于验收材料审核问题，参加医保总集卫宁组织关于周三给局长汇报的会前会议，配合整理文档，提供数据支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
沟通确认润州区街道空气自动监测站点运维服务项目初步需求，完成需求分析及需求支撑调度。
下午：跟踪推进淮阴区县级养老机构消防安全管理中心建设项目进展。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：
党政行业一点调度工单全量台账对接沟通需求、部门打印费用预测。
下午：
党政行业公共事务支撑（7.21一点调度新增工单维护）、班组日常公共事务支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：更新区域智慧教育云平台解决方案，梳理政策、案例等内容。
下午：麒麟平台上传场景方案，产教融合专产适配平台、产教融合岗课融合、AI+安防实战人才培养。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：与主任沟通,按要求处理已办导出功能调整完整，修复大批量数据导出网络超时问题；
下午1、省质检院对系统进行现场；根据软测的功能问题清单，对相应模块出现的问题进行截图或解释；2、协助局机关工作人员访问OA系统即配置证书登录方式','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、参加部门周例会，听取部门重点工作及思考；2、与合同系统讨论关于ncc对接的缺少字段问题；支撑合同系统历史附件迁移的技术讨论；
下午：1、与市场部汇报子公司pms和商机系统对接路径，还需要跟子公司进一步对接，确认方案；2、与双杨一起跟沈总汇报人事一件事方案，双杨不愿意在门户开发，沈总也同步给双杨施压，目前双杨先出界面设计。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1、汽车零部件行业细分领域场景方案编制；
2、麒麟商城对接中小企业公共服务平台新版本需求沟通，麒麟能力商城入口界面设计。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','机关工委项目全省培训工作准备
知识产权局AI导航项目协调支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','安排跟踪内部培训
工会事宜
协助人力资源部政绩观查改工作
一体化考证资源方案 撰写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、日常服务器巡检，一切正常；
2、参与青海人大调研会议，汇报演示系统；
下午：
1、处理南京建邺账号问题；
2、清理不用的账号信息。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、民政殡葬领域商机政策梳理、解决方案优化；
2、苏州中祭网民政行业信息化交流','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目相关工作对接、梳理；
2、麒麟党政相关工单、数据梳理整合','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','operations-support','owner','1.国家税务总局江苏省税务局互联网线路及服务租赁项目联系客户约定拜访时间，沟通招标文件修改细节等内容。
2.江苏省自然资源厅两个标品项目了解项目内容，跟进后续流程。
3.江苏省商务厅网络安全设备项目研读招标文件，联系后向厂家准备技术材料。
4.江苏脑机接口研究院实验室智能管理系统项目熟悉情况，招标内容。
5.应急厅运维项目过招标文件初版，提出建议。
6.国家消防救援局江苏机动队伍筹备组无线WIFI覆盖服务项目合同配合客户经理整理材料，合同归档。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','周例会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','沛县东南片区某B地块通信基础建设项目现场支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、本周计划上专题会项目4个（含上周未成功上会项目1个），完成分配沟通
2、连云港转研发项目采购公示重新提交','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：参加归集日例会，支撑省残联解决部门业务镜像库与苏政源平台断连的问题；

下午：支撑统计局完成新增数据在苏政源平台上的编目、归集和资源挂接；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','年休假','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','年休假','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午病假
下午：
海事展厅、海事无纸化会议项目对接，沟通明天测试事宜
盐城高速项目初步对接
东航CVR项目与战客项目管理组对接前期情况，沟通项目启动会事宜','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：
与政企、采购沟通标准ICT体系事宜。政企计划明后天召集讨论。组内沟通后续分工等。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：中国银行重点商户智能终端通讯服务费用采购投标项目，协助项目开标，后端支撑；
下午：招商银行南京分行 IT 开发服务项目，搜集项目案例，提保证金流程，分配两个标段共48名人员职责分工并梳理经历，搭建投标文件框架','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','bid-quotation','owner','1、跟进省商务厅网络安全设备及大屏采购项目，对接深信服、奇安信厂商，逐项核对产品技术参数，确认是否符合项目采购要求。
2、结合招标需求开展本项目投标文件的整理、编制工作。
3！跟进省气候中心项目挂网情况。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：
1、支撑常州市数据局、江阴行政审批局、省应急管理厅组件迁移对接工作。
2、整理组件超市接口设计说明书，补充组件超市系统组件接口和组件服务接口的接口详细信息。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','淮安公司、扬州公司、镇江公司特殊项目导入导出等现场支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','外部专家平台纵向监督模型、地市领导阅知功能等需求沟通确认，初定安排本周功能上线','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、参加公安厅数据湖项目国产化改造客户汇报会；
2、按照客户要求基于nesma估算法调整国产化改造功能清单；
下午：
1、修改国产化改造功能清单，将第二版给客户过一遍，客户初步肯定；
2、按客户提出的意见调整第三版国产化改造功能清单，已符合客户对金额、占比等方面要求，次日给到客户确认。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','连云港国资一张网项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','标准ICT项目场景规划组织；环保行业垂直大模型申报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：支撑宿迁，梳理全省检察院相关案例
下午：射阳县公安局AI项目协调支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：麒麟材料梳理及汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1. 12345项目标书商务部分编写完善，整体进度推进；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1. 数据要素申报书素材沟通；
2. 专题会常州项目沟通。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：回公司中烟工互项目项目汇报，下午：协调ip为“10.43.8.119”的虚拟机问题排查。整理中烟中工互项目周例会汇报ppt。跟进徐烟数据标准评审进度。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','梳理应急厅采购需求、项目服务范围、预算约束，完成招标方案初稿搭建，涵盖服务内容、人员配置、评分细则、商务条款模块；线上对接客户，同步方案编制进度，收集客户修改意见，调整技术服务要求、考核标准相关内容；
整理沟通纪要，同步内部商务、技术，同步客户核心诉求，待二次修订完善方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.全天：编辑、优化标书资质匹配系统
2.下午：参与AI世界模型落地合作方案汇报，了解学习世界模型','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','江苏省工业和信息化厅厅机关中心机房运维支撑服务项目:准备报名材料申请账户，完成项目投标报名，根据ICT公司情况，分析投标文件。申请投标水印、申请投标用印，根据招标要求整理商务资质，编写响应文件大纲。
苏垦农发无人机项目合同审批被打回，和战客沟通解决方案，准备调整呈批','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午:
1.处理规则，把制定的规则转换成具体的SQL或者正则表达式;
2.平台配置规则,并反馈解决同表同字段提示规则表达式已存在的问题。
下午：
1.对省工业和信息化厅剩余表进行数据治理，并解决表离线抽取异常卡住导致治理任务失败问题；
2.更新当前治理进度到在线文档；
3.整理今天高价值失败任务，并和昨天的进行对比，找出一直失败的任务，并归纳失败原因。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：盐城高速智能化项目支撑
下午：腾龙大道智慧快速路工程AI+建设管理场景服务项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：麒麟行业解决方案上架、AI方案优化
下午：交通行业案例库信息更新','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：编写缫丝加工生产计划优化、缫丝加工车间智能排产场景方案。
下午：优化新能源车整车制造车间智能排产、新能源车整车制造能源智能管控场景方案并提交平台；麒麟平台制造行业场景方案审核。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.参加项目晨会，对齐一体化门户/移动端APP当前进展；
2.和客户沟通自动售卖业务的收费管理事项；
下午：
3.与大数据沈总过一体化门户各节点功能','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','12345民生智慧听项目：
与数字政通、金讯交流各家产品能力（数据治理、智能报告、智能问数等功能）
两平台项目：
依据昨日输出的引擎最新规范完成规则协议修改，全量适配数据质量规则相关功能，该项工作 100% 完成，为今日规则优化提供底层支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：审计厅GA数据湖历史项目支持，与客户沟通审计要求，全天出二版文件。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：修改调整疾控省统筹平台项目中重大和重点传染病系统（升级）和传染病病原监测系统（升级）接口设计说明书、编码计划及代码编写规范和模块开发卷宗（共6个文档）；
下午：编写“六优项目”申报材料。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午
1、确认系统清理说明材料上传情况，了解协同办公系统初判结果变更原因，与客户汇报最新进展
2、器械备案许可数据差值分析
3、按照客户要求，编写深化政务服务数字化一体化建设情况材料
下午
1、绩效系统软测
2、按照客户要求，编写深化政务服务数字化一体化建设情况材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、和大数据中心处室沟通即时通信目前部署新功能的几个问题，会后与联通大模型人员对接沟通开通相关网络策略。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、和奇安信的人员沟通日志审查的事项，确认了对于日志审查不通过的几个问题的处理方案。
3、组件超市7个场景的性能并发能力压测，自行压测后交付三方测试人员进行最终性能指标的压测。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：梳理行业项目售前方案
全天：沟通协调准备镇江转研发项目材料，修改材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1、处理中石油站点故障2、省消防需求梳理更新，与客户重新交流对接。
下午：1、跟进沿海集团验收材料准备工作。2、检察院医保局流程跟进，与后向厂家讨论三方检测流程。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：优化Agent 智能体流程，输出日报分析模板','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1、省级枢纽管理“三统一”平台项目受托代销流程支撑
2、连云港市大数据管理中心信创迁移项目支撑需求沟通现状摸排
下午：1、“数字人大”XC改造项目AI复刻厂家南京大数据集团现场交流
2、“数字人大”XC改造项目价格整理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1.给青海省人大演示数字人大系统，并解答相关问题
下午：1.根据客户需求调整数字人大OA流程节点的判断条件
2.给客户提供OA无水印公文原件
3.根据不同会议核对档案接收库的会议文件','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-21'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 继续讨论一体化主职、兼职处理方案，分析切换机构对门户、各子系统的影响。
3. 讨论工作日志、领导日程模块原型设计。
4. 测试综合办公系统签报模块。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','连云港国资一张网项目支撑；润州空气站运维项目对接；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','省属企业应用场景机会清单对接征集表反馈','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-21'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：公安智慧法院应用系统适配优化与运维管理软件软著编写
下午：招商局重工项目跟进及汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='黄思华'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-21',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-21'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.优化发改生产环境服务器缩减方案；
2.去税务局解决会议文件下载后断网报错问题；
3.核实大学生竞赛项目客户意见是否优化，跟进验收进度；
4.处理发改互联网vpn门户密码重置问题。
下午：
1.参加周会，与发改客户汇报生产环境服务器缩减方案；
2.与吴承云同步发改工作最近进展并查看系统。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1 苏州福利总院智慧康养解决方案支撑
2 徐州口腔医院AI+智慧医院宣讲方案优化','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1 江苏省医保局客户交流江苏移动云网算力与行业解决汇报方案编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','下午：太仓集宿区信创改造项目，和苏州公司项目经理对接本地公司方案与报价，评估可行性','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：南通公安项目专题会审核材料编写；下午：麒麟平台信创基础方案更新；信创生态厂家联系方式更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：参加中烟工互与国家局工互对接讨论会议','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：汽车用发动机行业、船舶改装行业等细分领域场景方案编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、输出优化“一点调度”系统自有产品协同交付流程需求文档初稿；下午：1、编写软集项目安全生产管理制度；2、填写数智化转型工作进展，包括六支队伍建设赋能情况进展、朱总发言部分文稿内容等','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源敲门行动项目组例会；省委组织部云网对应关系核对关联，省林业局政务信息系统专项清理工作支撑；
下午：省林业局文件目录资源挂接，目录信息核对；财政厅、监狱管理局一本账系统问题核查处理；更新各单位对接工作每日进度台账。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统功能全量测试
3、回归采购系统测试问题，跟踪问题整改进展
苏政源：
1、调整初验材料
2、交流性能压测问题','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：全面搜集 AI 行业相关资格认证信息，对比各类证书的发证机构、含金量及应用场景，整理输出专项组内汇报材料，为团队人才规划、投标人员配置提供参考。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、南京市K12阶段AI+教育支撑，提供解决方案，沟通汇报思路；南京丁思娴
2、工业中烟培训材料，7个案例讲稿编写优化并提交。
下午：
1、教育行业高校具身智能生态厂家乐聚机器人合作交流，1.5h；
2、工业纺织行业场景方案编写，完成服饰制造产品虚拟验证场景方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、准备机关工委全省培训打印材料，包括200份宣传页和150份使用操作手册
2、保障机关工委全省培训
3、按照工委领导要求，核对并记录机关党建云党组织人员数据，按照用户整理的党组织人员信息来修改系统内的人员数据','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','汇报每日全省签约情况','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.跟进部门政务信息系统复核工作，推动部门及时填报
2.推动水气数据归集，今日已经全部完成并汇报客户
下午：
1.梳理教师资格认证对接方案，对接国办平台沟通后续对接事宜
2.和苏政源以及开发团队沟通后续互联网区数据对接推进方案','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：南京软著事宜跟进；省内医院评级情况梳理；下午：江苏省医保局汇报材料编制；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','1、JCB-2025-151等3个项目实施过程材料审核','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、镇江市域市域指挥中心硬件运维服务项目内部合同支撑
2、镇江中央储备粮监控维保项目内部合同支撑
3、政企解决方案经理认证考试','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、江苏脑机接口研究院实验室综合智控平台项目：开会讨论述标内容及材料，修改技术方案，如业务流程图、技术实现能力等。
2、江苏省卫生健康委员无线覆盖项目，修改确认招标参数要求。
3、南京医科大学附属口腔医院数据中心交换机项目，编制招标参数建议、技术参数要求，跟进招标流程及材料。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','下午：江苏省地市互联互通及电子病历案例梳理。南京市全民健康数智平台项目需求分析，麒麟能力匹配。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：麒麟平台基础方案上架，南通市全民健康信创精品案例编制。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源数据治理项目支撑。
上午：
1、目录归集系统对接方案沟通，制定治理频率：IRE是cdc实时；FTE是全量定时；RPE实时；IDU表示增量定时无删除标记位；TTG表示增量定时。
2、排查和解答数据治理异议数据问题，异议系统对接推送目录名称等字段设计；
3、治理与目录系统对接，设计目录信息同步接口，支持主动同步目录信息模块；
4、OceanBase标准库性能优化排查；
下午：
1、梳理气象局8类库表资源，更新数据治理任务清单；
2、对接归集系统和基础库，推进地市一表通数据治理工作，开展镇江南通泰州一表通人员数据治理，排查南京徐州盐城一表通无资源问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：政府网站与新媒体传播影响力平台解决方案配套材料编制；党政生态可用性定期维护在线文档政务等子领域生态维护；省人社厅AI+人社建议报告材料修改
下午：政府网站与新媒体传播影响力平台解决方案PPT修改；党政生态可用性定期维护在线文档政务等子领域生态维护','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：GT信息化系统建设供应商推荐表沟通完善定稿并刻盘提交
下午：FY国产化改造项目对接厂家跟进技术材料并沟通报价相关细节','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、法院云迁移软著材料补充编写；
2、对应软著工厂界面提升优化；
下午：1、宿迁检察院项目案例支撑，对接生态及相关方案；
2、日报分析增加省直一线人员的评估，今日已上线；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1、中烟培训逐字稿修改
2、省政企天工平台、天工网培训会；南通大生、招商项目会议

下午：
1、依托战客三大行业重点客户清单对接南通、常州、南京、苏州、无锡、泰州等6重点地市，沟通驻场可能，待回复
2、科拓（速停车）生态交流，车场运营场景对接
3、上研天工超市生态引入对接','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='周俊凤'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周俊凤') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1.准备公共数据平台验收材料合并以及部分内容重构，上午编写完善公共数据平台概设、数据库设计部分文档；
2.下午编制完善公共数据平台系统运维手册、测试方案、测试报告等文档','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：江苏省教育科学研究院宽带网络接入及无线网络一体化服务项目，整合投标文件。
下午：江苏省电教馆云端课堂项目，方案修改。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-TEST-07'),'project-support','requirements-analysis','owner','上午：省消防救援总队智能指挥系统项目支撑：大禹平台数据治理产品赋能总队重大灾害专题应用可行性评估、项目卡位能力DI部交流
下午：和对讲AI+消防监督执法视频分析、5G视频119智慧警务服务方案消防救援总队现场交流','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：东航CVR项目语音标注进展同步；中烟软件改造项目了解跟进','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：对接摩卡，锁定下周五信创培训讲师档期','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、省科技厅科技进步奖生产力促进中心形式审查问题沟通与处理；
2、农垦集团超期合同沟通与处理；
3、省数据局12345三期项目投标支撑；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、云智部数据供给平台沟通对接，研究是否用于客户项目；
2、商研发部沟通明确转研发指标口径及储备商机摸底。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','疾控省统筹平台（二期）项目驻场，专项工作内容学习。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1、更新资质维护与申请内容。
2、麒麟平台政研工单审核。
3、软集周报本周工作进展与下周工作计划收集整理。
4.麒麟平台内超期未更新资源核实与更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 组件超市：两次前往大数据中心，为淮安数据局、常熟数据局增加网络策略
3. 协助省委办公厅机要局增加账号、访问苏政源系统
4. 专项清理：联系司法厅、九三学社、省检察院、

下午：
1. 专项清理：(1) 协助省检察院开通复核权限 (2) 与水利厅沟通整改方案
2. 敲门行动：(1) 为省委组织部先锋平台重新划分云网资源 (2) 整理省市监局云网系统和项管系统不匹配事项
3. 数据归集：为省税务局修改所有新编目目录名
4. 合并验收文档：测试分析报告及系统部署方案，并调整格式','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源-敲门行动
上午：
1、参加数据归集每日例会，梳理当日工作重点，同步各单位数据目录推进情况；
2、解决人社厅智能编目目录替换无法下线的问题，完善300余条人社厅智能编目目录名称修改工作。

下午：
1、完成省文旅厅智能编目替换老目录下线工作，并修改100余条智能编目目录名称；
2、协助公共数据平台组完成概要设计说明书的格式修改及内容补充。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、省统筹平台（一期）项目卫生资源和应急值守系统运维群用户使用问题答疑解决；
2、省统筹平台（二期）项目基础能力管理系统和症候群监测系统每日开发功能评审并验证；
下午：
1、残疾人康复中心配套设施采购项目，根据客户要求继续修改完善启动会汇报材料；
2、医疗大数据清洗项目，协调服务器资源现场部署搭建终验演示平台。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：售中组周报收集与统计、处理部门内开票的报账问题          下午：省公司政企部收入和成本计提-2026年项目管理驻派人员支撑服务（第一批）、处理OA系统部门内部报账代办','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：宿迁港航项目支撑；镇江路网监测项目支撑
下午：人工智能学会科技兴安应用解决方案申报书编写；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','全天：JCB-2025-140的后向合同附录借阅、复印、传递；一体化研发费用付款、计提、冲销台账统计；特殊项目清单台账更新。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、协助战客支撑无锡商贸项目（曹宇 江苏华地国际控股集团）；
2、审核商贸行业上传方案；
下午：
1、邀请合作厂商交流（科拓）
2、协调市场部、研二部讨论麒麟商城结果匹配优化问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：淮安JCB-2026-061、徐州JCB-2026-068项目投标支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1、编写商业智慧通行解决方案，完成初稿并同领导汇报，针对问题点进行修改调整；2、对接商贸项目需求针对广告营销相关生态拓展；下午：科拓生态交流，就AI+智慧停车平台开展交流；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午1）中烟专有云及门户项目投标分析；
2）国泰信息化系统供应商推荐表审核；
下午：1）工信厅厅机关中心机房运维支撑服务项目标书审核、打印、盖章及封装。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：1，药监局项目：和各厂商沟通玄武平台部署事宜，采集信息；
2，和战客沟通东航CVR项目启动会相关事项；
下午：1，政企交付经理认证考试；2，东航CVR项目，和东航讯飞沟通当前数据标注进展；3，跟踪数据集团三统一项目，连接器入库项目，商务厅信创改造等项目的进展。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.与政企、DI讨论FDE人员标准，编制FDE人员分级标准初稿；
2.协同云智部与政企部讨论智宇平台提升方案；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：
江苏中烟工业有限责任公司专有云平台三期项目：推进项目投标筹备工作，整理母公司投标保证金材料，紧急跟进并催办内部审批流程；梳理并确认母公司及项目经理的业绩证明文件；同步编写云平台软件产品业绩及项目经理云平台建设经验的甲方证明材料。
下午：
江苏中烟工业有限责任公司门户及办公系统升级改造建设：推进项目投标工作，拟定项目团队人员配置及相应资格证明材料；梳理并确认投标人及项目经理业绩，发起内部流程申请相关业绩合同对应的发票扫描件；与潜在合作伙伴进行技术对接，沟通优化技术方案。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、江苏海事局档案室改造方案与客户汇报沟通；
2、江苏海事无纸化会议系统方案现场测试验证，阶段性成果汇报客户；','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：JCB-2026-070/JCB-2026-071项目投标支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：苏政源项目。异议处理系统宕机，紧急删除数据库测试数据恢复；与数据治理团队沟通重复数据推送的问题，暂定几个解决方案待与客户汇报定夺；
下午：苏政源项目。与云网运维人员沟通处理磁盘扩容，增加一块数据盘并配置定位客户反馈的从人法信推送异议数据后，存在多个审核信息的问题，初步定位是和统一用户标准角色对接的问题；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1，常州妇幼高质量数据集方案确认（确认具体哪家后项的方案拿去汇报）
2，预约协调深圳云医下周现场沟通时间
下午：1，南京市全民健康数智平台项目分析
2，深圳云医数据中台方案沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:1.整合公共数据平台运行管理月报
2.确认二季度公共数据开放平台开放目录数据量
下午：1.协助省委社工部完成政务系统专项清理复核工作
2.协助盐城确认人社数据完整性情况
3.数据直达日报接口数据统计','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会梳理现有工作，协调事项等。
2.给客户孙主任汇报项目进展，并请示MCP工具问题。
3.继续邀请慧诺厂家到现场了解系统和平台建设情况。
4.开始测试工作准备，编写测试用例，协调测试人员。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、上午协同战客中心、DI部修改启动会会议纪要；
2、全天协同生态研究公安苏小智工作流；
3、下午与DI部沟通，针对当前演示版本梳理功能清单和测试方案（含平台和定制）。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、下午与综合部沟通6月我室数智化工作加分情况，目前针对同一系统的优化不能重复加分；
2、上午与市场部结合苏小智一点调度要求，沟通售中一点调度中增加协同调度子流程的入口。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.整理脚本任务导出数据，准备excel数据
2.和省委老干部局进行对接沟通，准备目录清单
下午：
1.撰写7月份数据治理运营月报
2.撰写7月13-7月17数据治理周报
3.和省红十字会进行对接，指导部门技术人员对数据库进行清洗','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：梳理公安厅证件制作中心硬件运维项目应标文件，对标招标条款逐项核对，完成商务资质、项目业绩、团队资料规整。优化适配公安涉密场景的技术运维方案，校验报价明细数据，排查整改内容及细节问题。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：根据行业总监要求，开展人社厅AI相关材料修订工作。对照业务需求逐项优化内容逻辑，调整表述措辞，完善方案细节，核查材料前后内容一致性，完成文稿调整汇总。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：徐州分公司某HZ小区智能化建设项目、2026年徐州市某医药产业园机房综合备电服务项目合同处理；
下午：徐州分公司战客某单位（TTNY）机房综合备电服务项目、徐州分公司鼓楼某单位HZL小区智能化ICT项目合同处理；智慧j供保障方案材料整理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：外部专家省政企2026年1-7月各地市分摊数据统计、外部专家省政企2026年7月各地市分摊数据统计','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：巡检人大新闻模块内容；支撑医保局局长关于模型成效的汇报会相关工作。
下午：医保验收材料编写工作，完成监理需要提供的相关材料。核对参数信息表。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
沟通连云港大数据中心机房运维及基础设施维保服务项目初步需求，完成需求分析及需求支撑调度。
下午：
与市场部沟通对接重复单系统bug问题，完成连云港大数据中心项目工单流程问题解决。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：
梳理24年、25年打印明细分析，对接省直售前、省直售中确认部门打印费用26年最终预测。
下午：
党政行业公共事务支撑（7.22一点调度新增工单维护）、班组日常公共事务支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：麒麟平台场景方案上传开放性产教融合实训基地等3个方案。
下午：生态交流-乐聚具身智能产教融合方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1、根据昨天开会计划，对新能源地质队提供的流程问题需求清单进行表单、流程调整；二勘院、地质六队流程调整
下午：1、根据昨天开会计划，新能源地质队提供的流程问题需求清单进行表单、流程调整；地质一队财务流程调整。2、联合征信区块链项目与客户经理沟通，尽快完成第一次验收材料。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、局属单位网站不良信息处理；2、与水勘院沟通，提出出差流程优化。3、根据第二次软测问题记录表，对52项问题进行整改。
下午；1、与陈主任沟通，修改地质四队关联表单调整修改，2、海洋院流程问题调整；3、地勘院工作状态统计功能修改完善，需支持配置全部数据权限用户，其余用户只看本单位工作状态信息等','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：与人力系统讨论，在入职流程中，添加CPU卡、资产申请等固定连接，快速发起。
下午：与工程公司明确对接方案，重新调整方案材料，针对两种方案分析优劣势；与双杨明确个人中心入离职一件事开发责任，初步明确，先在个人中心将界面设计出来，找客户确认效果。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','智慧印章系统：协助印章系统OCR网络策略测试验证，已经测试通过，待厂家验证功能；写同步脚本将拷贝老印章照片到新paas存储上，正在执行。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：支撑大津重工密闭空间安全监管项目，协调大境科技提供解决方案，同时沟通省内落地案例参观事宜。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：1、汽车零部件行业细分领域场景方案编制，完成3个；
2、与研二、市场部开会沟通麒麟商城AI问答策略调整方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','保障省委机关工委项目全省培训工作','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1、日常服务器巡检，运维服务器磁盘清理；
2、跟踪即将到期的授权系统，进程催促；
下午：
1、处理连云港地市新增人员会议权限问题；
2、处理盐城软证书登陆问题；
3、处理张家港门户推送事宜；
4、淮安市接口报错，已协助定位。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、殡葬方案金融监管模块、案例优化；
2、淮阴区养老机构消防项目对接支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目场景专项工作梳理
2、党政解决方案审核；
3、党政行业麒麟工作、行业资源框架梳理；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1.国家税务总局江苏省税务局互联网线路及服务租赁项目招标文件核审修改，提交客户侧。
2.江苏脑机接口研究院实验室智能管理与后向开会了解述标内容，梳理述标ppt内容，理解项目。
3.应急厅运维项目包一梳理招标要求，核对商务资质等，方案要求等
4.省公共资源交易信息化平台项目梳理商务资质，重点标记实施风险点，告知客户经理。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','强军计划考试','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、南京K12阶段AI+教育支撑，沟通汇报方案
2、教育行业高校具身智能生态厂家乐聚机器人合作交流','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、安全员续证线上培训
2、政企解决方案经理（中级）认证考试
3、信息系统建设与服务能力二级（CS2）资质辅导简易采购呈批根据财务意见修改重新提交','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、与苏政源公共平台组联合定位统计局“双主键”任务归集报错的问题；2、梳理共享订阅记录中来源系统的真实对应关系；
下午：1、上门支撑统计局完成剩余目录的编目归集和资源挂接；2、协助文联、统计局完成信息系统专项填报部门复核工作；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','人社厅数据体系规划设计项目：赴人社厅汇报规划情况，下一步根据人社厅信息中心主任意见修改材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
省海事无纸化会议及智能体项目现场联调部署及支撑
下午：
省海事无纸化会议及智能体项目现场联调部署及客户演示
省海事数字展厅现场客户对接最新需求','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：
构思标准ICT体系构建整体框架及部分材料编写。
标准ICT月度材料编写。
数据要素申报专家指导事宜处理等。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：针对招商银行南京分行IT开发服务项目组织内部析标会议。经过评估，标包一需要投入大量自有人员长期驻场，整体风险较高，决定放弃投标，仅保留参与标包二的投标工作。
下午：继续跟进招商银行南京分行IT开发服务项目，梳理并确定标包二的投入人员名单，整理后发送邮件确认；跟进办理标包一投标保证金的退回流程；初步完成项目9个技术方案的内容编写工作。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','solution-design','owner','1、商务厅网络安全设备及LED屏采购项目：编制项目应标文件；
2、江苏省消防救援总队2026-2027年度信息化及卫星通信网运维服务项目：根据客户反馈意见修改完善方案，明天下午前往消防沟通核对项目方案；
3、江苏省应急管理厅第七届应急管理普法知识竞赛活动项目：沟通项目立项事宜。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','全天：
1、支撑常熟市数据局、常州市数据局、淮安行政审批局、省市监局、苏州吴江区行政审批局组件迁移对接工作
2、测试OCR组件性能，整理测试报告
3、协助整理组件超市运维手册文档','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、扬州公司、镇江公司特殊项目导入导出等现场支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、徐州丰县某内部合同与DICT系统同步问题支撑
2、强军计划政企解决方案经理认证考试','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、给客户汇报第三版国产化改造功能清单；
2、按客户要求进一步优化千条功能点描述改出第四版。
下午：
1、给客户汇报第四版功能清单，会议沟通功能点优化方向；
2、同客户一起完成功能清单优化，发至客户。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','连云港国资一张网项目支撑、连云港大数据中心机房项目支撑、省人社厅数据体系规划思路方案支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、宿迁检察院项目案例支撑
2、信创全省培训、人员认证等工作组织协调
下午：
1、法院智能综合业务办公平台软件、法院业务应用系统云化迁移管理软件软著按要求进行补正修改
2、编写修正薄弱行业分析报告','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：参与并协调人工智能应用开发造价评估团标的项目论证','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1. 12345三期标书商务部分编写，推荐整体进度，沟通报价。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','数据要素申报书初稿编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：中烟工互项目与客户、阿里技术负责人沟通现有数据资产建模工具培训的相关事项。
下午：中烟工互项目与国家局对接行业工互方案的事项。会议明确对接内容一个是实时点位上传，一个是点位附带的属性有哪些。海事无人机等保测评项目报价单材料盖章，流程提交。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、梳理省公共资源交易信息化平台运维服务项目招标文件内容，并输出析标文档
2、整理驻场人员配置、服务周期、故障响应承诺等招标条款，优化文本语序；调整方案章节通用表述，按照标准模板编制各项方案评分细则。
3、电话对接客户，汇报招标方案编制当前进度，同步文稿内需要核实确认的相关事项。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：编辑、优化标书资质匹配系统。整理，打包资质匹配系统方案内容，梳理进入测试阶段。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏省工业和信息化厅厅机关中心机房运维支撑服务：修改技术方案，商务资质整理，整理项目报价，投标文件编写，投标文件整合，通过领导审核，定稿。
2、2026年高管中心收费系统网络安全升级项目合同打印盖章，完成合同签订，寄出合同。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:
1.使用老流程方式，通过任务编排一个一个跑高价值治理任务，并跟踪异议数据进入异议表异常问题；
2.反馈老流程方式数据流转异常问题，并协助排查问题原因。
下午:
1.处理标准表数量大于归集表数量问题，对部分流程优化sql处理逻辑；
2.对部分规则进行删除，避免出现大量异常数据问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：盐城智慧服务区一体化示范提升工程项目支撑；
下午：盐城智慧服务区一体化示范提升工程项目支撑；宜兴普通国省道路网监测项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：交通行业案例库信息更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：梳理麒麟平台中录入的制造业生态，收集生态在对应国民经济小类中的解决方案以及典型案例，补充到小类覆盖情况表中。
下午：DICT系统中搜集精品案例素材；编制人工智能AI综合监测平台服务项目精品案例。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.参加项目晨会，对齐一体化门户/移动端APP当前进展；
2.统一现场测试智慧食堂网络，共计20个ip
下午：
1.收集各子系统火绒全盘扫描木马查杀结果
2.和售卖机厂家沟通自动扣款业务情况','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','12345民生智慧听项目：
完成项目技术部分标书框架，与生态伙伴沟通技术内容编制细节
两平台项目：
已整理好本次页面修复、新增匹配功能的完整代码包，准备部署至开发环境供测试人员复测；当前存在阻塞问题：负责开发环境发版的人员紧缺，无法及时执行发版操作，修复后的代码无法快速部署上线，导致页面修改内容、全新的爬虫匹配功能暂时无法进入测试验证环节，延后了后续规则全量配置的推进节奏。
省公共资源交易信息化平台运维服务项目：
统筹上一期运维模块厂家及本次运维模块厂家，准备与对应模块厂家对接内容','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1、针对人工智能应用开发造价评估团标的项目论证，试点项目材料编写。（1个传统ai应用+1个智能体应用）
2、GA数据湖历史项目审计申报材料配合修改。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：继续编写“六优项目”申报材料；
下午：
1、和供应商沟通优化功能变更统计表；
2、与急传所开会展示本周重大和重点传染病系统和流调系统的进展，并记录优化需求进行跟踪。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午
1、协调集成平台与药生审批系统联调测试工作
2、组织集成平台和数据中心信创项目软测前工作准备
3、根据客户要求，对深化政务服务数字化一体化建设情况材料进行调整
下午
1、根据客户要求，调整深化政务服务数字化一体化建设情况材料
2、组织数据中心、器械采集系统，开展器械备案许可偏差讨论会
3、跟进系统清理说明材料复核情况
4、玄武平台纳管推进，布置工作部署，准备操作手册及反馈文件，下发给系统','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、调测OCR组件系统提供的相关接口服务的响应以及识别图片的输出的准确率，配合ocr系统技术人员进行模型的调优工作。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、对接OCR后向厂商人员尽快调试提供的图片识别功能接口，并且测试接口的响应时间和识别的准确性。
3、整合组件超市维护手册的组件服务部分的材料。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','下午：省公共资源交易信息化平台运维服务项目情况沟通','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：沟通协调准备镇江转研发项目材料，修改材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、获取沿海集团客户验收资料模板，与后向讨论具体要求2、处理中石油站点故障
下午：1、检察院医保局审核进度跟进，与客户进行汇报。2、跟进气象局开发进展。3、高投验收资料二版完成，交付客户经理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：优化Agent 智能体流程，输出日报分析模板
下午：编辑行一行二本周周报','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、“数字人大”XC改造项目价格调整；
2、江苏省数据集团有限公司数据流通交易平台项目标后流程支撑；
下午：1、省级枢纽管理“三统一”平台项目受托代销流程支撑；
2、省级枢纽管理“三统一”平台项目标后代理服务费流程支撑；
3、江苏省人民医院雨花院区固定电话开通IAD等设备采购项目受托代销合同推送。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1.根据会议类型整理档案库未整理的会议文件
下午：1.客户的桌面运维相关事宜
2.指导委员会处室进行季度考核
3.根据客户需求整理省人大季度考核信息并反馈','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-22'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 向客户汇报综合办公近期工作进展情况，就非正式文书、工作日志、领导日程等功能展示原型设计。
3. 电子签章系统对接会议，与契约锁厂家交流对接方案。
4. 根据客户网安要求，收集厂家联网人员个人电脑病毒查杀结果。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-22'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','连云港国资一张网项目支撑，沟通投资模块Demo优化事宜，同步梳理并规划报价策略。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='麻鑫宁'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='黄思华'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-22',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-22'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.跟进税务无纸化验收进度，与客户沟通验收材料；
2.解决发改堡垒机密码重置问题；
3.更新发改项目人员表，与客户报备新增人员；
4.沟通发改API网关EIP地址申请；
5.为应对环保检查对电脑安全扫描；
6.参加环保项目晨会。
下午：
1.梳理发改API网关对内及对外网络策略；
2.沟通发改新API网关ssl证书申请；
3.参会投资系统与三重一大接口对接，梳理现有问题。
晚上：
1.完成人力系统与老系统部门对比分析，输出对比结果。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1 江苏省医保局客户交流江苏移动云网算力与行业解决汇报方案编制
2 省人民医院无人机物流项目设备选型甄选','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1 江苏省医保局客户交流
2 光华杯总决赛路演项目宣讲词编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：金湖县新创集采项目，商机跟踪，标书分析；金湖县苏采云项目，配合华为公司，提供说明函文件并盖章，将苏移集成公司纳入华为代理商名单，支撑金湖检察院客户下单','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','下午：麒麟平台信创过期解决方案更新；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','下午：工业专班-中烟工互项目周例会汇报材料编写','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、接市场部通知收集7月份部门工作量，发布最新收集模板并填写要求，和各组对接人沟通相关填报注意事项；2、撰写软集项目安全生产管理制度；下午：1、更新数智化月度例会重点事项跟进表；2、输出软集项目安全生产管理制度初稿，制作软集项目集风险监督点表','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源敲门行动项目组例会；卫健委、民政厅、农业农村厅云网对应关系核对关联；
下午：省林业局数据归集支撑，监狱管理局目录信息核对；档案馆政务外网数据库申请；一本账系统问题核查处理；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统功能全量测试
3、回归采购系统测试问题，跟踪问题整改进展；
4、整理合同系统数据库表格详情','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：全面归集梳理 AI 行业各类资格认证资料，编制形成专项工作汇报文稿；摸排统计组内人员本年度证书报考计划与取证进度，统筹推动组员资质能力同步提升。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：傅利叶合作交流，沟通具深智能产业学院解决方案，梳理南京、淮安13所医药类高校、高职进行重点合作清单；
下午：江苏农牧职业技术学院AI体育、AI实训项目支撑，沟通项目进展、学校具体需求，计划下周进行客户方案汇报支撑。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：
1、教育行业上半年拓展情况汇报材料编写；
2、工业专班-大生集团周例会项目汇报材料编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、处理机关党建云116家单位用户反馈的问题，指导用户系统使用的步骤
2、按照工委领导要求修改机关党建云系统操作手册内容
3、工委全省培训完成后的问题梳理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','汇报每日全省签约情况','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：
1.对接国办推进教师资格认定数据回流工作
2.梳理数据链路，内部讨论对接方式
下午：
1.和国办平台老师会议确认对接细节，并拉通开发对接
2.梳理老平台迁移到苏政源的数据情况，对新老平台数据进行比对','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：江苏省医保局汇报材料编制；下午：光华杯决赛材料准备；麒麟方案上架审核；医疗机器人生态厂家现场交流方案及商机；','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、JCB-2025-021项目实施过程材料审核
2、JCB-2026-072项目投标支撑
3、JCB-2026-071项目投标支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、镇江中央储备粮监控维保项目内部合同支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、江苏省卫生健康委员无线覆盖项目，根据客户意见修改招标参数要求。
2、南京医科大学附属口腔医院数据中心交换机项目，根据反馈意见招标参数建议、技术参数要求，跟进招标流程及材料。
3、江苏脑机接口研究院实验室综合智控平台项目：开会讨论述标内容及材料，修改技术方案，如业务流程图、技术实现能力等。敲定终版响应文件及述标ppt，响应文件盖章、封装','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：傅利叶智能线下交流，关于具身机器人智慧医疗，工业等行业应用及解决方案。
下午：紧急救援基地无人机模块项目询价。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：医疗行业周工作汇总分析及工作量上报，麒麟基础方案上架，精品案例编制。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源数据治理项目支撑。
上午：1、梳理老干部局新增13类库表资源，治理任务排期；2、跟进地市一表通治理情况；3、修正广电局资源变更情况；4、调整统一数据运营苏晓慧对接规范。
下午：1、异议对接会议，和客户沟通质检出的异议数据非重复及异议数据展示，异议工单推送需求；2、支撑人口基础库推送统一数据运营数据血缘问题；3、处理目录信息、归集信息同步失败问题；4、跟进苏晓慧智能问数对接。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：政府网站与新媒体传播影响力平台解决方案配套材料修改；省人社厅AI+人社建议报告材料修改（增加先进省份对比，省内问题梳理,架构图和附表）党政生态可用性定期维护在线文档政务等子领域生态维护；
下午：政府网站与新媒体传播影响力平台解决方案配套材料修改；省人社厅AI+人社建议报告材料修改（增加先进省份对比，省内问题梳理,架构图和附表）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：FY国产化改造项目对接厂商沟通报价内容，GT信息化系统供应商推荐跟进
下午：GA情指行材料生态能力及案例补充编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：月报审核系统方案设计；
下午：AI应用汇报PPT编写；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、徐工消防人员定位及管理技术方案编制对接
2、行业部工业专班汇报材料编制
3、宇特纺织方案及天工二级平台接入需求对接','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','视频专利审核未通过，初步沟通原因，准备修改。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='周俊凤'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周俊凤') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1.上午公共数据处开会过密评方案，密评方案调整，处理用户反馈的一本帐组件数据错误问题
2.继续调整祥设，概设，数据库设文档格式','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-TEST-06'),'project-support','bid-quotation','owner','上午：江苏省医保五期扩容项目，后向沟通，梳理实施计划。
全天：江苏省教科院宽带网络接入及无线网络一体化服务项目，修改投标文件，审核定稿，盖章封标。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：省直驻场组周报汇总整理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：省消防总队119视频接警能力建设项目支撑：针对业主需求，对接在线公司完成服务器网络资源评估、外籍人员报警同声传译可行性评估
下午：省消防总队119视频接警方案现场汇报交流','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：出差无锡惠山大数据局项目支撑及交流汇报','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：信创周报编写，生态交流','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、云智部数据供给管理平台沟通对接，研究是否用于客户项目；
2、常州市钟楼数据局数据要素一点调度培训支撑；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、与规划技术部、专利代理机构、通信学会沟通，省科技厅科技进步奖生产力促进中心形式审查问题沟通与处理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','疾控省统筹平台（二期）项目驻场，参与周例会专项工作推进进度与项目架构掌握。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：1、统计一点调度行业支撑数据；
2、统计基础方案场景方案周报内容；
3、一点调度本月数据洞察ppt；
4、更新资质维护与申请内容；
5、编写麒麟平台建设下周工作计划；
6、战客7月工作量收集','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 专项清理：联系戒毒局进行复核确认
3. 组件超市：整理统计组件迁移进度表格
下午：
1. 调整初验材料详细设计说明书格式
2. 协助政协语音识别组件迁移网络策略开通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：
1、参加数据归集每日例会，了解当日工作安排及各单位最新进展情况；
2、完成省国动办、省人社厅相关历史目录下线工作；
3、跟进重点单位目录整改进度，查看系统问题处理状态。

下午：
1、核验省文旅厅和省人社厅数据推送情况，确认数据是否已全部推送到位，并检查推送数据量是否完整；
2、整理近期各厅局数据目录问题台账，更新工作进度记录；
3、协调处理部分遗留系统配置问题，准备后续核验工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、参加疾控省统筹平台（二期）项目周例会，汇报演示各业务系统当前进展及协调事项；
2、省统筹平台（一期）项目卫生资源和应急值守系统运维群用户使用问题答疑解决。
下午：
1、残疾人康复中心配套设施采购项目，根据客户要求梳理平台使用数据库资源信息，编写平台建设和功能使用情况；
2、残疾人康复中心配套设施采购项目，梳理对标国家电子病历系统应用水平分级评价标准；
3、编写疾控省统筹平台（二期）工作双周报材料；
4、医疗大数据清洗项目，填写项目软测报告基本信息。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','下午：泗洪无人机信息化项目(JSISISH13000020260421016)用印支撑、江苏省市场监督管理局应急指挥信息项目系统定制软件开发和公共组件维护用印支撑、关于2026年ICT行业售前支撑合作项目支撑服务费采购用印支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：行业支撑一部售中组周报统计与收集、配合综合部将部门所有人工位的碳包进行曝晒和发放、7月实习生工作量收集 下午：寄收快递、打印盖章','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：2026年镇江市普通国省道路网监测设施建设工程项目支撑；人工智能学会科技兴安应用解决方案申报书编写；
下午：有关科技兴安、路网监测项目实际落地资料、建设成果成效资料搜集；人工智能学会科技兴安应用解决方案申报书编写；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','盐城转研发项目后向收款、付款沟通','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','7月工作量收集，7月人员工作量审核；各地市收入台账核对；参加投标相关法律法规培训','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午
1、参加全省连锁商业及商客半年度复盘暨重点工作沟通会；
2、沟通南通公司“启东市吕四渔港智慧渔港管理平台项目”。
下午：
1、参加“江苏华地国际控股集团”需求对接会，协同战客、无锡分公司分享客户需求，并制定初步服务方案。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、支撑常州公司内部合同流程（ICT某医馆智能化项目合同）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：JCB-2026-072项目投标支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：保密项目管理系统制定表单优化项，与摩卡沟通可行性，确定最终修改项','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：梳理科创中心项目建设内容及情况，完成项目资料编写；
下午：1、支撑扬州大学后向付款材料，完成项目验收材料盖章；2、麒麟平台商贸方案梳理，整理缺失领域；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：1）和中烟门户厂商（联创）沟通项目情况；
下午：1）评估门户项目厂商；
2）东部机场OA项目讨论投标策略；
3）协助交通行业高管中心网络项目开标。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：参加东航CVR项目启动会；
下午：1，和东航讯飞沟通当前数据标注进展；2，跟踪数据集团三统一项目，连接器入库项目，商务厅信创改造等项目的进展。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、协同政企、DI修订FED人员分级标准初稿；
2、与综合部讨论交付经理评价标准；
3、行三人员转入战客重客二讨论会纪要编制，与综合部讨论人员管理方案；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-TEST-09'),'project-support','bid-quotation','owner','上午：
1.江苏中烟工业有限责任公司门户及办公系统升级改造建设：对接项目潜在合作方联创，同步项目整体推进事项，重点沟通述标材料编制要点、应标资质证明材料清单、技术方案撰写逻辑及项目落地实施规划；同步深度拆解招标文件用户需求书，梳理项目各类技术、商务风险。接收业主项目澄清通知，获悉招标人计划修订招标文件相关条款，本项目投标节点相应延后。
下午
1.江苏中烟工业有限责任公司专有云平台三期项目：推进江苏中烟专有云平台三期项目投标工作，牵头修订云平台产品业绩、项目经理业绩对应的甲方业绩证明函，优化函件表述、规范佐证内容。梳理集团母公司投标所需全套商务资料清单，明确各材料对接部门、提交时限与编制标准，统筹协调相关资料归集工作。完成母公司投标文件商务章节全部内容编制、整理，商务材料部分定稿。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、疾控中心例会汇报','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、数智化例会材料编写','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：JCB-2026-070/JCB-2026-071项目投标支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：部门支撑本周周报整理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源项目。处理客户异议处理审批流问题，沟通发现统一用户的角色混乱，导致我方工单流转分配异常；与门户沟通统一用户角色的职责、首页显示信息接口报错，定位是网关等待时间1s问题；
下午：苏政源项目。与客户开会讨论异议系统和治理系统数据推送问题，形成部分结论，其他部分需要上升处长决断；开会演示统一用户角色存在的问题，反馈确认问题；与客户演示系统功能，完成初验功能检查表全部功能点确认签字；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='李悦'),'leave-afternoon','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：傅利叶智能线下交流智慧医疗机器人场景','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：休假','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1.数据直达日报接口数据统计
2.配合处室统计老平台目录相关数据
下午：1.公共数据平台7月数据指标统计
2.配合机关事务管理局进行上云准备','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：江苏省环保集团一体化信息系统平台项目
1.现场开会讨论智慧食堂进展与接下来工作。
2.与厂家远程会议讨论上线前需准备工作。
下午：江苏省GA厅苏小智超级智能体项目
1.带领生态厂家慧诺了解现场情况，评估合作可能性、合作周期、报价等信息。
2.给孙主任汇报近期进度、安装客户端、请示接下来工作等。
3.继续按计划优化问题列表。
4.推进测试用例编写，功能列表确认。督促DI派测试人员入场测试。
5.输出厂家能力对比会议纪要。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、上午GA苏小智项目现场对接客户，沟通近期工作计划，同时针对客户孙斐然关于公文编写的要求进行沟通；
2、下午了解近一周江苏中烟工作进展，研究阿里处理模型规范；
3、下午编写GA苏小智生态BS演示版本建设比选汇报文档；
4、下午就检察院项目两项互联网服务安全检测费用问题向战客中心反馈。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、上午初拟本月数智化例会汇报材料提纲','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.整理脚本任务导出数据，准备7月份质量报告excel数据
下午：
1.核对已发布目录清单以及数据治理目录清单
2.准备电子证照7月份高价值数据，整理成电子证照质量清单','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','开展中烟集团烟草云升级项目析标工作，研读招标要求，梳理技术参数、资质门槛与评分要点，研判方案匹配度，排查实施风险，整理疑问清单，同步优化技术及商务响应思路。
推进中烟 OA 门户网升级项目析标，拆解门户集成、流程改造、新旧系统迁移等建设需求，对照评分细则查漏补缺，借鉴行业案例优化方案。
开展 GA 厅技侦智算云项目支撑工作，围绕平台架构推进系统能力解耦梳理，梳理算力调度、业务模块边界，调研组件拆分改造需求，分析解耦实施路径与潜在技术风险，同步完善方案思路。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：徐州分公司鼓楼某单位HZL小区智能化ICT项目合同系统提交定稿问题同客服沟通处理；　
下午：J营线上办公解决方案材料整理及方案编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：人大项目APP新闻模块巡检，协调厂商更新。医保反欺诈项目验收材料编制工作。
下午：医保反欺诈项目验收材料编制，完成5份材料的编制工作。跟进线索下发地市反馈情况。进行模型手册更新。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.对接沟通江苏省人社厅人工智能11类场景建设项目调度专家需求。
2.推进闭环淮阴区县级养老机构消防安全管理中心建设项目、连云港大数据中心机房运维及基础设施维保服务项目进展。

下午：
与市场部沟通了解项目工单发起调度工单流程，同步完成人社厅人工智能11类场景建设项目工单发起，并完成外部专家调度。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：
1.党政行业周报收集整合反馈。
2.党政行业公共事务支撑（7.23一点调度新增工单维护）、班组日常公共事务支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：梳理行业精品案例-阜宁县实验小学教育集团AI智慧体育采购项目，整合项目技术方案、建设成效，制作案例PPT。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','支撑SM过程材料，涉密载体管理各项工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：针对人力与财务薪酬方案、资源环境、AI中台、PMS方案等需要客户协调的事项，整理材料，待和客户汇报。
下午：参加财务部组织的预算系统与财务系统对接方案，以及业财融合方案，针对预算系统与一体化系统统一人员组织对接方案、移动端集成门户、招待申请对接方案、集团PMS系统后续对接方案提出意见，并现场讨论。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','智慧印章系统：拷贝老系统照片数据至新存储，今天完成2021年、2026年数据拷贝。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：与傅利叶智能交流工业具身智能机器人应用解决方案；
下午：南钢炉前烟气监测场景分析材料编写。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：麒麟平台完成工艺规划管理、工艺任务管理等10个过期场景方案更新。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','昆山全链交付支撑协调','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','安排跟踪内部培训
工会事宜
协助人力资源部政绩观查改工作
一体化考证资源方案 撰写','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1、日常服务器巡检，运维服务器磁盘清理；
2、处理客户现场的政务外网浏览器访问系统问题；
3、提交政务云工单，申请相关资源利用率情况。
下午：
1、处理数据局发函事宜，进行数据统计；
2、处理地市账号问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','党政民政领域存量方案优化更新；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目物联网应用、音视频会议场景清单梳理，与铁通对接沟通；
2、党政行业解决方案初审、精品案例拆解上架；
3、部门一体化人员组织架构调整','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1.公共资源交易中心智能语音与短信业务项目情况了解，协调不到客户经理建议人选支撑，已安排组内其他同事加班跟进。
2.江苏省数据集团有限公司数据授权运营平台2.0项目协调人员，完成提前用印流程，客户需要第二天拿到合同。
3.机关工委机房改造项目代理费流程催跟，代理费已临近截止日期，有废标风险，已沟通客户经理。
4.江苏脑机接口研究院实验室智能管理系统项目与后向厂家交流项目情况，整理述标材料，练习述标材料讲解。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、泰州江苏农牧职业技术学院AI体育、AI实训项目支撑
2、上海傅里叶生态合作交流','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、弱势行业分析编写
2、通管局安全员继续教育培训及考试','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：支撑统计局、科协、国资委、工信厅等部门完成信息系统专项填报部门复核和澄清文档输出；
下午：1、协调新点开发解决国办平台-教育厅数据回流过程中存在的问题，并输出接口调用文档；
2、协助统计局推进解决部门申请数据，供数部门审批人应收到短信提醒问题；指导供数部门完成数据样例提供和查看确认；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','人社厅数据体系规划设计项目：协同生态方对昨天客户领导要求汇总，对会上提到的人社部发文分析，计划下周一再出一版PPT，协调增派专家调度单','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','根据市场部给的清单，梳理精品案例，整理精品案例上架计划','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','海事无纸化会议项目支撑，根据昨天演示情况及客户需求重新变更方案。
东航CVR项目启动会','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：政企部对接沟通标准ICT场景方案架构
下午：对接铁通及细化方案设计，内部分解任务','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天:继续跟进招商银行南京分行IT开发服务项目，编写9个技术方案（招聘方案、日常运营方案等），对接商务找新增案例发票，寻找案例订单；中国银行数据补全项目，专利证书对接扎口人，母公司相关案例查找','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','solution-design','owner','1、商务厅网络安全设备及LED屏采购项目：对接深信服，审核技术参数证明材料，编制项目应标文件；
2、江苏省消防救援总队2026-2027年度信息化及卫星通信网运维服务项目：前往省消防对接客户，汇报项目售前方案，针对项目实施内容，派驻人员、评分方案及预算等细节进行沟通，提前规避项目后期实施审计审查问题；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','全天：
1、支撑省市监局、江阴行政审批局、省民政厅、省政协一体化组件迁移对接工作。
2、测试OCR组件性能，整理测试结果。
3、协调数字签名组件厂商，排查江阴行政审批局签名异常原因，最终排查为用户传参中携带特殊字符导致，已解决问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、扬州公司特殊项目导入导出等现场支撑
2、苏州、淮安、盐城等特殊项目甲方载体签收表，沟通地市及时交回；','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、7月数智化工作材料编写
2、内部电脑报账、资金计划等沟通综合部','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1、协调烽火处理现场运维，因商务问题没有协调成功；
2、邮件反馈数据湖项目运维情况；
3、数据湖项目其他子平台巡检；
下午：
1、深入了解nesma功能法各种功能类型判定方式，便于审计质疑时答复；
2、熟悉ps操作，通过ps调整考勤表重复的部分，后续重新打印。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','连云港国资一张网项目支撑；人社厅数据体系规划支撑；连云港大数据中心机房项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','连云港公司ICT支撑费问题协调；党政行业精品案例整改；集团三化自主度专家申报','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：与仁晶进行交流，对接信创服务器部署容器虚拟化平台相关事宜。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：
1、评审人工智能应用开发团标2个试点项目的验证报告
2、7月数智化工作材料编写
3、薄弱行业分析编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1. 12345项目投标文件商务部分完善，与政采中心沟通细节要求，技术部分技术推进。
2.支撑数据运营支撑平台2.0合同提前用印。
3.协助发改网络策略梳理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：中烟工互项目：沟通省里宽带、网络打通问题；编辑工互项目问题处理清单；
下午：收集第三小组工作量；中烟工互项目：周例会汇报ppt修改；为三家卷烟厂分配生产环境和测试环境账号；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1. 梳理药监相关报账配套材料，核对资料完整性、规范资料格式，补齐相关附件，推进核查报账流程
2. 与中邮建开展方案资料交流、交叉审核，核对方案商务、技术内容，记录修改意见，推动方案完善。
3. 向客户同步各项目当前推进节点，做好进度汇报，同步后续工作计划，收集客户最新诉求。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1. 完成标书资质匹配系统测试与成果汇报演示，同步编制在岗技术革新成果申报书，明确后续工具功能拓展方向。
2. 梳理灵犀晓伴平台接入规范，完成标书资质匹配系统的适配开发与技能上传，配套编写使用指引，推进工具团队内共享。
3. 明确月度项目支撑填报要求，收集团队成员月度支撑项目信息，完成数据核对汇总，形成标准化月度填报表。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：江苏省工业和信息化厅厅机关中心机房运维支撑服务项目投标文件定稿打印盖章，扫描上传，线上开标，完成项目投标工作。
下午：1、江苏省港口集团有限公司业务网络专线集中采购项目-业务专线标段，投标报名，获取招标文件，招标文件解密，根据母公司资质完成项目析标。2、江苏省港口集团有限公司业务网络专线集中采购项目-视频专线标段，投标报名，获取招标文件，招标文件解密，根据母公司资质完成项目析标。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午:
1.定位编排流程任务正常，标准表数据正常，异议表无数据问题；
2.重新整理高价值编排任务，调证SQL开发组件和质量检测组件顺序，并设置失败节点执行策略，解决异议表无数据问题。
下午:
1.重新一个一个跑高价值编排任务，对数据重新进行全流程治理；
2.查看老干部局目录和表，在平台上查看是否已归集并反馈未归集到治理平台问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：2026年镇江市普通国省道路网监测设施建设工程项目支撑；宜兴普通国省道路网监测项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','下午：麒麟平台行业解决方案编写；标准ICT场景事宜','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：梳理麒麟平台中录入的制造业生态，收集生态在对应国民经济小类中的解决方案以及典型案例，补充到小类覆盖情况表中。
下午：统计本周生态覆盖新增情况以及细分领域场景方案新增情况，补充到周报中；统计本周制造行业一点调度工单情况；过期场景方案更新。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.参加项目晨会，对齐一体化门户/移动端APP当前进展；
2.召开腾讯会议和小牛厂家沟通智慧食堂上线前准备工作；
下午：
1.汇总整理门户需要对外协调的工作内容；
2.跟踪IOS申请材料进展','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','12345民生智慧听项目：
沟通阅点点、科旭、微耐特三家生态公司，配合完成项目技术文档及投标细节
两平台项目：
前期修复及新增功能完成全量回归复测，各项校验逻辑、页面交互均无问题，复测结果达标；现已启动相关程序向测试环境部署工作，搭建正式测试验证环境，为后续规则配置、全流程校验提供环境支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、完善人工智能应用开发团标2个试点项目《试点项目工作量评估报告及评估表》，完善申报材料。
下午：1、完善人工智能应用开发团标2个试点项目《试点项目工作量评估报告及评估表》，并提交编委邮箱。
2、一键生成施工组织设计汇报ppt编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、参加疾控省统筹平台（二期）项目周例会，记录客户意见，形成工作记录跟进相关系统负责人；
下午：
1、参加省妇幼智慧产房项目周例会，根据王院长要求，跟进厂家准备给孕产妇培训和操作手册，为小程序试用做好充足准备；
2、编写疾控包一给周局长进展汇报材料；
3、收集汇总疾控包一各系统实际开发功能与招标文件对比变更情况表；
4、填写7月工作量。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午
1、数据中心软测
2、绩效系统安全测评准备
下午
1、绩效系统一季度名额优化，二季度名额录入沟通
2、参加集成平台事项调整清单沟通会
3、对接业务处室，统计并梳理江苏省执业药师数据
4、配合客户完善汇报材料
5、跟进器械采集系统数据整改情况','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、配合ocr厂商人员测试OCR组件api的接口性能，整理测试结果。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、整理组件超市试运行方案的材料的修改，交付监理单位审核。
3、和一本帐项目组沟通组件“一本帐”的对接问题，明确对接问题的处理方案。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：机关医院智能巡视系统项目修改招标文件参数','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：收集组内7月工作量，宣贯最新工作量填写要求','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：优化Agent 智能体流程，输出日报分析模板
下午：编辑输出日报分析总结模板','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：省级枢纽管理“三统一”平台项目受托代销流程支撑，中标服务费流程支撑；
下午：1、江苏省数据集团有限公司数据流通交易平台项目标后流程支撑；
2、“数字人大”XC改造项目AI复刻厂家南京大数据集团材料准备沟通。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：1.协助指导客户进行OA流程使用
2.客户桌面运维相关事宜
下午：1.整理OA两年来流程数据和用户活跃度并反馈客户
2.解答客户关于APP文件预览相关问题并指导','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-23'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、AI中台建设进度。
2. 电子签章验证服务部署情况，配置nginx代理，协调客户方企业认证经办人。
3. 招待申请编写接口字段说明文档。
4. 梳理综合办公和AI中台协调事项，编写情况说明，准备向客户汇报。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','连云港国资项目支撑，参与投资子系统的客户遴选工作，完成demo演示与能力汇报。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：招商局重工8大环节40个场景内容梳理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-23'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：公安精品案例更新','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='黄思华'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-23',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-23'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.参加环保项目早会；
2.梳理汇总人力及投资系统现存问题；
3.跟进发改测试环境上批释放服务器除已置换的服务器的处理情况；
4.协助吴承云梳理发改API网关网络策略。
下午：
1.收集第一小组工作量；
2.收集环保双杨、浪潮每周周报；
3.跟进上周环保人力会客户需求完成进度；
4.测试环保人力系统测试环境。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1 苏州福利总院智慧康养项目支撑
2 宿迁妇幼保健院全院信息化项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1 光华杯总决赛项目路演方案解说词编写
2 数据要素x 参赛项目，基于评审意见修订方案','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：无锡惠山大数据局项目支撑，协助寻找低预算纯软件改造项目','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：信创一人多证人员筛选；下午：苏采云网上商城入围厂商名单更新','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：梳理编撰江苏中烟工业互联网平台项目相关介绍材料，并做内容优化','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：参加工业专班会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、输出软集项目集风险监督点表和软集项目安全生产管理制度初稿；2、对接各组接口人，指导填写7月工作量；下午：1、提交江苏省知识产权局专利导航人工智能辅助系统项目周报；2、参加售中项目交付周例会；3、编制行业一部、二部7月数智化工作进展材料
本周工时分析：
专项支撑工作70%，生态交流10%，数智化15%，部门内部沟通协调5%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源敲门行动项目组例会；省林业局、监狱管理局政务系统专项清理；
下午：省林业局数据归集支撑，一本账系统问题核查处理；民政厅、农业农村厅云网对应关系核对关联；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统功能全量测试；
3. 整理商机、采购、合同系统全流程；
4. 收集整理项目周报
本周各类工作占比：客户交流沟通与内外部协调20%、编写文档10%、项目专项工作70%','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：开展麒麟平台知识图谱梳理工作，补充后项厂商相关资料
下午：负责麒麟平台 AI 会议室方案编制撰写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：1、工业专班周例会，汇报大生集团项目；1.5h
2、泰州市电教馆K12阶段AI+教育解决方案汇报沟通，提供汇报材料素材。泰州徐晗
下午：1、工业行业生态厂家拓展3家，场景方案上传3个；
2、教育行业社会集成商中标信息采集；
3、教育行业麒麟平台汇报材料编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、修改机关工委党组织党务干部兼职权限
2、按工委领导要求在党建云使用操作手册补充党组织角色权限介绍
3、处理党建云用户反馈的问题并核对党组织数据
客户交流沟通与内外部协调30%,编写文档40%,客户交办专项工作40%。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、全省每周签约数据汇报
2、参加售中组周例会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','客户交流沟通与内外部协调30%,系统维护30%,客户交办专项工作40%。
上午：
1.继续推进教师资格认定数据回流工作
2.持续跟进部门政务信息系统复核工作，督促未填报单位及时完成
下午：
1.梳理国家平台资源情况
2.参与售中例会
3.推进教育部教师资格认定数据本地落库
4.和客户对接高使用价值归集相关事项','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午医疗生态图谱梳理更新；下午：数据要素申报材料根据专家意见进行调整更新；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、JCB-2026-065项目投标支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、月度工作量申报
2、周报整理
3、南京某部队仓储信息化建设项目风险评估及应对方案沟通','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、江苏脑机接口研究院实验室综合智控平台项目：参加述标会议，完成项目招标流程。
2、江苏省卫生健康委员无线覆盖项目：分析项目发出的询价函，申请用印，对接厂家完成设备询价。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：国家紧急救援基地无人机项目设备参数编制及询价，后向沟通。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：医疗行业麒麟汇报材料编写，精品案例上架。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源数据治理项目支撑。
上午：1、梳理省教育厅11类库表资源归集情况，开展治理任务实施；2、处理南京一表通、盐城一表通数据未同步问题：归集系统归集频率实际为批处理，推送时使用实时模式，导致无法接受；3、跟进治理平台用户手册编制情况；
下午：1、沟通治理异议数据闭环问题；2、设计数据治理运行指标监控模块，开展一本账统计指标对接；3、处理地市一表通治理同步数据失败问题，治理服务调整导致失败，关闭重启重试机制解决。

本周各项工作占比：
1、客户交流沟通与内外部协调 35%
(主要涉及：苏晓慧对接规范沟通与指导、数据治理推送频率沟通、异议数据闭环会议、客户确认系统原型、各厅局资源梳理对接、一表通地市情况跟进等)
2、系统部署与故障分析 30%
(主要涉及：排查数据治理效率慢并优化采集性能、处理同步失败问题及重试机制、排查司法厅信息不对称问题、处理目录/归集信息同步失败等)
3、产品设计 15%
(主要涉及：数据质量模块原型评审及优化、设计数据治理运行指标监控模块等)
4、编写文档 10%
(主要涉及：编制治理日报、设计数据治理推送数据表及接口规范、跟进平台用户手册编制等)
5、风险管理与计划控制 5%
(主要涉及：治理任务排期、沟通数据归档和备份方案、统计治理情况、梳理各类库表资源清单等)
6、系统维护 5%
(主要涉及：OceanBase标准库性能问题排查与优化、修正广电局资源变更情况等)','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：省人社厅AI+人社建议报告材料修改（增加先进省份对比，省内问题梳理,架构图和附表）；党政生态可用性定期维护在线文档政务等子领域生态维护；政府网站与新媒体传播影响力平台解决方案配套材料修改
下午：麒麟平台方案党政超期资源更新计划方案处理统筹；党政生态可用性定期维护在线文档政务等子领域生态维护','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：省GA情指行汇报材料支撑：生态能力及落地案例信息搜集整理、ppt编写提交；
省GA国产化改造项目支撑：投标软著以及案例材料收集整理提交','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：月报审核系统模板设计；
下午：FDE工程师AI全栈能力汇报编写；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、工业专班例会；
2、工业项目拓展前中后期工作内容及角色分工素材整理，并提交省政企；
3、恒宝股份自动化产线项目需求对接。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、人工智能学会AI典型应用材料修改
2、针对退回专利结合研一部大课题内容，开展修改','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='周俊凤'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周俊凤') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1.上午和安全技术处沟通组件相关问数需求和需要调整的方案内容；处理一本账数据对接问题；OCR每日例行对接进展和后续优化方案讨论
2.下午完成公共数据平台数据迁移方案初稿，配合征信分包项目编写周报等材料。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-TEST-06'),'project-support','customer-support','owner','上午：江苏省医保五期项目，后向采购问题沟通。
下午：江苏省高校招生就业指导服务中心招考工作技术服务类项目，包1、包2、包3、包4，析标。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-TEST-07'),'project-support','solution-design','owner','上午：省消防救援总队智能指挥系统项目支撑：接处警智能体、指挥救援知识库智能体与现有“三全一大”设计方案匹配度评估；DI部大禹平台与现有方案可嵌入性评估
下午：省消防总队119视频接警能力建设项目支撑：项目建设模式变更为省总队统筹、13个支队各自建设的可行性沟通，评估建设难点与省统建模式造价差异','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','应急区域安全生产风险管控解决方案麒麟平台上架素材编制','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：无锡惠山大数据局项目支撑，协助寻找低预算纯软件改造项目；东航CVR语音标注进展同步','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：历史场景方案更新规划','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏省数据局12345三期项目投标支撑、异议处理；
2、常州钟楼区数据局数据要素治理培训沟通支撑；
3、省人大数字人大AI解决方案支撑；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、与规划技术部、专利代理机构、通信学会沟通，省科技厅科技进步奖生产力促进中心形式审查问题沟通与处理','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','疾控省统筹平台（二期）项目驻场，项目架构熟悉，相关专项工作内容学习。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：1、战客7月工作量收集核对工作
2、对新质生产力相关资源，以及麒麟平台内超期未更新资源更新汇总给市场部
3、更新周报一点调度行业支撑数据

本周各类工作时间占比：项目驻场学习10%，部门专项工作90%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 专项清理：提醒省检察院上传附件，协助省机关事务局整合系统。
3. 组件超市：协助省自然资源厅对接OCR组件
4. 调整初验材料详细设计说明书格式
下午：
1. 准备初验材料：(1) 调整详细设计说明书格式(930页）(2) 合并用户手册
2. 敲门行动：联系市监局确认云资源归属系统
3. 组件超市：协助淮安数据局调网络

客户交流沟通与内外部协调40%，编写文档30%，系统部署与故障分析14%，风险管理与计划控制11%，系统维护5%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源-敲门行动日报
上午：
1、参加数据归集小组每日例会，总结近期工作进展，移动小组共同分配下周工作内容和任务分工；
2、协助省生态环境厅完善系统登记信息，优化目录挂接和资源配置；
3、跟进人社厅历史目录下线及数据推送后续情况。

下午：
1、协助省文旅厅申请数据资源，指导其完成申请流程并协调资源对接事宜；
2、核查近期各单位目录整改进度，梳理系统问题、云资源关联问题等；
3、更新各单位对接工作进度台账，整理本周工作记录。
本周各类工作时间占比：客户交流沟通与内外部协调：50%、风险管理与计划控制：20%、编写文档：15%、系统部署与故障分析：5%、系统维护：10%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、省统筹平台（一期）项目卫生资源和应急值守系统运维群用户使用问题答疑解决；
下午：
1、医疗大数据清洗项目，推进现场部署验收演示系统环境，并同步客户协调服务器资源问题；
2、残疾人康复中心配套设施采购项目，完善启动会PPT汇报材料并提交客户。
本周对接省统筹平台（二期）、医疗大数据清洗项目、残疾人康复中心配套设施采购项目和临床研究患者精细化数据采集系统项目共4个项目，客户及厂商沟通与内外部协调资源50%（包括现场周例会汇报及系统功能演示，进度跟踪，用户使用问题答疑等），编写文档和周报材料30%，风险管理与计划控制10%，省统筹平台（二期）学习火山引擎Agent智能体10%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、参加售中组例会，汇报所负责项目具体进展；
2、填报6月报战客中心售中支撑工作量。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','本周支撑支撑泗洪无人机信息化项目，公司内部专项工作100％','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：收集26年7月实习生工作量、填写售中工作量、处理用印故障生成应急用印码 、配合财务部门处理项目会签工作                                                下午：老印章系统下线，备份原软件部署包、寄收快递','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：宿迁港中心港区陆运河作业区陆集中心港一期工程智慧化项目标书上传支撑、开标解密支撑；
下午：人工智能学会科技兴安应用创新解决方案申报书初稿完成；镇江市普通国省道路网监测项目支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','7月组内工作量收集，审核；特殊项目清单台账更新，维护。南通063中标后相关问题沟通确认。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='张涛'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：保密办讨论保密管理系统优化；
下午：南京公司SJ项目整改会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：完成商业智慧通行解决方案麒麟平台上架工作，已审核通过成功上架；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：1、整理7月二组工作量情况，梳理缺失内容联系补充，下发本月情况待确认；2、完成8月部门资金计划收集及上报工作；3、完成验收报告等材料盖章寄出','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1）中烟网络建设项目交流；
下午：1）讨论法院指挥中心交流材料；
2）交通厅危货监管项目客户交流。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：1，药监局系统清理专项工作，材料审核；2，玄武平台部署系统信息沟通；
下午：1，国泰聊天攻防系统项目启动会；2，药监局综合平台登陆问题协调解决。
本周工作时间占比统计：
客户交流与内外部协调：40%
系统问题处理：20%
客户交代专项工作：30%
其他过单等小项目日常管理：10%','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、数据局两平台提升项目甄选方案评审修订；
2、分析国泰联合演练网络技术服务项目建设内容，与云智部沟通安排项目经理；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、与综合部沟通战客驻场人员管理模式；
2、组织项目例会。
本周工时分析：
专项工作60%，客户交流沟通与内外部协调30%，风险管理与计划控制10%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：
江苏中烟工业有限责任公司专有云平台三期项目：
1.确认投标文件中的项目团队人员合理搭配并整理相关人员证书社保等商务证明材料；
2.跟催20W母公司投标保证金流程，跟催整理投标人业绩和项目经理业绩发票证明和甲方证明材料；
3.编写云平台三期整体技术方案，重点围绕软硬件扩容实施路径进行细化，补充实施阶段关键技术保障措施，同步完善运维体系章节。
4.已完成投标文件初稿合稿，并对全文进行首轮内部审核，重点聚焦废标条款识别与应标注意事项梳理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、江苏海事局档案室改造方案优化电梯厅和走廊与客户沟通；50%
2、江苏海事无纸化会议系统方案与客户沟通，形成方案反馈客户；50%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','下午：JCB-2026-065项目投标支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：行业一组项目周报收集整理、汇总二组数据填写行业部周报
下午：行业一组部门简报处理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：苏政源项目。与统一用户和公共数据平台交流用户角色问题，根据归集指导手册确定了我方映射的人员角色，并修改相应代码；设计修改多人推送的逻辑；
下午：苏政源项目。继续与客户开会讨论异议系统和治理系统数据推送问题，对于关心的重复推送、工单闭环方式、异议数据如何检查修改等问题达成一致，计划两个系统下周开始整改。
本周工作时间占比统计：
1、客户沟通交流40%
2、项目组内部其他系统对接交流30%
3、故障定位、协调云网处理20%
4、文档编写修改格式等工作 10%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1，深圳云医中台产品方案沟通 2，重庆医保病理云解决方案材料学习
下午：宿迁妇幼保健院智慧医院项目需求沟通，后项建设方案交流','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1.数据直达日报接口数据统计
2.配合人社确认市监的企业年报数据
下午：1.为客户统计累计调用量等指标
2.协助科技厅完成系统清理专项工作的复核和说明文档上传

本周各类工作时间占比：客户交流沟通与内外部协调50%、编写文档30%、数据统计20%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会。
2.明确客户新提出文档格式需求不在演示版本优化。
3.继续邀请慧诺到现场调研项目建设情况，同时将客户新需求同步给到慧诺。
4.推动正式版本B/S架构产品落地事宜，整合汇报材料。
5.测试用例第一版已输出，等待DI决定测试人员入场时间。
6.继续推动2BUG+6优化事项，详见在线表格。

本周各类工作时间占比：客户交流沟通与内外部协调60%、编写文档20%、风险管理与计划控制10%、交付与测试10%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、上午参加江苏烟草工互项目双周会，沟通数据模型、数据标准事项推进情况，并讨论解决方案；
2、下午就GA苏小智项目BS演示生态版本与战客中心沟通比选方案和计划。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、参与各部门AI专班例会；
2、向战略部反馈本周解决方案团队提升周工作内容；
3、参加省直项目售中例会，补充检察院等项目重难点问题。
本周工时分析：
项目支撑工作70%，生态交流10%，数智化15%，部门内部沟通协调5%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.核对已发布目录清单以及数据治理目录清单
2.准备电子证照7月份高价值数据，整理成电子证照质量清单
下午：
1.撰写省级部门质量报告月报
本周各类工作占比：客户交流沟通与内外部协调60%、编写文档30%、客户交办专项工作10%。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-TEST-02'),'project-support','solution-design','owner','上午：省高院指挥中心智能化项目汇报材料修改审议，定稿。
下午：公安数据湖遗留项目变更处理会议，协调相关事宜。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：融合创新行业案例信息筛选，编写精品案例','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：专家平台运营情况数据统计分析；
下午：外部专家地市领导待阅功能、一点调度平台外部专家工单提单规则同步问题同新纪元沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：人大项目新闻模块巡检。参加模型线索下发沟通会，梳理十个模型的线索。准备下发工作。
下午：整理医保项目验收工作文档。更新模型手册。配合总集更新模型质控信息表字段内容。
本周对接江苏省医保基金反欺诈大数据试点应用项目、江苏省数字人大项目。各类工作时间占比：客户交流沟通与内外部协调30%、编写文档30%、风险管理与计划控制10%、系统维护20%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.基于江苏省人社厅人工智能11类场景建设项目调度专家问题，发现系统Bug问题，对接市场部了解流程，复盘分析。
2.推进润州区街道空气自动监测站点运维服务项目进展，完成闭环。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：
1.党政行业周报完善。
2.党政行业一点调度工单部门周反馈。
3.党政行业公共事务支撑（7.24一点调度新增工单维护）、班组日常公共事务支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','下午：1、南通东南大学智能化项目支撑：梳理招标文件公司资质、证书、人员等控标内容。
2、南航天目湖校区实验中心项目支撑，对接常州地市，了解项目需求，协助寻找生态伙伴。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：处理苏州内部合同：江苏省国家教育考试标准化考点安检及信号屏蔽服务项目、融通云数据中心2026年度信息化运维服务项目、虞山森林防火系统维保服务项目，处理相关流程。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1、根据沟通地质一队议题申报流程重构及苏州工勘院流程调整；根据软件测试功能性问题报告，对系统功能进行补充完善
下午：地勘院工作状态需求开发，1、需可配置允许本统计记录的部门 2、需要可以设置允许查看所有组织记录的用户权限 3、状态更新用户可以自由配置
各厂商方案讨论、协调30%；
SM系统专项工作65%；
其他工作5%。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','与南京公司沟通，修改SM项目材料','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：与契约锁、OA讨论电子印章系统本次对接的范围，先对接集团本部公文场景，后续考虑推广到其他子公司；核对电子印章的企业认证流程。
下午：参加部门售中例会，将项目当前问题情况做了汇报；跟沈总汇报了PMS系统的最新方案；梳理经营管理流程操作步骤。
本周工作时间占比统计：
项目内部会议10%；
客户汇报及会议20%；
汇报材料、方案编写20%；
各厂商方案讨论、协调30%；
智慧印章系统专项工作15%；
其他工作5%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','智慧印章系统：把老部署包下载下来，在本地部署验证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：南钢烟气除尘风机能耗优化场景研究，与朗坤智慧交流相关解决方案。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：参加工业专班会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','51号评标','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天：
1、日常服务器巡检，一切正常；
2、南通账号问题处理以及调整相关配置；
3、客户现场问题处理。
本周对接江苏数字人大系统，系统维护30%，客户交流沟通与内外部协调30%，​故障分析处理25%，风险管理15%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','政府网站与新媒体传播影响力平台解决方案梳理审核上架','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、部门周报试点进展梳理；
2、标准ICT项目物联网应用、音视频会议场景方案整编；
3、数智化工作周进展梳理；
4、麒麟板块二党政行业项目工作整合','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','bid-quotation','owner','1.江苏省商务厅网络安全设备采购项目，沟通多个后向厂家，寻找适配硬件设备，待各厂家反馈确认。
2.机关工委机房改造项目代理费流程催跟，已经跟进到财务复审阶段
3.江苏脑机接口研究院实验室智能管理系统项目投标，述标。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、南航天目湖校区公共安全与数字治理新文科智能综合实验中心项目售售投标支撑
2、东南大学南通校区智能化项目控标沟通','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、连云港转研发项目资料完善，提交正式请购流程','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：支撑广电局、市监局、国资委、省科协等部门完成信息系统专项填报部门复核和澄清文档输出；
下午：协助解决国办平台-教育厅数据回流过程中存在的问题，省平台未收到相关数据，教育部推送的数据国办平台能收到但是未转发出来；
客户交流沟通与内外部协调70%，文档输出20%，计划和风险管理10%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、海事无纸化会议项目支撑，重新调整无线连接方案，平板等询价，形成最终方案。
2、扬州12328平台对接项目支撑
3、海事数字档案项目前后向对接报价等。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、组织编写标准ICT五个场景清单及方案，并协同生态进行报价等
2、组内例会及过标准ICT场景清单方案
3、室内创新例行工作，数据要素专家审核，人工智能编整附加汇报材料等。
4、室内周报，战客行业周报编整等。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天:继续跟进招商银行南京分行IT开发服务项目，上午与战客审核投标文件，下午根据战客意见修改人员经历、财报数据、合同文本，已初步定稿，等待价格；中国银行数据补齐项目，寻找母公司专利并提流程申请电子文档','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','solution-design','owner','1、商务厅网络安全设备及LED屏采购项目：分别对接深信服、齐安信审核技术参数证明材料；针对堡垒机、IPSEC VPN网关寻找符合厂家；
2、江苏省消防救援总队2026-2027年度信息化及卫星通信网运维服务项目：对接客户现场运维人员，补充完善现有硬件设备清单，安全服务内容，根据客户反馈意见修改完善方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1、支撑苏州吴江区审批局、省市监局、自然资源厅组件迁移对接工作；80%
2、整理省市监局所需的OCR组件迁移文档；20%
下午：
请假。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、常州公司特殊项目导入导出等现场支撑
2、南京某融合创新项目与保密办、战客中心、南京公司管理员开会讨论
3、南京公司、徐州公司融合创新项目报备沟通','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、徐州公司某内部合同问题沟通，地市提交废除合同呈批后，集成公司再重提合同。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1、月度工作量整理；
2、协助调整软集管理制度内容；
3、同客户沟通，客户强调下周内解决烽火平台两个问题；
下午：
1、参加售中组周例会；
2、数据湖项目苏州公安数据上报部分丢失问题协调解决；
3、核查周报表格数据填写完整度；
4、尝试处理麒麟系统微信功能缺失的问题。

对接公安厅某SM项目和数据湖项目，本周会议时间占比15%，客户事项沟通协调占比20%（国产化材料改进沟通、烽火平台异常沟通），客户所需材料编写占比50%，其他现场事项处理15%。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','连云港国资一张网项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、省属企业AI应用场景机会清单申报；
2、党政、交通、SM团队能力建设与项目支撑专项宣贯
3、标准ICT能力应用场景筹备','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、淮安苏采云项目协调支撑
2、无锡惠山大数据项目协调支撑
3、团队例会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、12345项目投标文件商务部分内部评审并修改、整体进度推进；
2、12345项目包2质疑函初拟回应文件；
3、支撑数智发改项目网络策略开通梳理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：中烟工互平台项目：召开项目周例会，汇报项目进展，为三家卷烟厂开展工互平台建模工具使用培训。
下午：编辑下周中烟工互项目领导培训材料；沟通下周一建设方案沟通会；第三小组工作量；召开项目组例会；
本周各类工作时间占比：客户交流沟通与内外部协调50%、编写文档20%、风险管理与计划控制20%，公司内部专项工作10%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='茆胜华'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：修改，调优招投标资质匹配系统，进行打包
下午：1.调试灵犀晓伴适配招投标资质匹配系统
2.编制在岗技术革新成果申报书
3.月度项目支撑填报表督促整理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：江苏省港口集团电子招标采购平台，电子CA续期，递交材料，完成证书以及签章续期。
下午：1、江苏省港口集团有限公司业务网络专线集中采购项目-业务专线标段，整理商务资质，编写投标文件大纲。2、江苏省港口集团有限公司业务网络专线集中采购项目-视频专线标段，整理商务资质，编写投标文件大纲。3、协助战客找高速公路机电系统施工项目相关案例','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午:
1.查看高价值一直失败的任务，查看对应归集任务报错信息，并反馈给治理团队；
2.对部分归集数据、标准数据正常，但异议数据错误的任务，进行重新跑任务，重新统计数据。
下午:
1.查询老干部局数据表结构，并创建对应的列分析任务；
2.查看表数据，并结合列分析功能，梳理治理规则；
3.查看关爱帮扶相关数据表数据没有及时更新原因，并重新跑治理任务，确保数据正常。
本周各类工作时长占比:编写文档15%，系统实施80%,内外部协调5%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：镇江市普通国省道路网监测项目支撑；宜兴普通国省道路网监测项目支撑
下午：腾龙大道智慧快速路项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：麒麟超期方案反馈；标准ICT视频监控场景方案编写
下午：标准ICT通信连接、运维服务场景方案编写','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：梳理麒麟平台中录入的制造业生态，收集生态在对应国民经济小类中的解决方案以及典型案例，补充到小类覆盖情况表中。
下午：编制人工智能AI综合监测平台服务项目精品案例；麒麟平台制造行业场景方案审核。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.参加项目晨会，对齐一体化门户/移动端APP当前进展；
2.收集整理科创子系统周报
下午：
1.参加售中组周例会
2.核实门户、党建模块周报内容
本周各类工作时间占比：客户交流沟通与内外部协调50%、网络测试30%、材料编写20%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','12345民生智慧听项目：校对标书初稿、审核演示视频并提出标书及视频修改意见，预计周一再次与战客校对标书
两平台项目：
今日完成全面性规则、准确性规则全量配置，完善规则校验逻辑、表单关联、阈值参数等配套配置，至此及时性、覆盖面、全面性、准确性、数据清洗相关规则配置全部落地完成。
内外部协调：50%
编写文档：40%
风险管理与计划控制：10%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午:企业级知识库架构设计研究，架构探讨。
下午:rag汇报ppt编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、编写疾控省统筹平台（二期）项目包一向周局长的汇报材料和给舒总的项目周报。
本周对接疾控省统筹平台（二期）和省妇幼智慧产房2个项目，开会时间占比30%，客户交流沟通与内外部协调30%，编写文档40%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：
1、参加售中组周例会；
2、编写《小程序注册和备案》分享材料。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午
1、绩效系统试运行情况沟通
2、省数据局系统清理专项工作，材料审核及上传
3、集成平台下午软测准备工作
下午
1、集成平台软测
2、数据中心可视化大屏会议
3、省局业务处室及直属单位数据需求沟通
4、玄武平台纳管，新增监听端口工作进展跟进
5、月度工作量收集汇总','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','客户交流沟通与内外部协调50%
编写文档30%
系统部署与故障分析10%
风险管理与计划控制10%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、和大数据中心安全团队人员沟通即时通信新增端口的漏扫报告进展，配合做好网络策略的开通与梳理。
海事局项目：
1、梳理海事局搜救中心项目的开发完成情况和下周的进度计划，并且向客户汇报目前的开发进展以及存在的风险点。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、整理组件超市的项目的验收材料，配合监理单位核对验收材料的修改项是否已经修改以及材料的格式是否正确。
3、和自然资源厅系统技术人员沟通OCR组件接口的对接事项，提供对方测试系统接口地址以及整理接口文档。
4、熟悉组件超市的密评方案的材料。
本周工作时间占比统计：
客户交流与内外部协调：20%（对接大数据中心客户，对客户反馈系统问题进行梳理确认并且协调外部人员跟进处理）
项目内部系统对接：40% （负责组件超市组件迁移专项任务，解决省市单位范围内系统组件迁移对接过程的问题点；跟进海事局项目的开发进度并且给客户汇报本周开发内容和项目整体进度）
系统问题处理：20%（组件超市系统问题点进度跟进和质量把控）
编写文档：10%（整理组件超市的维护手册、试运行方案、密评方案）
系统维护：10%（配合等保技术人员检查各服务系统的安全漏洞以及日志审计的问题整改）','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：梳理行业项目售前方案
全天：收集整理组内7月工作量','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、根据省数字办要求，评估检查院互联网侦查系统的安全风险。2、收集整理沿海集团验收资料，打包交付给客户经理。
下午：1、沟通中石油站点最新变化信息，与客户经理进行确认。
本周各类工作占比：客户交流沟通与内外部协调50%、编写文档30%、公司内部专项工作20%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：收集整理本周行业支撑周报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、“数字人大”XC改造项目AI复刻厂家南京大数据集团材料准备沟通
2、连云港市大数据管理中心信创迁移项目现状摸排方案沟通
下午：江苏“12345”热线服务标书商务部分交叉审核','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1.指导地市更新APP的首页常用应用
2.核对档案系统的未整理接收库的会议文件
下午：1.下周常委会，核对检查常委会的分组人员信息
2.协调泛微解决OA的功能表单里面流程节点字段显示不正确问题
3.根据客户需求优化季度考核表单
本周各类工作时间占比：系统维护20%，客户交流沟通与内外部协调30%，​故障分析处理30%，风险管理与计划控制20%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-24'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 整理子系统周报。
3. 梳理会务管理、领导日程、通知公告、值班管理等模块需求调研内容。
4. 核查客户汇报会中提出的问题的整改情况。
5. 电子签章对接综合办公测试环境调试。

本周工作时长占比：客户交流沟通与内外部协调40%，系统部署与故障分析30%，编写文档20%，风险管理与计划控制10%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','常熟资规重要湿地生物多样性项目支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：工业专班会议','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-24'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：麒麟平台公安精品案例更新及场景方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='黄思华'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-24',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-24'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.参加环保项目早会；
2.修改工作量填报表，跟进组员填写情况；
3.参加发改API网关网络策略沟通会，明确各网络策略如何申请；
4.收集环保项目周报；
下午：
1.输出环保人力项目周报；
2.更新环保人力项目子公司沟通次数和沟通时间表；
3.确认环保人力项目子公司实施进度是否已按客户要求进行整改；
4.输出环保一体化周报；
5.汇总第一小组工作量。
本周各类工作占比：客户交流沟通与内外部协调30%、编写文档（发改生产环境服务器缩减方案、环保一体化周报）30%、发改项目专项工作15%，环保项目专项工作20%，公司内部专项工作（跟进、检查、汇总工作量）5%。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1 宿迁妇幼保健院全院信息化升级方案支撑
2 盐城大丰医疗机构随访机器人生态选型','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','参加光华杯总决赛医疗参赛项目方案路演与汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：无锡惠山大数据XC改造项目：寻找信创改造项目案例和建设方案','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','下午：麒麟平台历史方案更新；信创实验室采购流程材料准备','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：参加中烟工业互联网行业工互对接会议。
下午：支撑整理医药、装备行业的AI相关案例','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：1、梳理并汇报领导中烟工互项目报奖赛事以及后续计划。2、梳理制造业生态梳理，完成剩余6条。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、编制7月数智化专项工作汇报材料；下午：1、审核售中软集工作周报，筛选不完整项目信息项，并补充自己负责项目相关缺漏字段；2、对1-6连云港工作量核减结果进行复核','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源敲门行动项目组例会；省林业局目录核对更新、新增文件资源挂接；
下午：一本账系统问题核查处理；医保局云网对应关系核对关联；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统、合同系统功能全量测试；
3. 整理商机、采购、合同系统全流程；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1、编写麒麟平台方案（全天）
2、整合组内AI方向考证计划（下午）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘月'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、核对工委江苏机关党建云党费缴纳数据，解决党员新系统和旧系统重复缴纳问题。
2、按照工委领导要求，给参加培训的单位负责人打电话确认新系统中党组织人员数据修改情况，为最后一轮数据迁移做准备。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全省每日签约数据汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、输出2026高使用价值归集情况月报；
下午：
1、对接教育部老师核对教师资格数据同步情况，并进行测试数据数据项比对；
2、支撑处室对接国办平台，协助完成数据需求填报工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：连云港医共体项目：依据客户需求，支撑针对性解决方案编制；数据要素大赛材料依据建议进行调整更新；下午：现场参加光华杯大赛；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘立军'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏脑机接口研究院实验室综合智控平台项目：沟通软件厂家确认服务器参数配置，并根据配置进行设备选型，完成报价
2、江苏省卫生健康委员无线覆盖项目，根据邀请函，编制应答函
3、江苏省人民医院智算服务项目：编制调研报告','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：盐城市人民医院导诊机器人项目预算报价及产品方案对接。
下午：江苏省茅台酒业智能化项目前向开票。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：麒麟汇报医疗行业专项材料编制，医疗行业政策洞察新增。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源数据治理项目支撑。
上午：1、归集-治理-异议数据闭环方案讨论；2、人法信-统一数据运营对接，提供标准表唯一标识用作溯源需求沟通和脚本开发；3、人法信所需标准表治理情况跟进；4、数据治理用户手册材料调整；
下午：1、南京、徐州、宿迁、苏州、盐城地市一表通数据未同步问题跟进；2、常州、无锡、镇江一表通人员基本信息数据治理；3、异议数据处理流程设计；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：党政生态可用性定期维护在线文档政务等子领域生态维护；政府网站与新媒体传播影响力平台解决方案配套材料修改
下午：麒麟平台方案党政超期资源更新计划方案政务等子领域方案更新；党政生态可用性定期维护在线文档政务等子领域生态维护','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='吴承云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴承云') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：
1.跟进上周五提交的政务外网出访策略审批进度，并按政务云工程师建议提交NAT申请；
2.与徐博文、胡蕾蕾讨论初步了解DICT系统，明确国泰项目暂未流转到售中；
下午：
1.跟进摩卡完成服务访问策略表，同步更新切换租赁云接口策略表；
2.确定数智发改一期第一批生产环境可释放资源清单，更新服务器台账与干系人表；
3.向信息处反馈数智发改一期测试环境服务器置换情况；
4.梳理省商务厅国产化改造实施内容与要点，完善项目基线资料。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：GA情指行材料针对措辞、逻辑内容进行沟通优化
下午：国产化改造案例建设内容逐个核对确认','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：日报内容数据分析；
月报审核系统开发计划实施；
下午：月报审核系统审核规则编写；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、南京新工数科交流需求对接
2、宇特纺织项目需求对接及方案讨论，近期现场交流
3、工业AI典型场景项目梳理，沟通省政企、战客具体要求
4、工业生态运营及麒麟支撑情况梳理，准备集团汇报材料','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','专利大课题内容梳理，代理要求沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='周俊凤'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-TEST-10'),'project-support','bid-quotation','owner','全天：江苏省高校招生就业指导服务中心招考工作技术服务类项目包2，项目报名，搭建投标文件框架，编制投标文件。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：面向突发事件的5G-A预警应急通信和指挥调度处置应用项目省应急厅无人机及应急通信相关素材整理
下午：DI部大禹平台技术对接、消防项目嵌入卡位可行性评估；面向突发事件的5G-A预警应急通信和指挥调度处置应用“绽放杯”路演PPT内容编制','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：无锡惠山大数据 XC 改造项目: 搜寻整理其他地市纯软件迁移，低预算项目材料
下午：东航 CVR 项目支持：1.与客户重新确认语音标注完成时间 2.组织语音标注同步会议','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：麒麟平台历史方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏省数据局12345三期项目投标支撑；
2、江苏省人大数字人大信创改造升级项目支撑；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、灵犀晓伴投标专家Skill工具建设；
2、合同管理系统超期用印处理；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：1、战客7月工作量收集工作，进一步核查修改，核实补全项目编号；
2、麒麟平台行业解决方案专题建设汇报材料整理修改；
3、麒麟平台政研工单审核；
4、软集周报未更新项筛选梳理。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 准备初验材料：合并用户手册并调整格式（268页）
下午：
1. 准备初验材料：合并用户手册并调整格式（264页）
2. 对接淮安数据局、省市监局、政协一体化组件迁移工作
3. 联络司法厅戒毒局、省检察院、水利厅、机关事务局上传专项清理说明材料
4. 整理省药监局下线目录老平台的数据项数量','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、参加数据归集每日例会，梳理当日工作安排，同步各单位数据归集与整改推进情况；
2、整理公共数据平台迁移方案文档格式，补充完善部分缺失内容；
3、跟进团省委数据归集进度，了解当前推进状态及存在问题。
下午：
1、继续协助省人社厅整改一本账系统数据质量核查问题；
2、核查人社厅相关目录整改进度，更新问题台账；
3、同步更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：
1、临床研究患者精细化数据采集系统项目，汇总每周工作周报，沟通项目实时进度；
2、残疾人康复中心配套设施采购项目，汇总每周工作周报，跟踪项目进展及协调事项。
下午：
1、省统筹平台（一期）项目卫生资源和应急值守系统，沟通优化功能完成进度计划表和后续新增开发内容；
2、省统筹平台（二期）项目症候群系统和舆情监测系统本周功能评审并验证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：编写上报行业支撑一部8月份资金计划 、填写工作量               下午：做省公司政企部2026年ICT省级项目派驻支撑（第一批）收入和成本计提报账单、处理部门内部报账问题、处理OA系统报账代办','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：《关于“人工智能＋交通运输”的实施意见》政策解读；《江苏省“人工智能＋交通运输”实施方案》政策解读；江苏省“人工智能+交通运输”洞察报告编写
下午：《“人工智能+交通运输”典型应用场景创新行动方案》政策解读；江苏省“人工智能+交通运输”洞察报告编写','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','25-130后向合同附录借阅；25-097后向合同用印、合同附录审批流程。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','组内工作量汇总，审核；连云港初核工作量核实，通知反馈','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、统计上周中小企业平台跳转流量；
2、对接南京公司推广事宜；
3、对接苏州公司推广事宜；
4、协调行业三部、南京公司商议南钢项目，讨论职责分工及本周工作内容，包括请南京公司确认用户具体需求，行业二部负责整体方案和内容梳理，行业三部负责梳理炉前炉后各项工艺流程及支持后向厂商；
5、配合市场部准备“工业互联网生态体系研讨”会议相关材料。
下午：
1、','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','淮安JCB-2026-064项目投标支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：商业top行业生态梳理，商业细分领域划分','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：行业二组七月工作量梳理，上半年连云港工作量核减情况梳理及调整，二组七月资金计划上报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-TEST-03'),'project-support','bid-quotation','owner','上午：1）公安情指行交流材料修改；
2）2026年高管中心智慧化服务区一体化示范提升项目搜集案例和一建项目经理。
下午：1）公安情指行交流；
2）机场公安OA项目泛微交流及核对材料；
3）中烟阿里云项目投标报价讨论及标书审核。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：国泰聊天攻防系统项目DICT系统流程录入；
下午：东航CVR项目数据标注进展跟踪。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、协助研发二部沟通调度宿迁12315供应商；
2、海事综管平台项目补充工作量审核，与战客、摩卡沟通分歧点，约定进一步商谈时间；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、讨论FDE培训和激励方案，编写FDE团队激励标准；
2、售中组7月份报送工作量审核补充；','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：
江苏中烟工业有限责任公司专有云平台三期项目：
1.中烟阿里云项目投标报价沟通讨论审核；
2.投标标书最终编写修改整合，2轮审核后定稿；
3.投标文件盖章签字确认无误，完成电子投标文件上传。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、江苏海事局档案室改造方案与客户讨论优化电梯厅和走廊布局优化；
2、省疾控中心近期商机配合战客中心与客户沟通','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1、CCIA资质与认证机构沟通，优化申报材料；
2、与市场部沟通一点调度工单数据来源并进行分析；
3、麒麟例会材料准备，数据整理，格式优化；
4、麒麟平台下个版本需求收集。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：常州JCB-2026-065项目支撑，常州市委办某项目商机支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：特殊项目七月工作量整合','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：苏政源支撑。核查公共数据平台详细设计整改意见，收集系统部署设计章节内容；
下午：苏政源支撑。与数据治理系统讨论异议数据的全生命周期流程；与统一用户交流推送全量用户数据，并进行接口测试，由于接口不是分页查询，目前存在问题；晚上和客户开会讨论数据治理系统和异议系统如何协同处理异议数据，做到全生命周期可溯源可管理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1，常州妇幼高质量数据集汇报工作支撑,2，宿迁妇幼保健院智慧医院汇报方案调整支撑
下午：1，宿迁妇幼保健院智慧医院方案支撑（预算调整）2，盐城三院机房项目硬件部分询价支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：1.数据直达日报接口数据统计
2.完成公共数据平台运维运营服务工作周报
下午：1.协助省委社工部在苏政源进行数据订阅','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会，与项目组关键成员明确今日项目任务与本周计划。
2.针对在线表格2+6事项继续进行优化，与相关责任人明确时间节点，今日主要进行鉴权功能和日志功能的调试。
3.与慧诺讨论摸底情况，并梳理接下来计划。
4.配合3支队陈支队长完成信息安全保密培训和承诺书签署确认。
5.推动DI尽快指派测试人员到现场进行演示版本测试工作。
6.处理华为GLM5.1大模型不可用问题，已解决。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、上午跟进检察院项目进展，包括通知战客周五参加法务部会议并提前沟通口径、医保局实体用户信息查询、安排周五启明入场安全测试、驻场人员工作交接。
2、上午推进江苏中烟项目，考虑到南京徐州卷烟厂生产放假，安排继续与徐州支撑单位远山进行对接，同时联系客户经理安排下周与南京卷烟厂对接，了解工互对接真实的困难。
3、上午推动解决GA数据湖运维项目风险，推动战客协调烽火支撑人员。
4、上午按要求，再次与李鑫梳理对齐GA苏小智项目前期项目情况和前期沟通纪要，制定本周相关工作应对方案；同时推动DI部提供本期演示功能BS版本交付周期和报价。
5、下午针对慧诺上周收集的项目参数，参加讨论会议，对BS版新平台的业务逻辑设计和对接进行讨论','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、下午整理1-6月分公司支撑工作量，对比1-6月地市收入，形成未结算少结算地市清单','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.整理脚本跑出数据，形成周报相关所需数据
2.准备电子证照7月份高价值数据，整理成电子证照质量清单
下午：
1.撰写省级部门质量报告月报
2.整理供需关系报表
3.撰写公共数据平台数据治理周报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：组织开展德世伟业 ZFW 项目专项交流，与相关方沟通项目推进现状、需求要点及后续实施计划。同步梳理交流过程中的待确认事项，记录各方意见，明确后续对接节点，为项目稳步推进夯实基础。                                                                                  下午：开展省高院指挥中心智能化项目汇报材料修改与审议工作，仔细梳理材料内容，核查项目相关表述、方案细节，优化行文逻辑。同步对接相关同事沟通调整意见，完善文稿内容，保障汇报材料严谨规范，满足汇报使用要求。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：徐州分公司某HZ小区智能化建设受托代销合作协议、2026年徐州市某医药产业园机房综合备电服务项目受托代销合作协议、徐州分公司新沂某厂区监控覆盖ICT项目、徐州分公司新沂某单位实验室配备ICT项目合同（包2）合同处理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：外部专家省战客2026年7月工作量汇总','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：巡检人大新闻模块。根据监理审核验收材料意见，与监理沟通并整改医保反欺诈项目验收材料。
下午：协助处理人大项目代表学堂视频上传相关工作。医保基金反欺诈项目模型线索汇总检查，补充缺漏线索后发给总集。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='毕爱梓'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：南航天目湖校区实验中心项目支撑，对接地市了解项目需求，链接2家合作生态评估技术方案。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','下午：麒麟平台历史方案更新；苏州内部合同流程、用印支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：1、与主任沟通，修改调整地质一队网站错误信息；2、根据软件测试功能性问题报告，对系统功能进行补充完善
下午：1、根据上午沟通问题，协调厂家对部分doc文件上传异常问题修复；2、跟华建公司综合部人员沟通，对排序问题进行调整；3、跟常州工勘院综合部沟通，对人事类流程调整完善','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：办公室相关需求确认问题梳理；人力与门户数据不一致问题讨论方案；人力需组织部协调为整理；
下午：财务与合同字段对接讨论会；以监测公司员工测试全流程测试商机、项目、合同、采购，定位采购结果缺失项目id问题，推动厂家修改；整理数据中台已汇聚的数据情况。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','智慧印章系统：整理地市公司印章台账','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：支撑南钢炉前气体监测项目：1）对接行业三部，明确任务分工；2）对接南京公司，协调确认客户具体需求。
下午：编写钢铁行业除尘风机能耗优化产品介绍材料。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：梳理工业制造AI项目自有能力及生态能力，为政企汇报材料提供依据。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','老干部局数据迁移项目环境部署协调沟通
机关工委宣传设计工作量沟通','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1、日常服务器巡检，运维服务器磁盘清理；
2、更新预算联网授权，督促政务云提供普元中间件授权；
下午：
1、演示文件推送功能并给客户解答相关疑问；
2、处理代表学堂视频推送事宜。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','民政条线细分领域解决方案需求规划','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目专项对接，标准化场景梳理、典型配置更新
2、党政行业一点调度工单处理
3、市场部推荐场景生态清单评估梳理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','bid-quotation','owner','1、商务厅网络安全设备项目，沟通不同后向厂家，核对设备参数。
2、江苏省公共资源交易中心运维项目了解后向厂家，跟客户经理交流投标策略。
3、江苏省地方志修志编撰大模型项目，了解项目情况、客户需求、后向厂家等各项情况。
4、地质局无纸化项目进展跟进，与厂家约定客户处了解项目具体情况。
5、梳理江苏电信交易监管系统开发服务采购项目的招标文件。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、徐州公司AI智慧教育拓展能力咨询支撑
2、苏州西交利物浦大学太仓校区专项设施采购项目支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、苏州内部合同提交补充协议承接人变更沟通
2、7月工作量梳理填报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、参加数据归集日例会，针对部门新归集的数据中无主键、归集方式为全量定时同步需修改为增量实时同步等确认整改方案和整改方式；
2、支撑统计局协调云网解决如下2个问题：1）部门接收库云资源申请及数据库部署；2）接收库与苏政源开通网络策略（接收库开通入访策略，苏政源开通出访策略；
下午：协调解决教育部通过国办平台和苏政源平台将教室资格认证相关数据通过回流至教育厅，当前网络已调测完成，正在进行 数据对账，确保数据准确、完整无缺失的回流至教育厅。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、对接淮安公司新闻采集需求，上周淮安客户经理反馈淮安市政府有新闻采集需求，今天对接资源，不过中午淮安公司客户经理反馈，暂不需要对接。
2、人社厅数据体系规划设计项目：进一步完善规划材料（PPT），目前请生态专家再次对材料进行审核优化','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','重庆出差
腾龙大道项目人员驻场问题对接','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','重庆出差
标准ICT与政企部对接沟通','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午:招商银行南京分行IT开发服务项目，对接泰州移动同事商讨共同参加投标决策，参与报价市场行情商讨，增加两个评分业绩与三名服务人员材料，定稿打印；
下午:招商银行南京分行IT开发服务项目，盖章封装；农商行防火墙采购项目，招标文件购买以及初步分析','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','bid-quotation','owner','1、完善江苏省消防救援总队 2026-2027 年度信息化及卫星通信网运维服务项目需求方案，梳理明确项目概况与服务范围、信息化硬件维保清单、安全服务内容、商务条款及评标标准；
2、编制江苏省商务厅网络安全设备与 LED 屏采购项目投标文件，逐项核查深信服、奇安信相关技术参数证明材料，反馈修改优化意见；对接天融信、深网科技核实确认设备参数响应符合性；
3、修改完善 2025-2026 年度信息化运维服务合同补充协议。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天：
1、支撑淮安行政审批局、省市监局、政协一体化、太仓市一网通、省卫健委组件迁移对接工作；
2、排查淮安行政审批局数字签名请求异常问题，与客户对接调试，已完成请求异常根因分析，待客户验证问题解决情况；
3、完成组件超市门户联机帮助文档修订初稿，待人工审核后发布。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、淮安公司特殊项目导入导出等现场支撑
2、淮安公司某特殊项目相关人员约谈事项材料编写。
3、盐城公司融合创新方案材料需求支撑。
4、徐州公司融合创新拓展咨询支撑。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','7月工作量整理填写及反馈。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、协调客户经理、后向厂家烽火派人处理公安厅业务；
2、同客户沟通项目问题情况、质态评估事宜、烽火不管的状况；
3、数据湖项目运维周报采集整理；
下午：
1、烽火人员到场协调，跟随学习如何处理任务失败等问题；
2、向客户汇报数据湖平台 异常处理结果，客户认可当前结果；
3、同芯瑶人员、李毅杰沟通sm项目后向付款事宜；
4、同烽火、方软沟通了解数据湖项目人员根主题库情况。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目场景封装支撑
2、连云港公司支撑工作量审核协调沟通
3、淮安某项目约谈协调','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、连云港展会项目技术方案及案例支撑
2、公安重点AI项目梳理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','盐城转研发项目二次评标','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、12345标书进度推进，技术部分审核','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、数据要素X 材料优化','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：与阿里、中烟客户联合沟通建设方案编写标准；与阿里、客户沟通数据资产模型属性编辑、点位计算等功能；
下午：与阿里技术老师沟通数据传输链路；整理第三次周例会会议纪要；整理建设方案编写准则。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1. 跟进应急厅应急指挥网及机房维保专项（中邮建实施部分）。持续跟进项目需求推进进度，对接相关方梳理、汇总、整理项目方案内容，同步落实方案待完善事项。
2. 推进人社厅开机广告项目工作，针对月度广告内容切换事宜开展多方沟通，确认相关要求、时间节点与对接事项，保障广告内容按时顺利切换。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：1.编制、修改在岗技术革新成果申报书
2.月度项目支撑填报表填报与统计
下午：1.麒麟平台行业案例修改更新
2.灵犀晓伴平台SKLII技能整理、开发
3.工作量统计与分析系统开发调试
4.1-6月连云港项目支撑工作量核减确认','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：2026年高管中心智慧化服务区一体化示范提升项目，项目投标报名，搜集招标要求案例，完成招标文件分析
下午：江苏省港口集团有限公司业务网络专线集中采购项目投标文件技术方案编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:
1.反馈表离线采集一直失败问题，并协助治理团队定位问题原因；
2.查看省委老干部局最新归集进度，更新在线表格并梳理所有目录治理规则。
下午：
1.规则处理，把梳理好的治理规则转换成可执行的SQL表达式或正则表达式；
2.在平台上治理目录，并更新对应数据统计信息。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：腾龙大道智慧快速路工程AI+建设管理场景服务项目支撑；
下午：宜兴普通国省道路网监测项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：麒麟行业方案优化；
下午：标准ICT项目清单编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：制造业生态联系人、公司介绍、对应行业解决方案、典型案例搜集整理。
下午：与苏州浙远自动化和冠骋信息沟通生态交流相关事宜；优化人工智能AI综合监测平台精品案例；慧投寻找装备、化工、制药AI相关案例，支撑客户交流。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.参加环保项目例会，跟进门户PC端、移动端bug处理 功能优化等问题进展
下午：
1.一体化门户及移动端各系统功能测试
2.沟通人大项目共享数据填报情况','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','12345民生智慧听项目：完善完成标书技术部分，商务部分及整体内容验证
两平台项目：
完成全面性规则、准确性规则全量配置，完善规则校验逻辑、表单关联、阈值参数等配套配置，至此及时性、覆盖面、全面性、准确性、数据清洗相关规则配置全部落地完成。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='钱程'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1、编写疾控省统筹平台“六优项目”申报材料；
下午：
1、补充重大和重点传染病管理系统（血防所）、症候群监测系统和跨地区信息协查系统各一个功能模块的变更内容。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：继续编写《小程序注册和备案》分享材料，并发戴总审核中。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午
1、协同集成平台软件开发商，就上云计划进行排期讨论；
2、玄武平台纳管，网络策略工单沟通与指导；
3、系统清理专项工作，复核结果交流。
下午
1、器械备案许可数据偏差原因，编写第五稿书面汇报材料；
2、数据中心试运行材料编写','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、处理常熟地市的网络策略的问题，分析组件超市snat地址到对端地址telnet不通的主要原因。
3、与一本帐系统人员沟通对接苏小慧智能体识别问答组件超市操作手册的内容。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、收集视频会议、wps组件以及短信服务组件的近半年的监控数据，提报给组件超市更新到组件成效页面上。
3、协助申士定位淮安市行政审批局的系统调用组件超市的数字签名接口的问题。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：组内7月工作量收集整理，数据审核；收集组内7月绩效数据','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：1、跟进检察院项目进展，医保局实体用户信息查询、安排周五启明入场安全测试、驻场人员工作交接。
2、中石油站点项目进展跟进
下午：1、与客户沟通检察院接口测试进展，沟通安全测试风险功能点。2、跟进高投验收客户反馈进展','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','“数字人大”XC改造项目AI复刻厂家南京大数据集团SM材料审核，报价调整，问卷网XC改造问题沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1.根据客户需求调整处长会议权限
2.指导客户进行文件推送给常委，以及公文交换给市区县
下午：1.根据客户需求调整文件推送流程
2.解决数字人大档案批量导出解压缩乱码问题
3.指导批量导入档案报错问题
4.档案批量导出文件没有六格章，已协调厂家去处理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-27'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','全天支撑环保集团项目。
1. 对齐综合办公、三重一大、生产企业管理系统、AI中台建设进度。
2. 盘点未完成工作任务，与开发沟通本周工作目标。
3. 排查生产企业管理系统用户登录无操作权限的问题，原因是门户统一推送用户数据更新导致错误。
4. 根据客户要求，梳理系统建设亮点、测试及缺陷修复情况。
5. 更新专班近期事项跟踪表。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','下午：省委社工部项目支撑，对接客户，梳理补充需求','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：麒麟生态伙伴可用性表格维护','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：公安精品案例更新','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：招商局重工海门基地申报材料评审','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='黄思华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-27'),'morning',(select id from projects where code='JUL-TEST-04'),'project-support','solution-design','owner','上午:
省人医算力服务器项目支撑；
协助整理麒麟汇报材料
下午:
省疾控AI项目汇报材料支撑，调度DI和研二预计周四汇报；
军总运维项目技术方案支撑。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-27',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-27'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.参加环保项目周会，跟进人力系统与门户对接进度和问题及人力系统兼职、参加工作时间等需与组织部确认事项等；
2.与省招就中心就业指导处客户沟通确认大学生职业规划大赛项目验收事宜；
3.配合发改申请API网关相关网略策略；
下午及晚上：
1.汇总输出发改项目周报，跟进上周服务器缩减进度及本周计划；
2.协调厂家对流程平台cce开始缩减；
3.整理输出发改生产环境第一批关停服务器清单；
4.测试环保商机及投资系统部分流程。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1 连云港特殊场景健康小屋需求对接与方案寻源
2 苏州港航无人机项目投标宣讲方案准备','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：地市信创集采项目进度更新','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：信创生态添加和场景方案上架；下午：历史场景方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：梳理江苏中烟工业互联网项目与行业平台之间的接口对接，数据交互规范及现阶段网络配置基础。
下午：支撑安赛乐米塔尔园区智能化项目关于千万级包含综合布线、网络、视频监控、门禁系统案例，发送常州新北时健。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','梳理制造业生态梳理，完成剩余7条。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：对接各组接口人，复核1-6月连云港工作量核减情况并反馈给市场部；下午：1.汇总整理全部门7月工作量，进行数据分析并审核，通知各接口人进行按要求规范修改；2.数智化工作汇报支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：苏政源敲门行动项目组例会；监狱管理局、省林业局系统部署位置修改；省文旅厅云资源管理系统分配；支撑省林业局数据库苏政源权限开通。
下午：一本账系统问题核查处理；戒毒所、司法厅、省工信厅、市场监督管理局云网对应关系核对关联；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统、合同系统功能全量测试；
3. 整理商机、采购、合同系统全流程；
4. 跟踪对接采购系统、法规系统问题解决进度。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','参加周例会，向沈主任汇报系统测试进展','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、编写AI会议室解决方案，输出初稿（全天）
2、编写党政行业产品介绍文件，引入行业紧密生态厂家及优势产品（AI会议室、灵犀·星火智盒）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、江苏省交通技师学院具身智能机器人实训基地设备采购项目，售前规划环节，联系镇江崔泉推荐生态及解决方案
2、中国矿大人工智能学院教学实验平台，联系徐州杨键，沟通项目具体需求及进展
下午：
1、工业纺织行业生态拓展，完成3家。
2、教育行业上报紧密生态优势产品，与希沃、飞象星球、安徽一视进行沟通。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、按照工委领导要求，给参加培训的单位负责人打电话确认新系统中党组织人员数据修改情况，为最后一轮数据迁移做准备。
2、处理江苏党建云各个单位负责人打电话过来反馈的问题','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全省每日签约数据汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','调休一天','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：整理医疗产品资料；现场参加光华杯比赛；下午：现场参加光华杯比赛；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、JCB-2026-009请购','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、地市违规行为评估及处置
2、SM业务7月支撑工作量审定
3、保密项目管理系统呈批内容汇报沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏省卫生健康委员无线覆盖项目，根据邀请函，编制应答函，确认最终报价，盖章响应。
2、南京医科大学附属口腔医院数据中心交换机项目，跟进项目招标流程，配合客户确认最终招标需求。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','整理编制医疗卫生行业互联网专线方案，包含带宽扩容、多院区与云业务接入平滑拓展的互联网出口承载体系，满足互联网医院、远程诊疗等业务长期发展等内容。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：紧急救援基地无人机招标部分产品参数收集整理，常州妇幼高质量数据集汇报工作协同材料及生态支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：如东县第四人民医院精品案例编制，智慧医院生态交流及引入','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源数据治理项目支撑。
上午：1、排查无锡一表通人员数据推送失败问题；2、处理徐州盐城一表通人员数据目录和库表资源信息未同步问题；3、完成徐州、盐城、宿迁一表通人员数据治理；4、基础库统一数据运营对接支撑，新增贴源表、标准表唯一标识并推送基础库；
下午：1、修正模型设计规范；2、修正数据全流程处理实施方案；3、处理广电局-广播电视节目制作经营单位设立审批信息目录信息不一致问题；4、异议对接，明确接口对接推送字段取值；5、沟通部分历史数据归档不治理事项；6、处理人社社保信息加解密事项；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：党政生态可用性定期维护在线文档政务等子领域生态维护；省政务云租赁服务项目精品案例资料搜集和内容编制
下午：麒麟平台方案党政超期资源更新计划方案政务等子领域方案更新；党政生态可用性定期维护在线文档政务等子领域生态维护及整体统筹','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='吴承云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴承云') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.参加数智发改一期周二项目例会，汇报政务云资源第一批可释放服务器名单，同步服务器缩容与网关迁移进展；
2.对接下游交付公司金茂，跟进省商务厅国产化改造项目进度以及项目管理计划定版；
下午：
1.围绕数智发改一期摩卡缩容迁移，咨询政务云平台并申请负载均衡策略更新；
2.更新数智发改一期服务器台账；
3.更新网络策略FAQ，沉淀网络策略口径与经验。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：情指行项目依据客户需求，编制清单并对接中移集成补充案例涉及的厂家信息；
下午：GA领域国产化改造涉及信息化及厂家搜集梳理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：月报审核系统开发及审核规则调试；
下午：AI数智化汇报材料编写；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、集团公司工业生态体系建设会议。
2、宿迁宇特纺织、泰州兴达钢帘线项目开发对接，准备现场交流。
3、丰县电动三轮车产业园产业信息化升级及质检需求对接，沟通生态。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','视频专利（被退）修订素材收集。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='周俊凤'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-TEST-06'),'project-support','bid-quotation','owner','上午：江苏省医保五期项目，后向采购沟通。
下午：江苏省高校招生就业指导服务中心招考工作技术服务类项目包2，编制投标文件。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-TEST-07'),'project-support','solution-design','owner','上午：省消防救援总队智能指挥系统项目支撑：关于加强项目集成管理增项建设措施预研
下午：省消防救援总队智能指挥系统项目支撑：基础平台融合建设与全域集成管控方案编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：东航CVR项目支撑：语音平台标注工具学习
下午：东航CVR项目支撑：每日语音标注进展同步','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：历史场景方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、省人大数字人大信创改造升级汇报；
2、省数据12345三期项目标书评审；
3、常州钟楼区数据据数据要素汇报支撑；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、AI 资质对应系统建构沟通；','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：1、战客7月工作量收集核对工作
2、对麒麟平台内超期未更新资源重新整理汇总
3、更新一点调度行业洞察PPT内容
4、麒麟平台政研工单审核；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 联系省水利厅、司法厅、林业局、监狱管理局、机关事务局进行部署位置修改
3. 调整初验材料《详细设计说明书》格式
下午：
1. 调整初验材料《用户手册》格式（400页）
2. 协助省市监局登记云网系统','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源-敲门行动
上午：
1、参加数据归集每日例会，梳理当日工作安排，确定部门业务数据库权限开通操作方案；
2、对接国资委，协助修改其MySQL库用户权限开通配置；
3、协助省科学技术厅完成系统变更及系统部署位置调整；
4、核对南京海事法院本地数据目录情况。
下午：
1、协助省文旅厅完成系统变更及系统部署位置调整；
2、对接文旅厅，协助修改其业务从库对应用户权限；
3、协助文旅厅完成云资源分配工作；
4、完成公共数据平台需求规格说明书合并工作；
5、协助民政厅完成接口资源下线工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、和省疾控信息所及业务办领导现场会议，汇报卫生资源和应急值守系统整体完成进度和后续增补开发计划；
下午：
1、省统筹平台（一期）项目卫生资源和应急值守系统运维群用户使用问题答疑解决；
2、省统筹平台（二期）项目跨地区协查系统和隔离点系统本周功能评审并验证；
3、医疗大数据清洗项目，沟通协调厂商人员客户现场病历数据批量导入服务器。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：淮安分公司-生态公园灭蚊项目、涟水新型建材公司机器人服务项目、涟水新型建材公司设备升级服务项目用印支撑','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：调整编制7月实习生工作量、调整部门内部资金计划，做员工日常费用报账单报销孙总交流往返车费','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午《江苏省“人工智能+交通运输”实施方案》路演会解读；江苏省“人工智能+交通运输”产业联盟解析；
下午：《江苏省“人工智能+交通运输”实施方案》洞察PPT编写完成；宿迁港航项目中标结果、反质疑事宜处理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','7月组内工作量审核、退回责任人修改、再审核，工作量情况说明审核；7月组内人员工作量各维度数据表格更新；1-7月组内已审核工作量，核减工作量表格更新；2026特殊项目台账更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、参加“工业互联网生态体系研讨”会议；
下午：
1、审核苏州商贸项目相关方案（园区分公司与苏州苏大教育服务投资发展有限公司苏大智教湾E座智慧楼宇项目）；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','淮安JCB-2026-064项目投标支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：保密项目管理系统新增bug沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：行业代理厂家梳理确定，对接相关代理要求；
下午：行业二组七月工作量收集整理及不达标原因分析，中通服付款材料对接及生态盖章','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午1）机场OA项目投标文件修改，和致远、泛微等沟通价格；
下午1）机场OA项目审核定稿，到宁丹路打印、盖章、签字和封装。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1，药监政务应用程序整合清理工作研讨会议；2，和讯飞研讨数据标注平台相关技术问题；下午：部门例会。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、制定HW行动安全检查要点并宣贯；
2、数字人大项目前向收款开票支撑，了解借阅合同与制作合同附录规范，目前前向合同前期汪莹莹借阅未归还，待继续找寻。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、与综合部讨论解决方案条线强军计划执行方案；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午:1.江苏中烟工业有限责任公司专有云平台三期项目：项目投标现场开标。
下午:1.江苏中烟工业有限责任公司2026年总部计算机及相关设备、软件采购项目:系统梳理软硬件证明材料清单，并与合作伙伴沟通确认设备选型，确保技术参数与商务条件全面匹配；复核投标保证金回执金额及有效期，确认无误。启动技术方案编制，重点突出供货保障及售后服务响应，计划近期完成初稿提交内部评审。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、梳理一点调度工单数据，与市场部核实数据来源，完成分析并输出书面报告。
2、参加室内周例会，整理会议纪要。
3、优化数智化例会中一点调度数据分析部分的汇报材料。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：支撑JCB-2025-136项目备案','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：特殊工作量评审
下午：整理1/2部项目支撑明细，为月度计划提供素材','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：苏政源支撑。整理公共数据平台详细设计，补充收集的各家系统部署章节内容；整理异议处理使用的开源组件，打包发给总体组做安全扫描；
 下午：苏政源支撑。整理公共数据平台系统部署方案文档，收集各家缺失的云网资源清单、部署命令、数据库初始化sql等信息；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：常州妇幼高质量数据集汇报工作支撑：1）医渡云汇报时间安排在周四。2）臻鼎汇报时间待定，方案内容还需优化。
下午：宿迁妇幼保健院智慧医院汇报方案支撑：1）预算部分调整，按建设内容划分。2）政策性文件更新，将湖北省的相关材料替换成江苏省的内容','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1.数据直达日报接口数据统计
2.协助省委社工部完成系统专项清理复核
下午：
1.支撑机关事务管理局进行苏政源归集工作，已完成上云方案提交
2.配合处室联络员确认省科技厅目录合并是否符合要求，确认数据项是否全部覆盖，并督促科技厅完成苏政源目录的调整','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会，同步项目今日进度与计划。
2.继续推进在线表格2BUG+6优化事项。
3.三支队陈支要求登记现场人员信息配合其登记工作。
4.继续协调测试人员进场测试人员周四周五到位。
5.与战客中心沟通，尽快确定B/S版本研发方向。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、上午与生态伙伴交流苏小智智能体省市演进推荐方案；
2、下午沟通战客，推动解决数据湖项目运维人员补齐问题，需战客中心加快商务合同落地；
3、下午向省公司法务部反馈检察院检察侦查平台项目移动数据查询实现方案及安全问题。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、下午修改数智化专题会议汇报材料。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.和省红十字会技术人员对接，确认数据库相关事宜
2.根据电子证照7月份高价值数据，整理成电子证照质量清单
下午：
1.撰写省级部门质量报告月报
2.撰写公共数据平台数据治理周报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：推进省高院执行局相关材料梳理汇总工作，逐项核对资料条目，规范内容体例，完善素材归集，保障相关材料有序筹备。
下午：对接省税务局信息处开展交流拜访事宜，梳理交流议题，提前备好沟通要点，围绕业务协同相关内容做好洽谈准备。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：徐州分公司新沂某单位实验室配备ICT项目（包2）、徐州分公司新沂某厂区监控覆盖ICT项目用印','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：外部专家2025年四季度订单用印；
下午：外部专家省政企2026年全年、1-7月地市待摊数据重新统计；外部专家省战客2026年7月工作量汇总','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：巡检人大项目新闻模块内容；整改完成医保反欺诈项目验收材料。
下午：验收申请表回公司盖章并带给医保项目总集；第三批飞检线索梳理，准备报给用户参与下发。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='毕爱梓'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','下午：盐城AI+教育方案交流，提供生态联系方式，对接产品、平台等系统演示','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：行业精品案例梳理，对接地市收集技术方案等；麒麟方案更新。
下午：支撑苏州公司内部合同流程事宜，完成流程发起、内容审核、合同盖章等。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：继续处理局属单位网站外链不良信息处理,与主任电话沟通按要求处理核工业地质队假勤流程调整和矿产地质队所有流程统一优化限制
下午:协调处理地质一队财务流程打印模板调整；协助数科技术人员排查轻阅读文件转换服务偶发服务掉线的问题；按主任要求优先解决移动端无法转发问题','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','参加HW专项行动互联网满屏渠道宣传讨论会.
与综合沟通CAIE培训事宜','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：去省战客，跟肖总、敖总汇报项目目前的困难情况。肖总让我们写一份给吴主任的汇报材料，把各系统建设的情况，部分试用情况描述清楚，现在还有哪些遗留，可在试用期间完善。战客一起约吴主任当面汇报。
下午：梳理一体化项目的亮点功能，以及汇总各子系统测试情况；给沈总汇报项目情况。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','智慧印章系统：协调PaaS平台资源扩容。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：梳理工业制造AI项目自有能力及生态能力，为政企汇报材料提供依据。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','1.各项目宣贯hw行动，维护项目网络安全','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.梳理项目需求证书，编辑激励方案
2.党建、工会对接事宜','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1、日常服务器巡检，运维服务器磁盘清理；
2、处理客户现场用印客户端更新和域名变更；
3、处理客户现场问题若干。
下午：
1、处理预算工委的问卷系统咨询问题；
2、普元中间件更新授权；
3、安排周三常委会巡检工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','党政民政监管地市交流专项材料梳理优化','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、结合末梢采购编写标准ICT项目物联网应用、音视频会议场景典配梳理；
2、党政行业一点调度工单处理；
3、党政行业麒麟相关数据常态化更新框架梳理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','requirements-analysis','owner','1.商务厅网络安全设备项目分析项目风险，反馈至客户经理。
2.地质局无纸化项目，与后向厂家沟通技术能力，待与客户侧确认。
3.江苏电信交易监管系统开发服务采购项目，审核标书商务部分内容，提出修改意见。
4.江苏省安全生产经济政策管理信息系统运维保障项目，沟通项目售后阶段问题。
5.应急厅运维项目两个标包，招标文件审核，已提交至客户侧。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','参加部门例会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、淮安市生态文化旅游区第二实验小学录播教室项目沟通支撑
2、教育行业AI产品沟通梳理
3、盐城AI教育产品演示需求沟通，并推荐生态资源','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、XC培训邮件通知及地市解答。
2、专题会沟通，本周计划上会3个项目，预计周四/五召开。
3、部门周例会。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、参加数据归集日例会，针对部门在数据归集时在归集任务配置中选择的全量定时同步需修改为增量定时同步，后续不再有全量定时同步这种模式，基于不同的数据库类型与平台组确定实施方案，并给联络员宣贯需要联系部门在数据库里面给苏政源增开几个权限；
2、支撑统计局完成接收库的数据源配置；
下午：支撑如下5个部门（江苏省人民政府外事办公室（江苏省人民政府港澳事务办公室，江苏省市场监督管理局，江苏省体育局，江苏省统计局，江苏省政府国有资产监督管理委员会）在项目管理平台上完成部门云资源部署位置确认和修改：','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、人社厅数据体系规划设计项目：持续优化方案，初步拟定人社厅数据体系规划设计大纲','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、精品案例：根据市场部给的精品案例建议清单，对其中党政行业案例分类等，作为后期上架精品案例的备选','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','重庆出差
扬州船闸健康监测项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','重庆出差
标准ICT与铁通、政企部、综合对接沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午:招商银行南京分行IT开发服务项目，配合项目标本后台支撑，价格计算，澄清解释。
下午:江苏省农商行主备防火墙项目，分析项目后向情况以及厂家选择；跟进中国银行数据补齐项目专利申请流程。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','bid-quotation','owner','1、江苏省消防救援总队 2026-2027 年度信息化及卫星通信网运维服务项目需求方案及补充协议文件：完成内部会审，根据会审意见修改完善，并提交给客户；
2、编制江苏省商务厅网络安全设备与 LED 屏采购项目投标文件，针对项目授权及售后服务对接深信服、奇安信、天融信，对接迪普合适设备参数；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','全天：
1、支撑淮安行政审批局、省市监局、常熟市数据局、省交通厅组件迁移对接工作；
2、继续排查淮安行政审批局数字签名请求异常问题，与客户对接验证，根因在于客户请求认证头无法被正确带入，现问题已成功验证解决；
3、完成组件超市门户联机帮助文档修订初稿审核，对照组件超市现有功能优化文档。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、扬州公司、连云港公司特殊项目甲方载体签收表催收及归档。
2、淮安公司特殊项目导入导出等现场支撑。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、淮安公司某特殊项目约谈事项材料编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、协调处理烽火人员质态评估事宜；
2、方软预安排新运维人员进场事宜向客户汇报；
3、同客户对接质态评估流程，协调三家厂家现场人员。
下午：
1、客户质态评估会议待命，待命过程中烽火运维处理节点异常，跟随学习节点问题修复过程；
2、同客户、烽火、方软沟通人员根问题处理方案，采用临时启动任务的方式，每周检查任务存活状态；
3、同客户沟通质态评估报告优化修改方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','连云港国资一张网项目支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目场景封装支撑
2、淮安某项目约谈协调','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、宿迁检察院项目案例整合及DEMO提供。
2、整合并提供公安行业代理产品语音智能司法鉴定介绍。
3、信创全省培训事项协调。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、7月工作量整理填写及反馈。
2、部门周例会。
3、数智化材料编写。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、12345标书评审、优化、合稿
2、质疑回复函','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、数据要素X 报名提交材料','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：中烟工互项目对接徐烟ip提供；与客户沟通会议纪要内容，提交会议纪要评审；云效管理工具创建里程碑，关联需求；
下午：学习工互平台资产目录树创建方式，层级划分，不同层级关联属性信息，不同属性关联点位信息。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','1.组织客户、中邮建、泰瑞奇三方召开沟通会议，针对项目招标文件拟定版本逐项研讨，沟通项目服务范围、技术规范、实施边界等条款，收集各方修改意见。
2. 与客户专项商讨项目付款节点、付款比例、款项支付、履约保证金相关约束条件等商务事项，同步梳理商务条款纳入招标文件相关要求。
3. 应急厅全信息化系统运维业主会议，对接业主相关负责人，沟通项目相关人员参会等相关事宜。
4. 汇总会议形成全部待调整事项，整理各方修改建议，计划统一整合修订招标文件文稿。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1.1-6月连云港项目支撑工作量核减确认
2.灵犀晓伴SKILL调试
下午：1.工作量统计分析系统测试及优化
2.工作量偏离情况填写及上报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：2026年高管中心智慧化服务区一体化示范提升项目，整理项目案例，整理拟任项目经理在建工程情况，给战客领导汇报
下午：江苏省港口集团有限公司业务网络专线集中采购项目投标文件编制，寻找项目案例。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','请假一天','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：宜兴普通国省道路网监测项目备案资质核查；
下午：腾龙大道智慧快速路工程AI+建设管理场景服务项目资格审查材料支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','麒麟行业方案编写；超期方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：编写缫丝加工生产进度跟踪、缫丝加工仓储智能管理场景方案。
下午：与苏州冠骋信息和中有信科技沟通生态交流相关事宜；安赛乐米塔尔园区智能化项目投标支撑，协助搜寻案例。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.参加环保项目例会，跟进门户PC端、移动端bug处理 功能优化等问题进展
2.更新项目近期事项跟踪表测试记录及问题状态等
下午：
1.沟通智慧食堂计划实施方案要点
2.参加客户会议，汇报近期工作进展','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','12345民生智慧听项目：完善完成标书技术部分，商务部分及整体内容验证
两平台项目：
完成全面性规则、准确性规则全量配置，完善规则校验逻辑、表单关联、阈值参数等配套配置，至此及时性、覆盖面、全面性、准确性、数据清洗相关规则配置全部落地完成。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：行业知识库技术栈选择，小组团队职责划分。
下午：知识库环境镜像拉取，prd文件修改。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','1、继续编写疾控省统筹平台“六优项目”申报材料；
2、传染病病原监测信息系统（生信测序）和（生物样本库）试用问题沟通，目前存在测试不兼容和配置问题，修改后再给科所开账号。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午
1、就省数据局、省委网信办政务应用程序整合通知，与客户开展交流讨论，明确工作安排部署
2、完善器械备案许可数据偏差情况说明材料，准备下午会议相关数据明细
3、公安厅短信平台后向验收沟通
下午
1、参与器械备案许可数据偏差情况讨论会，根据会议上省局局领导指示，核实地市整改情况
2、根据国办数据共享及省垂系统对接工作安排，与文件上技术联系人沟通细节，获取登录方式及填报入口
3、编写数据中心数据考核管理办法','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、配合苏小慧智能体对接组件超市的统计组件相关的数据的sql语句的调试。
3、和总体组人员梳理目前组件超市截至目前开通的所有网络策略的清单，提交总体组进行审核。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、配合调试解决淮安市行政审批局系统数字签名组件接口调用问题。
3、跟进华为语音合成组件对于交通厅系统调用后反馈的问题的解决进度，协调对方人员对于新的合成语音的效果验证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：组内7月工作量收集整理，分析复核组内工作量数据，对接扎口人；收集组内7月绩效数据','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：1、处理中石油站点故障2、跟进气象局开发进展，核对验收相关资料
下午：1、检察院后向新人进场信息协调，跟进检察院测试接口具体信息。2、与客户经理沟通沿海集团验收材料事项。3、问询高投验收材料客户反馈进展。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：“数字人大”XC改造项目客户现场沟通
下午：1、“数字人大”XC改造项目招标文件修改
2、江苏“12345”热线服务标书商务部分交叉审核
3、省级枢纽管理“三统一”平台项目受托代销流程跟进、','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：1.指导客户通过数字人大APP阅览公文
2.帮忙调整厅级领导的账号信息及权限，并验证账号
下午：1.协助确认问卷是否可以进行问题归集
2.督促泛微解决档案的批量下载文件没有六格章问题
3.客户反馈档案搜索有问题，通过功能测试验证发现没有问题并反馈客户','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-28'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 核查系统问题清单解决情况，更新客户专班近期事项跟踪表。
3. 参加客户工作会议，汇报子系统建设进度、测试情况及需协调问题。
4. 与厂家讨论AI中台建设问题，计划后续开展专题会议讨论技术方案和工作界面划分。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='高翔'),'leave-morning','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：休假
下午：在51号沟通对接社工部项目方案优化工作','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:招商局重工申报材料评审
下午：招商局重工申报材料修改','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='黄思华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-TEST-05'),'project-support','requirements-analysis','owner','上午:分析疾控AI需求，协助调度研发二部和DI部梳理汇报材料
下午:分析军总运维项目招标文件，对风险问题邮件回复战客','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-28'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午:准备麒麟例会材料
下午:参加部门例会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-28',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-28'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.参加发改项目周会，汇报上周API网关及服务器缩减工作进展；
2.协调测试环境服务器被误关停的问题；
3.协助查找发改价格监控平台短信网关问题；
下午：
1.参加环保专班沟通会，汇报人力、投资、商机系统测试情况；
2.跟进厂家对现有bug的修复情况；
3.复测投资系统周一测试有问题的流程。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1 苏州港航项目现场投标支撑
2 连云港医共体方案交流方案编写','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','昆山医疗行业推荐会宣讲方案编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：金湖苏采云项目，客户完成下单，配合地市确认客户订单并完成合同内容确认','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：麒麟基础方案更新上架；麒麟历史方案更新上架','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：继续支撑安赛乐米塔尔园区智能化项目关于千万级包含综合布线、网络、视频监控、门禁系统案例，并发送常州新北时健。
下午：支撑淮阴卷烟厂制丝线升级改造电控集控及智能化系统建设项目生态厂商对接工作，目前已联络昆船、和利时、中控技术；其中昆船独立投标，和利时正在开展技术确认，中控已经发送给淮安张昺宇具体对接。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：1、编制船舶改装行业、电车制造行业等细分领域的场景方案编制；2、精品案例盛迪亚AI模型应用项目编制。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：和后向确认江苏省人民检察院政法业务协同系统二期项目验收进展，明确终验时间在8月，并确认计划期内相关工作推进','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、根据领导要求，调整部门7月全量工作量表格填写规范；2、填写软集工作周报，完善项目信息；下午：核对部门收入成本明细','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：苏政源敲门行动项目组例会；档案馆库表归集任务主键核查、档案馆服务器和数据库工单申请支撑。
下午：一本账系统问题核查处理；农业农村厅云网对应关系核对关联；省广电、监狱管理局一本账登记的系统名称与真实的系统名称核查；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：7月份小微项目梳理，优秀案例材料编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统、合同系统功能全量测试；
3. 整理商机、采购、合同系统全流程；
4. 跟踪对接采购系统、法规系统问题解决进度。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、优化 AI 会议系统方案，对接调研各家生态合作厂商
2、学习灵犀星火智盒，梳理 C/B/G 全端口产品功能特性
3、参会学习数据治理赋能 AI 建设，研读省人大数据治理实操案例汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天：
1、工业行业虚拟团队会议，1h。
对接海澜之家项目情况，沟通后续工作安排；
反馈大生集团项目进展与支撑需求；
近期其它工作要求。
2、淮安台华新材尼龙智能化项目：进行AI检测、智能分级、智能修色、排程等需求分析，根据需求进行厂家寻源，沟通10余家供应商，反馈项目经理解决方案及案例。需持续跟进。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','下午：教育行业下周麒麟平台拓展汇报材料编制。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、按照工委领导给的党组织顺序完成系统里的组织排序
2、处理江苏机关党建云党组织负责人反馈的问题
3、核对江苏机关党建云新旧系统的组织差别，将旧系统组织的key赋值到新系统，确保数据迁移的准确性','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全省每日签约数据汇报','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、输出高使用价值月报相关统计指标；
2、和处室对接汇报月报数据统计口径；
下午：
1、配合处室进行江苏省国办平台供需需求填报工作；
2、整理高使用价值归集目录对应苏政源目录的情况；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：数据要素申报材料ppt整理；下午：省内三化项目拓展支撑2个；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、保密管理系统呈批内容协调沟通，汇报定稿提交。
2、完成淮安SM业务风险问题约谈。
3、SM业务团队工作汇报材料整理。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='刘茜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘茜') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、某单位固定电话开通配套设备项目，完成中超购物工作，跟进流程，完成合同签订及盖章。
2、国家（江苏）紧急医学救援队无人机及管理系统购置：按照要求修改需补充的无人机配件技术参数、服务内容。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：工业虚拟团队专项会议，行业生态交流华工赛百，埃斯顿，新松机器人。下午：常州二院AI项目事宜沟通，医疗生态交流，惠每医疗cdss及癌症质控解决方案。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：麒麟精品案例修改上架，医疗相关生态维护。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源数据治理项目支撑。
上午：1、数据治理规则模块功能测试评审；2、一本账数据质量综合指数需求沟通；3、解答人法信数据治理血缘链路；4、处理农业农村厅行政处罚信息治理完未通知共享库问题；
下午：1、评审并整改数据治理需求规格说明书；2、处理客户无法登陆数据治理平台访问模块的问题：权限配置；3、跟进宿迁、南京、宿迁等地市一表通人员数据治理，调整未按规范命名的治理任务；4、评审并分析人法信基础库数据开发模块菜单需求。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：省政务云租赁服务项目精品案例资料搜集和内容编制；党政生态可用性定期维护在线文档政务等子领域生态维护
下午：省政务云租赁服务项目精品案例资料搜集和内容编制；麒麟平台方案党政超期资源更新计划评估；党政生态可用性定期维护在线文档政务等子领域整体统筹','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='吴承云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴承云') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.拉通软件服务商与政务云，对齐"一带一路"系统负载均衡问题工单处理路径与解决方案；
2.对接政务云人员跟进NAT网关申请进度，逐一提交入访策略申请并记录工单号；
下午：
1.配合第三方开展数据安全风险评估工作；
2.提交网络策略申请，并针对策略疑点拉通相关方确认修正策略(持续跟进）。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：情指行材料案例涉及的厂家信息补充及校对；
全天：GA领域国产化改造涉及信息化及厂家搜集梳理。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：月报审核系统测试任务调试；
下午：AI团队汇报材料编写；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、镇江工信工业企业培训专家对接，对接工联院、海尔卡奥斯；
2、徐州AI+工业系列商机需求对接，生态沟通推荐；
3、上研生态运营浙江模式对接，沟通市场部；
4、工业虚拟团队工作梳理及下一步计划内部沟通。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','绽放杯材料沟通，泰州现场对接。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='周俊凤'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-TEST-06'),'project-support','customer-support','owner','全天：1）产研院长三角医药健康行业可信数据空间项目，通用算力、AI算力、安全设备厂商询价。
2）江苏省医保五期扩容项目，后向沟通，参数核对。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-TEST-07'),'project-support','solution-design','owner','上午：省消防救援总队智能指挥系统项目支撑：基础平台融合建设与全域集成管控方案编制
下午：北京数巅科技有限公司技术交流；基础平台融合建设与全域集成管控方案编制','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','解决方案麒麟平台上架素材编制；党政生态可用性定期维护','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：东航CVR项目语音标注进度同步','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：麒麟历史场景方案更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、宿迁数据条线支撑，梳理全省数据局条线近两年中标的项目给出地市拓展意见建议；
2、苏政源后向采购事项协同支撑；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','疾控省统筹平台（二期）项目，专项工作内容学习。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：1、麒麟平台政研工单审核。
2、软集周报本周工作进展与下周工作计划收集整理，未更新项筛选梳理。
3、麒麟平台内超期未更新资源核实与更新
4、研发报告立项材料梳理编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 调整初验材料《用户手册》格式（200页）
下午：
1. 敲门行动：核对14个部门的系统名称与访问地址打开后的系统名称是否一致，并联系省档案馆、省外办、省检察院、省审计厅核对修改。
2. 组件超市：(1) 协助交通厅、省政协、淮安数据局进行接口调试 (2) 整理组件申请流程卡在首席数据官没设置的部门','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','苏政源-敲门行动
上午：
1、参加数据归集每日例会，核对数据申请记录迁移清单，补充完善无主键的库表情况；
2、协助省文旅厅开展系统合并工作；
3、完成南京海事法院相关情况总结，并协助形成汇报材料。
下午：
1、完成公共数据平台系统部署方案的格式整理及内容补充工作；
2、核查江苏省科学技术厅、省人力资源和社会保障厅、省生态环境厅、省统计局、省政府国有资产监督管理委员会系统名称与页面名称，对不一致的系统名称进行整改。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：
1、省疾控中心参加急传所2026全省虫媒及肠道传染病监测现场培训，及省统筹平台5个业务系统使用现场答疑；
下午：
1、省统筹平台（一期）项目卫生资源和应急值守系统运维群用户使用问题答疑解决；
2、省统筹平台（二期）项目基础能力管理系统和症候群监测系统本周开发功能评审并验证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：售中组周报收集与统计、在综合部找项目资料合同                                 下午：处理OA系统报账代办、处理项目付款报账单扫描材料、打印部门会议材料、打印实习生考核鉴定材料','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：宿迁港中心港区陆运河作业区陆集中心港一期工程智慧化项目反质疑相关事宜支撑；“港航智养”无人机+多源数据融合与人工智能技术应用项目支撑；
下午：麒麟平台精品案例梳理及项目PPT编写；南通超限超载、非现场执法项目商机、资质相关材料支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','研究开发费用计提材料准备，计提流程；团队工作量1-7月情况分析数据。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：
1、讨论工业虚拟团队的分工；
2、同市场部沟通麒麟平台工业制造细分领域生态目录改造（市场部仅同意增/删一二级目录，三级目录往下系统不支持，也不安排研发改造）；
3、审核商贸行业上会方案（众创数科）；
4、梳理工业虚拟团队相关工作目标。
下午：
1、同研发二部商议“护网”期间平台安全事宜；
2、沟通商贸行业支撑流程；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.支撑常州内部合同流程
（江苏移动信息系统集成有限公司某施工项目）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','淮安JCB-2026-067项目投标支撑、JCB-2026-072项目投标支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','总结整理保密项目管理系统作用成效','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：商讨商贸流程相关事宜；下午：商贸麒麟方案上架情况梳理，场景方案内容整理，火瞳产品相关能力梳理材料编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：1）机场OA项目递交投标文件；
2）公安厅数据库厂商坤之泰要款及数据赋能项目硬件质保期倒挂事宜的讨论沟通。
下午：1）交通运输厅危货监管项目客户演示汇报。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1，再次与客户开药监政务应用程序整合清理工作研讨会议；2，东航CVR项目，与讯飞技术同事研讨项目场景；
下午：1，东航CVR项目，与讯飞，东航开会讨论当前数据标注质量不高的风险。2，与紫金院同事开会讨论连接器项目出现的问题（联通业务节点配合度不够）。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、数字人大项目开票问题继续分析推进；','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、向省政企部反馈行一行二FDE签字培养对象能力情况；
2、参加政绩观学习教育；
3、沙政兵陈雪松两位同事上半年结算工作量问题分析并与战客中心交涉；
4、一线直通车关于苏移集成智慧印章问题分析与研究；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：江苏中烟2026年智算设备租赁服务项目:针对智算租赁需求，梳理GPU算力与存储配置需求，完成售前技术评估，同步对接算力团队询价，整理并初步拟定了项目询价报价材料。
下午：江苏中烟工业有限责任公司2026年总部计算机及相关设备、软件采购项目:推进项目投标工作，完成了服务方案及项目团队人员配置的撰写。同步细化软硬件供货调试流程，明确了质保期内的售后响应机制与技术支持方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1、参加麒麟例会，同步落实相关工作要求落实。
2、室内例会会议纪要整理。
3、落实麒麟平台下阶段需求整理、跟踪。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','保密专项汇报材料-流程配套资源；主要工作；责任人及分工；人力消耗等部门内容编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：支撑法院执行局项目，跟客户介绍苏政源项目的情况，业务、技术架构等；支撑苏政源，定位客户电脑不能访问系统的问题；
下午：支撑苏政源，定位异议系统流转过程中旧工单仍出现测试账号问题；紧急修改页面可以选择指定处理人推送；整理拷贝风险防控使用到的开源组件，打包安全扫描；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1，常州妇幼高质量数据集汇报工作支撑：协调厂商安排人员配合现场方案汇报和答疑,2，AI医疗各领域产品生态梳理和整合
下午：1，AI医疗各领域产品生态梳理和整合 2，宿迁妇幼保健院智慧医院汇报方案支撑，协调预约周五现场汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='李晶'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会，同步项目今日进度与计划。
2.继续推进在线表格2BUG+6优化事项。
3.同客户开会交流苏小智APP落地工作，搜集现场网络、服务器、客户手机品牌型号等信息。
4.根据客户对APP要求进行功能分析。
5.持续与战客中心沟通，尽快确定B/S版本研发方向和APP后向能力选型。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、上午支撑公安厅苏小智项目，结合战客中心拜访后收到的APP需求，与陈支和孙科沟通推进方案；
2、下午继续完善公安厅苏小智项目生态比选汇报材料，增加7月客户沟通进展以及APP建设生态比选情况；
3、下午了解组内中烟工互项目、检察院人员培训驻场等重点事项进展。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、下午编写行业一部月度工作计划；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.和省红十字会技术人员对接，确认数据库数据项
2.参与苏政源省部门归集会议，报告相关情况
3.查询整理省级部门124张库表对应数据。
下午：
1.完成客户交办工作，整理高价值数据贴源库数据量
2.撰写省级部门质量报告月报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-02'),'project-support','requirements-analysis','owner','上午：与宏达科技开展业务交流，对接合作相关事项，梳理后续协作要点
研讨公安数据湖项目现存问题，分析卡点，初步梳理可行优化思路','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：组织组内沟通研讨，推进绩效管理落地，同步工作考核标准','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：外部专家省政企2026年全年、1-7月地市待摊数据重新统计；第八批外部专家信息收集汇总','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、协助保障常委会，巡检新闻模块是否正常。2、协调中江更新数据并复检。
下午：1、协助完成苏州、常州民营机构线索梳理工作。2、跟踪线索下发进展情况，同步更新表。3、补充项目进度报告材料。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.对接无人科技部跟踪连云港市公安局具身智能设备管理平台项目进展，完成闭环。

下午：
1.初步分析南京市清凉山公园管理项目需求，完成能力资源适配。
2.推进跟踪确认国资委在线监管项目（延期）、常州自动监测站运行维护项目进展跟踪。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：
1.党政行业周报收集
2.按照领导意见，全局逐条整改一点调度工单台账。
下午：
1.党政行业公共事务支撑（7.29一点调度新增工单台账维护）
2.班组日常公共事务支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：梳理行业精品案例-梁溪教育中小学智慧教育平台项目，整合项目技术方案、建设成效，制作案例PPT。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午:跟客户经理跟单主任汇报测软整改情况及进度，单主任提出对常州工勘院打印模板设计、地质一队过期网站信息处理等问题的优化。
下午：协调厂家整理需求，对常州工勘院打印模板设计、地质一队过期网站信息处理海洋院流程调整；高质量考核部分单位无法导入问题进行系统优化。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、就CAIE培训相关事宜与售中同事进行初步宣讲，介绍培训计划。
2、与南京公司沟通SM项目及载体，资料相关流程事宜','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','智慧印章系统：跟戴总沟通关于地市公司用印效率问题，与宿迁、南京了解现在老设备的使用情况，计划换回老设备。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：出差淮安支撑淮钢金相检测项目，与淮安公司讨论客户汇报方案（一高一低)及策略，计划周四上午客户现场交流。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：制造业生态梳理，完成14条','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','老干部局数据迁移项目环境部署协调沟通','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.梳理项目需求证书，编辑激励方案
2.党建、工会对接事宜','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1、日常服务器巡检，一切正常；
2、常委会现场保障，处理软key证书续保一个；
3、排查异常国外IP2个，已安排政务云封禁；
下午：
1、无锡市代表账号问题处理；
2、处理预算联网运维账号，人员变动；
3、处理邮箱账号问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、民政殡葬监管交流材料优化更新；
2、无锡无废城市精品案例拆解上架','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目物联网应用、音视频会议场景典配优化，建议价格梳理；
2、麒麟社区工单流程优化需求梳理填报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','customer-support','owner','1.商务厅网络安全设备项目标书审核，检查技术证明材料的漏缺，提出整改意见，
2.江苏省自然资源厅wifi维保核对技术要求和商务资质，出不定稿招标文件，反馈至客户经理。
3.江苏省人才服务云平台（人才信息港）建设项目处理网签事宜。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、南京紫金农商行安防工程项目投标沟通
2、盐城数智化中心沟通成熟AI+教育产品情况，提供生态资源','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、CS2资质后向报账材料准备
2、XC培训地市沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：参加数据归集日例会，跟进尽快输出市场监督管理局、交通运输厅数据归集过程中新老目录的核对情况说明；协调解决省政法委老平台上目录迁移至新平台的问题；
下午：1、协助交通厅和市场监督管理局整理输出新平台要下线的目录情况；
2、协调苏政源新平台数据治理和公共数据平台支撑组输出高使用价值数据治理情况表；
3、支撑输出广电局、信访局、市监局等部门完成信息系统专项信息填报部门复核；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、人社厅数据体系规划设计项目：完成人社厅数据体系规划设计PPT，初步梳理规划大纲','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、精品案例：组内精品案例审核','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','重庆出差
宿迁港项目支撑
常州高速项目支撑
盐城转研发商务处理','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','标准ICT事宜处理
创新工作例行处理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天:江苏省农商行主备防火墙项目，项目后向询价，参数指标对接，项目投标文件商务材料搜集','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','solution-design','owner','1、江苏省商务厅网络安全设备与 LED 屏采购项目：深信服、奇安信、天融信三家厂商授权函、技术参数证明等全套佐证材料的收集、核对、查漏及完善工作，逐项沟通对接、校验资料完整性，跟踪材料整改补齐进度；
2、跟进气候中心项目挂网情况，省消防救援中心运维项目方案客户审核情况。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','全天：
1、支撑省市监局、淮安行政审批局、省交通厅组件迁移对接工作；
2、整理省市监局所需数字签名组件联调demo；
3、修订组件超市门户联机帮助文档，优化组件审批部分；对接门户帮助中心人员填入已整理的文档。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、淮安公司3个特殊项目导入导出等现场支撑；
2、常州公司某融合创新项目商机支撑。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、淮安公司某特殊项目参与约谈、记录等；
2、特殊项目内部工作电脑收货流程与综合部同事现场沟通并提交处理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、同锡明总跟客户沟通质态评估事宜；
2、接客户经理向客户沟通人员暂不进场的情况；
3、按客户要求调整质态评估报告，优先调整审计相关、功能相关内容；
下午：
1、分析公安网下的烽火数据治理平台，整理相关数据写入质态评估报告，待与客户查询数据域下的数据治理数据；
2、处理数据治理平台任务失败的问题；
3、处理人员根任务仍没有数据的问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、连云港国资一张网项目投资子系统支撑
2、省消防三全一大项目数据底座支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','1、标准ICT项目场景封装支撑
2、淮安某项目约谈协调
3、组织SM工作流程与资源需求整理
4、组织优化麒麟平台党政行业常态化统计机制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、信创全省培训组织协调
2、射阳县公安局大模型项目，协调生态，整合提供技术方案','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、绽放杯材料重新填报
2、信创团队与AI虚拟团队汇报材料审核编写。
3、配合厂家信创服务器调试，团队沉淀容器化，虚拟化相关能力。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、12345项目标书合稿评审，制作标书并上传','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：沟通智慧水务3D建模技术服务项目，明确客户流程在进行中，等待领导审批通过后可以打款；沟通考试院身份验证技术服务项目，客户领导变更，要等他们忙完招录工作后沟通验收事项；中烟工户项目项目周报总结；
下午：中烟工互项目与阿里沟通跟进公户项目建设方案编写进度，学习与国家具对接架构设计；回江北公司处理海事等保测试系统相关报账事宜；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','开展省公共资源交易中心信息化平台服务项目投标工作，系统梳理投标商务材料。对照招标文件要求归集企业资质、同类信息化项目业绩、人员资料、各类承诺函，核对商务条款响应内容，排查材料缺漏项。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1.进行省人大数据治理实操案例小组汇报
2.调试工作量统计分析系统
下午：1.灵犀晓伴技能上传与修正
2.优化标书公司匹配系统技能说明和指引','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏省港口集团有限公司业务网络专线集中采购项目-业务专线标段，投标技术方案编写，案例增补，报价文件编制。
2、江苏省港口集团有限公司业务网络专线集中采购项目-视频专线标段，投标技术方案编写，案例增补，报价文件编制。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:
1.配合统计高价值最新治理情况，并反馈治理任务失败情况和原因；
2.删除老干部局2条治理规则并重新治理，更新在线表格统计数据。
下午：
1.对失败任务按照离线采集状态分为3种情况，并分别对这3种情况，制定出解决方式，并进行处理。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：宿迁港项目人员情况支撑；
下午：宜兴普通国省道路网监测项目资格审查资料核查；腾龙大道快速路工程AI+建设管理场景服务项目人员业绩问题支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：标准ICT项目清单更新','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','bid-quotation','owner','上午：梳理麒麟平台中录入的制造业生态，收集生态在对应国民经济小类中的解决方案以及典型案例，补充到小类覆盖情况表中。
下午：与苏州中有信科技沟通生态交流相关事宜；安赛乐米塔尔园区智能化项目投标支撑，协助搜寻案例；淮阴卷烟厂制丝线升级改造电控集控及智能化系统建设项目投标支撑，协助搜寻案例。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.和产业园客户开会，沟通智慧食堂上线前准备工作
2.和乐牛厂家测试洗车人脸机设备及网络
下午：
1.测试食堂各点位消费机网络及电源是否满足上线要求
2.核对大华系统导出的人员照片等信息','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','12345民生智慧听项目：与阅点点对接标书技术及商务内容，完成标书上传工作
两平台项目：
持续开展前期未收尾的各类数据质量规则配置工作，当前整体配置进度达 90%。剩余待配置内容分为两类，一是定制化脚本类特殊规则，二是依赖页面功能完善后方可录入的规则项。后续将优先推进页面功能优化、脚本规则调试工作，整体计划于本周内完成全部规则录入配置。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：知识库前端页面设计，Embedding模型选型。
下午：1、AI团队汇报材料编写。2、知识库poc实现路径论证。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1、参加急传所面向全省市县疾控的业务培训和省统筹平台介绍会，并协调组织相关系统负责人现场答疑；
下午：
1、继续编写省统筹平台“六优项目”申报材料；
2、与季所沟通讨论症候群系统和舆情系统建设情况，记录要求，并跟进系统负责人下一步将与科所加强沟通，主打系统实用功能上线。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午
1、编写数据中心数据考核管理办法
2、根据国办数据共享及省垂系统对接工作安排，初拟数据共享需求材料
3、就省数据局、省委网信办政务应用程序整合通知，与省局直属单位沟通填报要求
下午
1、数据治理商机跟进，明确拟报局领导材料编写要求
2、配合战客现场与客户沟通短信业务合同协议
3、集成平台上云服务器资源协调
4、玄武平台纳管进展统筹，跟踪工单处理进展，协调玄武平台验证测试及纳管
5、内网SSL证书部署沟通','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、提供给苏政源门户的帮助中心的组件超市的操作手册文档，配合更新到帮助中心的模块，对接一本帐提供手册数据更新到知识库。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、推进华为的语音合成组件的音频生成的效果的验证进度，和交通厅得系统人员确认音频的效果。
3、配合大数据中心安全团队对接组件超市源码文件的AI代码审计的验证功能
4、和自然资源厅单位的系统人员对接申请ocr组件的首席数据官的配置以及解决ocr对接接口调用过程中反馈的问题点。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='陈笑'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1、处理中石油站点故障信息2、跟进沿海集团验收资料，交付给客户。
下午：1、与检察院王主任现场面谈，带新（后向运维人员）。跟进医保局数据接入进展，2、跟进气象局项目进展，处理客户需求。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、江苏“12345”热线服务标书商务部分交叉审核，电子标上传支撑
2、省级枢纽管理“三统一”平台项目受托代销流程跟进，标后合同流程支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：1.保障常委会，巡检信创区域业务和服务器
2.指导客户使用数字人大问卷功能
3.指导人大代表登录数字人大查看议案建议
下午：1.客户反馈档案系统接收库办公厅的30年档案条目机构字段都是空值，协助重新上传
2.客户反馈档案系统批量修改字段功能有bug，待测试功能','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 协同准备三重一大事项、议题演示数据。
3. 向客户演示汇报三重一大系统，以及子公司公文流程情况。
4. 梳理客户提出的需求和修改意见，形成问题清单。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：常熟生物多样性项目支撑，整个输出初版方案
下午：连云港国资项目支撑，对接数创沟通投资板块报价和工期计划','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:招商局重工申报材料修改
下午：招商局重工申报材料定稿','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='黄思华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-29'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午:
1）医保五期设备清单核对
下午:
1）医保五期设备清单核对
2）机关医院交流病房机器人需求
3）疾控AI项目，与DI 云智部对接明天汇报方案','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-29'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午:
1）参加麒麟例会汇报','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-29',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-29'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：
1.检查环保人力系统演示ppt，更新其中子公司开发进度及沟通情况的表格；
2.参加环保项目早会，跟进系统问题解决进度；
下午：
1.协调解决发改服务器访问不通的问题；
2.响应发改客户要求排查部分有问题服务器是否属于一带一路老系统；
3.同步发改资料配合第三方检查。
全天：
1.与后向厂家一起测试环保投资产权系统全流程；
2.支撑发改API网关相关网络策略提单。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1  盐城四院 心理健康辅导智慧小屋项目方案支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','昆山民营医疗机构需求对接与人工智能应用方案宣讲','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：涟水区信创集采项目，开展标书分析研判，提供商务材料支撑和技术方案编写支撑。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：信创实验室服务采购下订单
下午：麒麟平台历史方案更新；信创专项培训工作准备','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','下午：1、继续支撑淮阴卷烟厂制丝线升级改造电控集控及智能化系统建设项目生态厂商对接工作，目前中控技术经过沟通回复无法支撑；和利时初步回复可满足，需进一步沟通，阿里推荐的生态正在技术确认中。
2、开展省战客工业AI场景梳理工作，重点完善场景对应的痛点解决方案描述，完成8个场景材料编制（共15个场景）。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：1、上传编制船舶改装行业、电车制造行业等细分领域的场景方案至麒麟平台；2、上传精品案例盛迪亚AI模型应用项目至麒麟平台；3、完成麒麟平台政研政策处理以及更新制造行业政策及商机洞察、虚拟团队周报（含AI能力、生态建设图谱、业务知识等）、行业支撑周报填报、地市支撑工单填报。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：按照市场部统一模板整理7月工作量，将整理好的清单提交市场部；下午：编写一体化证书激励方案，桌面研究适合一体化的考证方向','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：苏政源敲门行动项目组例会；档案馆互联网区库表资源核查，财政厅关联云资源部署位置核查。
下午：一本账系统问题核查处理；卫健委云网对应关系核对关联、农业农村厅云资源问题梳理；监狱管理局、司法厅一本账登记的系统名称与真实的系统名称核查；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统、合同系统功能全量测试；
3. 整理商机、采购、合同系统全流程；
4. 配合甲方进行测试，指导其进行操作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','AI领域相关证书梳理PPT编制(全天)','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','全天：
1、工业海澜项目：与无锡公司工业负责人、海澜项目所属网格长、项目经理进行沟通，了解项目基础情况及近期安排，预计下周一到周三入场进行展厅2.0交流。
同步进行服装行业智能化行业知识学习，梳理海澜项目40个场景生态图谱。
2、工业大生项目：与俞海波沟通项目进展，暂无进厂计划。
3、教育行业麒麟平台汇报材料编写，4H，完成进度80%。
4、教育行业本周社会集成商中标信息采集。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','1、处理江苏机关党建云党组织负责人反馈的问题
2、苏政源项目协助验收资料准备，包括数据授权运营平台项目的开发计划和项目周报','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全省每日签约数据汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、协调苏政源门户和平台组提供高使用价值申请以及调用信息；
2、汇总统计高使用价值月报，并输出最终版；
下午：
1、配合处室进行处室内部的安全审计，并准备相关审计材料；
2、和处室汇报并核对高使用价值月报数据；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午:参加医卫行业全省半年工作总结及商机梳理会议；下午：盐城四院AI心理小屋 ：成熟方案及落地案例支撑，以及对应可合作生态建议；南京儿童软著申办情况跟进；医疗咨询服务、方案设计类案例梳理；','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、总结编写涉密团队工作总结材料','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='刘茜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：健康小屋交流，研发及生态伙伴（盖睿）产品沟通。
下午：美行科技等生态交流，中医ai诊断开药解决方案沟通。茅台酒业项目报账。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：医疗行业周报及工作量汇总，常州二院精品案例编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源数据治理项目支撑。
上午：1、评审数据治理需求规格说明书；2、沟通并跟进时空地理质量规范征求意见和修正情况；3、解答运维运营团队，数据情况月报使用苏政源的数据来源需求，并提供相关指标，拉通一本账、苏晓慧明确需求，确认实现方式；
下午：1、教育部数据解密方案沟通；2、教育部相关数据采集解析任务配置；3、苏州一表通人员数据治理任务配置；4、整理地市一表通人员数据治理情况，向客户汇报跟进；5、处理治理-异议系统对接接口不通问题；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：省政务云租赁服务项目精品案例资料搜集和内容编制；党政生态可用性定期维护在线文档政务等子领域生态维护
下午：省政务云租赁服务项目精品案例资料搜集和内容编制；党政生态可用性定期维护在线文档政务等子领域整体统筹','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='吴承云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴承云') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1.跟进国泰联合演练网络技术服务项目材料，完成项目信息登记；
2.对接在建在维项目，全面通知护网行动要求，协调各项目组开展自查自检自纠；
下午：
1.接收下游交付方提交的国产化项目计划表，梳理三梯队开发策略、16项里程碑与8个阶段划分，将总体设计、安全设计、数据迁移等八份方案材料归档；
2.更新进度与里程碑管理计划，纳入关键日期节点、梯队划分；
3.发改网络策略及负载均衡更新申请进度跟进，协调验证、闭环相关任务，持续跟进进行中的任务。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：情指行材料案例涉及的厂家信息汇总并提交；
下午：省GA下一轮汇报涉及需求沟通讨论，地市项目调研清单模版编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：月报审核系统正式数据测试，调试功能；
下午：AI团队进展汇报；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='吴鹏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴鹏') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1、兴达钢帘线质量、生产等AI需求现场交流。
2、徐州印刷厂智能工厂需求对接，协助生态沟通，涉及现场产线改造，初步推荐博依特。
3、徐工消防人员定位项目需求，沟通人员定位具体方案，手环功能、人员电话授权等。
4、专班会议材料编制。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='周俊凤'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周俊凤') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1.根据监理审核意见继续优化组件超市相关文档；
2.跟踪OCR近期版本情况和业务部门对接需求；
3.协调刘涛协助授权运营2.0（苏政源和征信的合同）配合交付文档准备，并进行项目基本情况沟通和任务分配；完成周报内容审核修订；完成授权运营2.0总体计划编制。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='周菁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周菁') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：1）江苏省产研院长三角医药健康行业可信数据空间项目，通用算力厂家沟通；2）江苏省云端课堂教育名家送教乡村云端课项目，修改客户立项材料；3）江苏省招就中心招考工作技术服务类项目包2，对接后向厂家，编制投标文件。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、省应急厅面向突发事件的5G-A预警应急通信和指挥调度处置应用项目无人机及应急通信相关素材整理；
2、省应急厅绽放杯路演PPT材料预研；
3、省消防总队119视频接警能力建设项目方案对接。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：历史麒麟平台方案更新
下午：信创周报编写，信创专项工作汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、智慧发改一体化平台项目汇报支撑；
2、AI领域的认证方案讨论；
3、连云港数据汇聚平台+数据产品加工运营平台项目支撑；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','疾控省统筹平台（二期）项目驻场，项目架构熟悉，相关专项工作内容学习。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：1、软集周报工作计划收集整理，未更新项筛选梳理。
2、麒麟平台内超期未更新资源核实，汇总给市场部。
3、更新资质维护与申请内容，收集审核资料；
4、编写麒麟平台建设下周工作计划。
5、统计场景方案基础方案数据，完成周报内容。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1. 数据归集：数据归集小组每日例会
2. 联系省体育局、省住建厅、省政府办公厅增加首席数据官账号
下午：
1. 联系省发改委增加首席数据官账号
2. 数据归集：(1) 核对省药监局243个新目录与148个老目录间数据项的差异。并联系部门确认、修改(2) 整理编写省审计厅下线目录与老平台对应表格
3. 专项清理：联络水利厅更新运维人数
4. 组件超市：协助淮安数据局完成数字签名联调','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、参加数据归集每日例会，梳理当日工作安排，同步各单位数据归集与整改推进情况；
2、跟进人社厅、文旅厅等重点单位目录整改进度及数据推送情况；
3、核查近期各单位系统问题、云资源关联及权限开通相关事项。
下午：
1、指导省人社厅开通数据库CDC配置；
2、协助人社厅完成业务库新增字段、新增触发器及新增表的权限开通工作；
3、配合配置实时更新归集任务，确保数据能够实时同步归集；
4、处理部分厅局日常支撑事项，及时响应零碎问题需求。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、医疗大数据清洗项目，项目三方软测报告评审，协调资源现场安装部署验收演示环境；
2、残疾人康复中心配套设施采购项目，根据客户要求，完善PPT汇报材料内容；
下午：
1、省统筹平台（一期）项目卫生资源和应急值守系统运维群用户使用问题答疑解决；
2、省统筹平台（二期）项目二期流调系统升级优化需求完成进度跟踪。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：                                                          1：2026-2027年xc实验室能力建设及支撑服务项目服务考核表用印支撑             2：常州分公司-某施工项目合同补充协议合同用印支撑                    3：信息系统业务安全服务资质及证书变更申请表用印支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：准备会议材料-升级解决方案人工智能（AI)信创系统复刻、打印部门材料、收集售中组周报和软集工作周报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：宿迁港中心港区陆运河作业区陆集中心港一期工程智慧化项目反质疑相关事宜处理；精品案例时空智能城市建设项目材料梳理、编写；
下午：精品案例时空智能城市建设项目材料编写','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','2026-056请购流程审批会签支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','研发费用计提流程，修改后重新发起；
预估工作量收入情况分析','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、梳理工业虚拟团队月底工作目标；
下午：
1、引流商机回访（市场部反馈，经确认为无效商机）；
2、沟通宿迁公司，探讨麒麟商场AI方案内容事宜。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.支撑常州内部合同流程
（江苏移动信息系统集成有限公司某施工项目 用印、扫描、寄送）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','淮安JCB-2026-061、JCB-2026-067项目投标支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：保密项目管理系统bug沟通，督促摩卡修复','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：江苏院辽宁院项目支撑对接，支撑验收材料及盖章等流程；
下午：商贸生态能力图谱梳理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：行业二组周工作量及地市项目支撑数据收集；合同盖章用印及流程支撑','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：1）公安厅数据赋能项目质保期倒挂事宜讨论沟通；
2）法院一张网项目询价；
下午：1）江苏省港口集团业务网络专线集中采购项目两个标段，投标文件制作及修改。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1，商务厅智慧商务综合管理平台国产化改造项目，和厂商沟通讨论项目计划；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、数字人大合同附录编制；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、FDE人员分级反馈，向综合部；
2、FDE激励方案审核反馈；
3、参加政绩观学习教育-书记党课；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：1.江苏中烟工业有限责任公司2026年总部计算机及相关设备、软件采购项目：与联想完成售前选型沟通，同步梳理信创设备投标所需的证明材料，并完成投标文件首轮审核。
下午：1.江苏中烟2026年智算设备租赁服务项目：根据最新需求完成算力卡、国产CPU及配套网络设备的售前询价，整理近3年ICT公司算力服务相关业绩，核对最终售前询价报价，完成报价文件定稿。2. 江苏中烟工业有限责任公司2026-2028年总部信息化基础环境系统运维服务项目（标段二：终端运维）：梳理二次投标注意事项，同步准备并完善二次投标文件。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1.新商机挖掘：针对省疾控平台AI平台项目，与客户汇报与需求对接，初步明确了合作方向，后续将跟进具体需求清单。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1. 对齐麒麟例会下周汇报方向，精简了汇报模版结构，重点突出核心指标与待决策项。
2. 全力推进CCIA资质换证，今日重点优化了申报材料的佐证链，抢在到期前消除合规风险。
3. 针对室内工作重难点进行复盘，并探索用数字化手段减负，已拟定“自动督办小工具”的功能雏形，后续将加快落地测试。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：JCB-2026-056/JCB-2025-158项目采购支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：部门支撑本周周报整理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：苏政源项目支撑。定位卫健委客户反馈的异议系统无法正常浏览的问题；解决民政厅反馈的在门户工作台上无法看到异议工单的问题；','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：参加与南京大数据集团可信数据服务公司就世界模型在农业农村厅项目落地交流会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：常州妇幼高质量数据集汇报现场支撑
下午：常州妇幼高质量数据集现场汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.配合科技厅完成目录下线和目录修改
2.协助省外办在苏政源上完成数据资源申请并解决账号问题
下午：
根据苏政源各模块情况，梳理运行管理月报指标','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会，同步项目今日进度与计划。
2.继续推进在线表格2BUG+6优化事项。
3.完成后向能力比选文档并提交战客中心，推动后向厂家确定工作。
4.与华为进行智能体速度、准度技术交流，严判其能力是否可以提升客户使用感知。
5.测试人员到现场进行测试工作，预计2天时间完成一轮完整测试。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、上午完善公安苏小智项目生态比选报告；
2、下午在公安项目现场，与华为交流deepsearch和上下文技术方案；了解华为、阿里昨天与客户交流汇报情况；
3、下午参与验证公安苏小智项目演示版本“2+6”项遗留功能上线情况。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、下午赴保密局领取项目自查自纠通知文件；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.和省红十字会技术人员对接，确认数据库数据项
2.帮助省委老干部局处理挂接资源问题，回复相关问题
3.核对部门库表数据量，处理数据量异常情况。
下午：
1.完成客户交办工作，整理高价值数据贴源库数据量
2.撰写省级部门质量报告月报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：编制省高院执行局相关平台调研方案，梳理平台调研目标、调研范围与实施步骤。结合执行局业务实际需求，明确调研访谈对象、重点调研问题，规划资料收集、现场走访安排，完善方案框架，持续优化方案细节，保障后续调研工作有序开展。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：万物智联大赛申报材料撰写工作，围绕项目核心创新点梳理内容，完善项目技术方案、应用场景、优势亮点等板块。核对材料填报规范，打磨文字表述，查漏补缺，持续优化内容逻辑，推进大赛申报材料定稿筹备。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：徐州分公司鼓楼某单位HZL小区智能化ICT项目合同重新提交问题同客服沟通；J营线上办公解决方案完善并上架','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：外部专家26年1-7月各地市待摊、26年全年各地市待摊数据确认并反馈省政企；第八批外部专家信息汇总审核','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、常委会第二天保障，巡检三端新闻模块；2、协助医保总集卫宁开展MZ_004门诊统筹数模跑数工作。
下午：1、医保两批线索汇总统计；2、跟踪医保项目验收进展；3、协助合作公司完成线索梳理工作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1.初步分析判断镇江公积金系统信创改造项目、扬州综合保税区智慧园区建设项目需求，分别完成相应能力资源适配调度。

下午：
2.推进跟踪水站、空气站、噪声站等自动监测站运行维护项目、污染源在线监控运行项目进展跟踪，完成闭环。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：
1.党政行业周报整合填报。
下午：
1.党政行业公共事务支撑（7.30一点调度新增工单台账维护、党政行业一点调度工单周报统计反馈）
2.班组日常公共事务支撑','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：麒麟平台场景方案上传AI+具身教学等3个场景方案、更新智慧教育云平台方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、与陈主任沟通对常州工勘院打印模板设计、流程优化调整；2、处理网站无法发布信息、列表页无数据显示问题修复处理。
下午：1、协调处理隧道公司网站显示问题修复；2、核对已完成OA、网站系统功能确认函收集整理，未收到已沟通。3、沟通联合征信区块链项目验收事宜。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、沟通SM项目及载体，资料相关流程事宜。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：与春燕讨论智慧食堂人员、卡号、照片与一体化比对方案；
下午：向陈高总汇报调度会材料；根据陈高总、沈总意见，修改汇报材料；调整PMS对接待协调事项的方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：与客户交流普瑞赛司方案与宝信软件国产方案，客户表示普瑞赛司方案磨抛质量一般，愿意就宝信软件方案深入交流，计划下周协同宝信软件和客户汇报方案细节。
下午：支撑太仓“AI+制造”诊断项目，协助地市公司析标。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：梳理工业制造AI项目自有能力及生态能力，为政企汇报材料提供依据。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.梳理项目需求证书，编辑激励方案
2.党建、工会对接事宜','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1、日常服务器巡检，一切正常；
2、常委会现场保障，一切正常；
3、处理南京市账号问题若干；
4、处理常州市账号问题若干。
下午：
1、处理兰领导无线网络相关事宜；
2、处理南京市区账号问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','污染源在线监控运行项目，就技术规范中的运维响应时间、数据采集频率、设备校准周期等关键参数，与项目经理沟通对接。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、标准ICT项目场景典配清单更新，团队进展同步、生态对接；
2、一点调度工单梳理反馈。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','solution-design','owner','1.商务厅网络安全设备项目标书审核，商务资质核对，跟客户沟通技术参数要求。
2.江苏电信交易监管系统开发服务采购项目标书审核，核对技术要求。
3.应急厅运维项目招标文件被代理打回，过一遍修改意见，带明天讨论修改方案。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1、江苏紫金农村商业银行股份有限公司珠江支行/太平支行两个安防工程项目现场投标支撑
2、江苏农牧科技职业学院大数据中心及数据治理售前支撑
3、全省教育行业商机梳理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、参加XC专题会，收集沟通地市周五XC培训名单','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、参加数据归集日例会，联系支撑部门省残联的mysql库中新增开放若干权限给苏政源平台；
2、支撑客户完成系统的权限管理，日志管理和数据备份展示，并整理相关材料反馈给内部审计团队；
下午：1、整理材料提供给内部审计团队；
2、支撑教育部通过国办平台-公共数据平台-教育厅，教育部通过国办平台和公共数据平台将教室资格相关数据提供给教育厅；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','人社厅数据体系规划设计项目：进一步完善人社厅数据体系规划设计PPT，完成规划大纲word文档，与生态沟通后期规划材料编写计划等','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='王达伟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','惠山交安项目支撑
常州交控高速项目支撑
淮安多式联运项目支撑处理','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王达伟') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','标准ICT事宜对接各部门协调处理
创新工作例行处理
麒麟平台关于政策等对接处理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天:招商银行南京分行数字化服务运维外包人员项目，项目析标，拟定驻场人员明确项目风险，投标文件框架搭建，商务材料搜集；江苏省农商行防火墙项目，厂家现场对接参数，表示合作意向','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-TEST-08'),'project-support','bid-quotation','owner','1、江苏省商务厅网络安全设备与 LED 屏采购项目相关工作：一是落实投标文件用印报审流程；二是依据评审意见修订完善投标文件，对接厂商更新技术参数佐证材料；
2、江苏省消防救援总队2026-2027年度信息化及卫星通信网运维服务项目根据客户意见修改采购需求；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天：
1、支撑常熟市数据局、省市监局、淮安行政审批局组件迁移对接工作；
2、整理组件超市门户联机帮助文档中关于组件上架和审核的文档，对接门户帮助中心人员填入；
3、优化组件超市项目初验文档，按要求对数据库设计说明书进行修改；
4、测试OCR组件营业执照接口，整理测试结果。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、淮安公司3个特殊项目导入导出等现场支撑；
2、徐州公司1个特殊项目导入导出等现场支撑；
3、省战客某融合创新项目商机支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：
1、同保通薄正喜沟通应用服务平台统计指标，采集相关数据；
2、将采集数据整合到质态评估材料中，优化相关内容；
3、人员根夜间定时任务仍执行失败，再次启动人员根相关任务；
下午：
1、同客户沟通协调登录烽火数据治理平台，采集数据更新到质态评估报告中。第二版报告已发给客户；
2、针对数据治理平台人员根任务失败的问题专项处理，编写测试任务；
3、关停原有的大量无效任务，调整人员根任务执行时间，任务恢复执行成功。待次日观察相关任务执行状态后向客户汇报。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1. 人社厅数据体系规划支撑；
2. 连云港政务云项目支撑；
3. 连云港国资一张网投资系统成本支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1. 标准ICT项目场景封装工作进展与问题汇报；
2. 跟进SM项目进保密室前置检查升级','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、信创全省培训组织协调
2、AI复刻厂商生态交流','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','信创团队与AI虚拟团队专项汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1. 12345投标情况跟进；
2.智慧发改一体化平台汇报材料支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：请假
下午：中烟工互项目：对徐州卷烟厂进行边侧账号分配；与客户同步建设方案编写情况；与阿里沟通概设编写情况；学习边侧软件计算属性规则划分；
智慧水务3D建模项目：跟进项目阶段进度，已对业主完成项目培训，进入试运行阶段；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','1. 推进江苏省气候中心人影工程项目投标前期工作：完成项目报名材料编制、盖章事宜；对接招标代理机构获取招标文件，初步梳理文件关键要求；同步与客户经理沟通项目细节，明确项目推进思路。
2. 对接应急厅客户开展标书优化工作：客户反馈代理审核版本文件，针对文稿内容开展调整优化；完成资质材料替换、文字表述修订等工作，保障招标合规要求。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：编写、整合智慧发改一体化平台交流材料','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：灵犀晓伴平台技能上传及调试','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：1、江苏省港口集团有限公司业务网络专线集中采购项目-业务专线标段，投标文件整合，定稿。
2、江苏省港口集团有限公司业务网络专线集中采购项目-视频专线标段，投标文件整合定稿。
下午：江苏省港口集团有限公司业务网络专线集中采购项目，和战客行业室经理一起过投标文件，根据领导意见完成标书修改，技术方案修改
。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:
1.商讨同一个目录在治理平台未从老流程切到新流程，导致统计指标数据量差值较大问题；
2.对于贴源层表结构有变动的表，删除标准表、异议表和归集表，并修改对应的离线采集任务。
下午：
1.按表名查询是否贴源层表结构有变动，并重新创建标准表，修改编排流程，重新进行数据治理。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：宜兴普通国省道路网监测项目支撑
下午：镇江市普通国省道路网监测项目支撑；腾龙大道智慧快速路项目支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：标准ICT项目场景方案','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：梳理麒麟平台中录入的制造业生态，收集生态在对应国民经济小类中的解决方案以及典型案例，补充到小类覆盖情况表中。
下午：统计本周生态覆盖新增情况以及细分领域场景方案新增情况，补充到周报中；统计本周制造行业一点调度工单情况；搜集工业制造AI项目技术文档，为政企汇报材料提供依据。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午:
1.和厂家沟通食堂老系统人员信息及用户余额如何匹配；
2.梳理智慧食堂上线前需要处理的问题；
下午：
1.准备项目调度会智慧食堂汇报材料；
2.跟进食堂单点登录和用户导出功能报错问题。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','江苏省12345项目:今日完成开标工作，配合业主完成合同相关内容修改
两平台项目:针对前期规则数据验证阶段发现的各类问题持续开展修复整改，整改工作当前整体进度 50%。整改过程中遇到技术阻塞问题，现阶段正集中排查、处理卡点，扫清修复障碍，计划于明日完成全部问题整改闭环。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：知识库embedding模型实测，部署测试。
下午;1、ai团队进展汇报。
2、ai问答流式回答机制设计，分块策略探索。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：编写疾控省统筹平台“六优项目”申报材料；
下午：
1. 编写疾控项目周报；
2. 跟踪智能流调信息系统与急传所上周开会沟通的待办工作事项。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午
1、玄武平台纳管网络策略工单无法办理，沟通政务云工单办理细节
2、数据治理商机，与客户沟通材料大纲及主体方向
3、集成平台信创上云项目，政务云服务器
下午
1、陪同宏图总与客户交流细节
2、根据国办数据共享及省垂系统对接工作安排，填报数据共享需求材料
3、数据治理商机，根据早上客户要求，编写材料
4、绩效系统二季度考核数据录入
5、药生审批系统对接联调','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','苏政源-组件超市
上午：
1、专项任务：协助各省级厅局单位和地市单位的系统人员尽快处理组件迁移的事项，着重解决反馈的对接过程的问题以及网络策略相关的开通。
2、调测OCR组件系统提供的相关接口服务的响应以及识别图片的输出的准确率，配合OCR系统技术人员进行模型的调优工作。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、按照监理单位要求修改组件超市的验收材料。
3、沟通各申请组件的单位人员的首席数据官的系统权限配置事项。
4、继续配合厅局单位系统验证OCR接口的识别的准确性和响应时间。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：编制龙渊智算AgentOS研发项目立项材料，对接相关扎口人明确技术内容要点
下午：对接组内周报事宜','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：1.处理中石油站点故障。2.省消防跟进出具排期计划。3.沿海集团验收资料流程整体
下午：1.辅助检察院新来员工，介绍相关系统功能模块。2.确认检察院明日安全测试人员工作安排，确保明日安全测试顺利开展。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='陈苏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：“数字人大”XC改造项目招标文件修改
下午：1、“数字人大”XC改造项目泛微、摩卡、奇安信、永中4家厂家压价沟通
2、省级枢纽管理“三统一”平台项目受托代销流程跟进，标后合同流程支撑','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈苏') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：组内培训课题收集，ppt准备工作跟进','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：1.常委会第二天保障，巡检业务和服务器
2.根据客户需求调整委员会处长权限
下午：1.核对档案接收库未整理档案条目
2.指导委员会档案员进行档案条目归档
3.督促厂家解决档案批量导出没有六格章问题','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-30'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 协助客户准备江苏省属企业人工智能诊断评估自评表及证明材料。
3. 协同江磊准备客户领导调度会汇报材料。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：支撑扬州保税区智慧园区项目，整理方案，对接生态
下午：支撑连云港国资项目，沟通投资模块的工期计划和细化报价','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午:公安精品案例更新','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：新扬子，新时代8大领域40细分场景梳理','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='黄思华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-30'),'afternoon',(select id from projects where code='JUL-TEST-05'),'project-support','requirements-analysis','owner','上午:
1）高招中心评阅卷项目后向协调
2）864项目直播需求沟通
3）协调军总运维项目踏勘事宜
下午:
1）疾控客户交流AI中台和运维平台
2）省人民慢病管理项目与研发部、产品中心需求沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-30',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-30'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.沟通大学生竞赛项目验收条件和验收进度；
2.参加环保项目早会；
3.与环保人力客户沟通人力系统存在问题及建设推进会ppt修改意见；
4与环保投资后向厂家沟通系统站内消息优化。
下午：
1.复测投资系统之前发现的问题是否修复；
2.按专班意见测试人力系统子公司权限分配；
3.与发改客户同步服务器缩减最新进度。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='丁德胜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1 盐城四院 心理健康小屋项目方案支撑
2 重庆医科大学附属一院智慧后勤平台项目需求与招标方案析标','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁德胜') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1 成研院AI 智慧医疗应用产品交流
2 医药制造领域生态厂商能力交流','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='丁金龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','下午：镇江集采项目进度沟通，投标前准备工作支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='丁金龙') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：参加基于实战项目的信创能力培训','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='付园园'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1、江苏中烟工业互联网项目工业专班汇报材料的编制；2、持续支撑淮阴卷烟厂制丝线升级改造电控集控及智能化系统建设项目的生态厂商对接。在与云衍智能的接洽中，表示可联合生态伙伴共同承接，但需明确成本核算；另外，云衍也同步反馈该项目已有内定承建方（昆船）。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='付园园') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：参加工业专班会议以及天工平台培训','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='倪静'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='倪静') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、编写一体化员工专业认证激励方案，输出初稿；
下午：1、优化“一点调度”自有产品协同交付子流程需求文档v1.0，结合融入FDE相关内容；2、会议讨论月工作量收集汇总校验工具各项功能，测试功能并提出完善点','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘延明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：社科联上门支撑智能编目和数据归集，档案馆库表主键二次确认及维护。
下午：一本账系统问题核查处理；教育厅云网对应关系核对；司法厅、省作协、省委办公厅一本账登记的系统名称与真实的系统名称核查；更新各单位对接工作每日进度台账。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘延明') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：2026年惠山区“5510”道路交通安全隐患整改提升
工程（智能交通设施）支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘志栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘志栋') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','环保集团：
1. 项目晨会，对齐采购系统、法律法规系统建设进度；
2. 采购系统、合同系统功能全量测试；
3. 整理商机、采购、合同系统全流程；
4. 配合甲方进行测试，指导其进行操作。
本周各类工作占比：客户交流沟通与内外部协调20%、编写文档10%、项目专项工作70%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘斌'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：连云港数据汇聚平台+数据产品加工运营平台项目沟通支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘斌') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：AI领域考证介绍PPT完善，计划下周进行部门介）','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘月'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘月') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：
1、工业行业海澜之家项目8大环节40个场景生态图谱编制；
2、工业视觉检测专业厂家西安获德生态合作交流。
下午：
1、教育行业麒麟平台行业建设专题汇报材料编写；
2、工业行业专班会议，2.5h。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、处理江苏机关党建云党组织负责人反馈的问题，包括党费数据核对和党组织信息核对，保障系统8月份正式上线使用
2、申请老干部局云平台密评所需材料的技术协助工单
3、苏政源项目协助验收资料准备，包括实施方案、项目管理规范、需规','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘涛') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全省每周签约数据汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘炜'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘炜') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1、梳理供需填报内容，熟悉填报平台，支撑林业局进行国家供需填报；
2、收集公共数据平台运维服务、系统变更、信息安全、账号权限等方面的审核佐证材料；
下午：
1、协助教育厅进行数据上行推送到教育部；
2、支撑无锡进行国家平台门户的访问；
本周各类工作占比：客户交流沟通与内外部协调30%,系统维护30%,客户交办专项工作40%。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘玲') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1.和成研现场交流对接ai智慧医疗解决方案；2.协同成研院支撑南京中医院AI中医项目，输出交流及建设解决方案；下午：1.重庆医科大学附属第一医院智慧后勤信息化管理系统项目招标文件解析以及商务支撑资质梳理；2.数据要素大赛决赛资料编制；','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘立军'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、淮安四个国货国用项目标前汇报。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='刘立军') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、沟通讨论涉密团队第一版汇报内容，明确优化和需要调整的内容。
2、按照沟通讨论的要求修改汇报内容。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='刘茜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='卜文豪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：成研医疗行业ai产品应用交流，信创培训
下午：工业专项会议','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卜文豪') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','紧急救援基地项目建设内容梳理及生态沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='卞月林'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='卞月林') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源数据治理项目支撑。
上午：1、梳理数据局、应急厅、生态厅、省法院等部门新增归集的数据，并开展数据治理任务；2、继续排查无锡一表通人员数据未同步问题：归集模式调整未适配原因；3、与客户沟通异议工单内部闭环的需求；4、人员管理：总体组人员考勤、入场、离场、规范等检查；
下午：1、解答客户法人数据智能问数相关市场监管数据治理工作；2、编制脚本筛查目录归集系统未同步给治理的任务并排查问题；3、基础库-统一数据运营对接沟通；4、支撑统一数据运营演示，配置归集-运营全流程；5、社保信息解密后治理工作事项；6、处理市场监管抽取对象贴源库数据不一致问题；


客户交流沟通与内外部协调 35%
(主要涉及：归集-治理-异议数据闭环方案讨论、人法信及基础库统一数据运营对接沟通、一本账数据质量综合指数需求沟通、地市一表通人员数据治理情况向客户汇报、异议工单内部闭环需求沟通、解答法人数据智能问数相关问题等)
系统部署与故障分析 25%
(主要涉及：排查并处理无锡、徐州、盐城、宿迁等地市一表通人员数据未同步及推送失败问题、处理治理-异议系统对接接口不通问题、排查归集模式调整未适配原因、处理权限配置及登录问题、编制脚本筛查未同步任务等)
产品设计 15%
(主要涉及：异议数据处理流程设计、评审并整改数据治理需求规格说明书、评审分析人法信基础库数据开发模块菜单需求、沟通并跟进时空地理质量规范征求意见和修正情况等)
编写文档 10%
(主要涉及：数据治理用户手册材料调整、修正模型设计规范、修正数据全流程处理实施方案、整理地市一表通人员数据治理情况汇报材料等)
风险管理与计划控制 10%
(主要涉及：梳理多部门新增归集数据并开展治理任务、沟通部分历史数据归档不治理事项、处理教育部及社保信息解密方案与事项、人员管理考勤及规范检查等)
系统维护 5%
(主要涉及：处理广电局目录信息不一致问题、处理农业农村厅行政处罚信息治理完未通知共享库问题、处理市场监管抽取对象贴源库数据不一致问题、配置归集-运营全流程支撑演示等)','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='叶小舟'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='叶小舟') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：省政务云租赁服务项目精品案例资料搜集和内容编制；人社就业援助平台解决方案资料搜集
下午：省政务云租赁服务项目精品案例资料搜集和内容编制；党政生态可用性定期维护在线文档政务等子领域整体统筹；人社就业援助平台解决方案资料搜集和内容编制','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='吴承云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴承云') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.持续跟进数智发改扩建一期工程NAT网关申请与入访策略审批进度；
2.参加政企条线信创人员能力提升培训；
下午：
1.持续跟进各项目组护网行动自查自检自纠整改闭环情况；
2.参加政企条线信创人员能力提升培训。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='吴浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴浩') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天：情指行地市项目调研模版沟通定稿；
情指行下轮交流素材整理，汇报PPT框架制作','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='吴海宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='吴海宁') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、AI团队成果汇报。
2、月报审核系统效果测试。
下午：1、安徽智生通信AI程序复刻交流
2、日报审核系统规则修改；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='周俊凤'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周俊凤') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','1.上午：梳理数字人大一期性能需求提供信创项目招标材料参考；搜集数字人大省市县项目签约情况，外部宣传材料，整理23年业务创新奖后评估材料；
2.下午：整理授权运营2.0 UI标准规范，整理需规等素材；组织厂商项目组专题讨论OCR营业执照等问题及梳理近两天计划安排；跟踪组件申请情况，拉通申请部门对接。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='周菁'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='周超'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='周超') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、淮安烟花爆竹安全生产风险监测预警系统项目支撑；
2、省消防总队119视频接警能力建设项目支撑；
3、面向突发事件的5G-A预警应急通信和指挥调度处置应用项目绽放杯路演PPT材料编制。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='唐展'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','下午：东航 CVR项目，语音标注进展同步跟进','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='唐展') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：参加基于实战项目的信创能力培训','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='孙晓星'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙晓星') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、智慧发改一体化平台项目汇报支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='孙璐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','疾控省统筹平台（二期）项目驻场，参与周例会专项工作推进进度与项目架构掌握。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='孙璐') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','全天：1、麒麟平台日常工单审核
2、麒麟平台内超期未更新资源汇总
3、更新周报一点调度行业支撑数据
4、麒麟能力商城生态推介汇总

本周各类工作时间占比：项目驻场学习10%，部门专项工作90%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='崔悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='崔悦') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1. 数据归集：(1) 数据归集小组每日例会 (2) 协助省药监局添加缺少的数据项。
2. 敲门行动：(1) 核对市监局66个系统名称与访问地址是否正确 (2) 联系省检察院更改系统访问地址。
3. 组件超市：对接省政协服务器时间问题。
下午：
1. 敲门行动：(1) 核对53个系统名称与访问地址是否正确 (2) 联系退役军人事务厅、省文联、烟草专卖局、省药监局、省委金融办、省委宣传部、组织部7个部门逐个核实系统名称问题，并协助他们修改。
2. 组件超市：联系省自然资源厅添加首席数据官

本周工作时间占比统计：
客户交流与内外部协调：40%  项目内部系统对接：10%  系统问题处理：10%  编写文档：40%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='常允城'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='常允城') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源-敲门行动
上午：
1、参加数据归集每日例会，梳理当日工作安排，同步各单位数据归集与整改推进情况；
2、继续核查并跟进各部门数据表主键问题，生成主键核查表；
3、针对清单质检核查出的问题持续推进人社厅、生态厅、文旅厅整改工作。
下午：
1、协助省人社厅办理数据资源申请相关事项；
2、协助人社厅完成目录挂接资源更新工作；
3、更新各单位对接工作进度台账，整理本周问题及整改进展。
本周各类工作时间占比：客户交流沟通与内外部协调：50%、系统部署与故障分析：15%、风险管理与计划控制：15%、编写文档：15%、系统维护：5%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='应万峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='应万峰') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、参加疾控省统筹平台（二期）项目周例会，汇报演示各业务系统当前进展及协调事项；
下午：
1、省统筹平台（二期）项目，症候群和舆情监测系统沟通厂商当前进展和梳理问题困难点，推进实施进度；
2、医疗大数据清洗项目，和客户沟通终验时间，同步验收文档准备情况。
本周对接省统筹平台（二期）、医疗大数据清洗项目、残疾人康复中心配套设施采购项目和临床研究患者精细化数据采集系统项目共4个项目，现场会议（包括周例会、需求对接会，进度汇报等）30%，客户及厂商沟通与内外部协调资源30%，编写文档和周报材料20%，风险管理与计划控制20%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='张加勉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张加勉') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：打印材料、文件管理系统-老印章系统要下线，备份原软件部署包                                          下午：做省公司政企部2026年ICT省级项目派驻支撑（第一批）收入和成本计提报账单、处理部门内部报账问题、处理OA系统报账代办','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='张正一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张正一') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','上午：宿迁港中心港区陆运河作业区陆集中心港一期工程智慧化项目支撑；腾龙大道AI+服务项目支撑；
下午：麒麟平台精品案例时空智能城市建设项目材料编写、PPT编写及上架','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='张沈玲'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','2026-069商机沟通，投标前准备工作支撑','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张沈玲') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','特殊团队汇报工作内容修改，各类数据支撑；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='张涛'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张涛') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、梳理工业行业重点客户40大场景：
2、同市场部讨论商贸行业生态结构划分及补充方案；
下午：
1、沟通无锡、昆山、张家港等，商议中小企业平台麒麟入口推广事宜；
2、协调研发二部统计中小企业引流数据。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='张贵民'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张贵民') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','淮安JCB-2026-067、JCB-2026-068项目投标支撑','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='张雪雅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-TEST-12'),'project-support','solution-design','owner','下午：梳理麒麟平台现存方案内容，细化商贸行业生态结构划分及补充方案；','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='张雪雅') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：二组本周工作量及周报收集，梳理本周项目支撑情况，梳理7月整体项目支撑及中标数据','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='徐剑宏'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐剑宏') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：1）公安厅情指行客户需求讨论沟通，修改二次交流PPT框架；
2）JW运维项目客户拟邀请我公司投标，因我公司不具备SM运维资质，已和客户经理及客户说明相关情况；
下午：1）江苏省港口集团业务网络专线集中采购项目2个标段修改及审核投标书。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='徐博文'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='徐博文') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1，药监局配合院方开展执行HW专项行动检查；
2，落实药监内网Https+域名申请情况；
下午：跟进讯飞东航的数据标注进度。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='戴云平'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='戴云平') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、参加信创培训；
2、晓庄驻场租赁费支出方式讨论；','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='施翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='施翔') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天：
1.江苏中烟工业有限责任公司2026年总部计算机及相关设备、软件采购项目:全面梳理并核验所有投产品的资质证明文件，确保资料齐全合规。完成投标文件的整合汇编，并进行两轮内部审核最终定稿。
2.江苏中烟2026年智算设备租赁服务项目:完成算力及网络设备的租赁成本测算与初步报价，同步准备相依报价支撑材料并与业主方进行沟通说明。询价报价文件现已定稿、打印盖章，并按规定流程正式提交至业主单位。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='曹雯莉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1、疾控项目例会：按时参加疾控中心项目周例会，同步项目整体进展，识别近期风险项。
2、滞后系统推进：针对部分系统进度滞后问题，已与厂家召开专项沟通会，明确卡点原因并商讨补救方案，推动恢复正轨。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='曹雯莉') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、算力资源申报：推进室内算力资源申报工作，已完成需求摸底与初步配额核算。
2、麒麟商城生态对接：梳理能力商城生态推荐清单与核心卖点，与行业经理完成对接沟通及推广动作。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='李孝雨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','下午：JCB-2026-074项目商机沟通、投标计划安排','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李孝雨') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：行业一组项目周报收集整理、汇总二组数据填写行业部周报
下午：行业一组部门简报处理','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='李岩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李岩') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：苏政源支撑。联系卫健委客户继续定位浏览器打开系统出错问题；批量自查数据库的异议工单，仅保留真实工单，删除全部测试工单；
下午：苏政源支撑。与客户开会讨论关于异议流程改进的提议，目前的流程没有经过内部自查就直接发给数源部门，是有问题的；','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='李悦'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李悦') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：1，成研所AI产品案例交流
下午：1，生态（上海森亿智能）方案沟通，预约线下沟通时间。2，宿迁妇幼保健院智慧医院项目跟进，今日已完成现场汇报，待客户反馈（申请预算）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='李晶'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李晶') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：
1.配合处室人员统计省农业农村厅和生市场监督局历年的申请和被申请资源情况，并梳理明细数据
下午：
1.协助处理省外办在苏政源订阅资源遇到的数据项不一致等问题
2.协助科技厅定位并解决业务库数据为0等问题','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='李鑫'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李鑫') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','今日全天在省GA现场推进省GA智能体项目；
1.召开项目组晨会，同步项目组今日工作。
2.进行系统测试工作，今日完成全部测试工作，测试报告及问题记录文档周一输出。
3.针对客户提出政保新需求已提请战客中心评估是否响应。
4.本周完成2BUG+6优化事项。
5.向陈支、孙主任、戴主任汇报近期项目进展，并沟通最新版本客户端升级时间。
6.修复测试过程中遇到问题。
7、提请战客评估项目下一阶段计划。

本周各类工作时间占比：客户交流沟通与内外部协调40%、编写文档20%、风险管理与计划控制10%、需求分析与汇报10%、交付与测试20%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='李锡明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、全天跟进启明星辰在检察院现场对两项Web服务（地图转换、舆情抓取）的安全检查工作进展（预计今天完成，下周提供报告）；
2、上午完善公安苏小智项目生态比选报告并邮件战客审核，预警项目风险。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='李锡明') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、上午参加省公司法务部会议，根据网信安要求讨论检察院个人话务信息的报备和整改举措；
2、下午参加工业专班例会；
3、下午完善行业一部部门周报。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='杨一'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨一') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1.和省红十字会技术人员对接，确认数据库数据项
2.帮助省委老干部局处理挂接资源问题，回复相关问题
3.核对部门库表数据量，处理数据量异常情况。
下午：
1.完成客户交办工作，整理高价值数据贴源库数据量
2.撰写省级部门质量报告月报
客户交流与内外部协调60%、编写文档30%、系统维护5%，风险管理与计划控制5%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='杨杨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：推进省高院执行局平台调研方案编制工作，结合执行业务场景明确调研目标、调研对象与实施流程，梳理平台现存痛点、业务需求清单，细化走访安排、调研提纲，持续调整方案架构，完善各项实施细则，为后续实地调研落地筑牢基础。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨杨') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：组织召开月度例会，联动多家物联网厂商开展交流沟通。会上对接产品技术能力、落地适配方案，收集厂商方案建议，梳理供需匹配难点，记录沟通关键信息，同步后续对接要求，推动物联网相关合作事项有序推进。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='杨煜倩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨煜倩') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','全天：内外部专家入库情况、专家调用情况、平台及流程建设情况统计分析；第八批外部专家信息审核等级评分','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='杨瑞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='杨瑞') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','病假','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='殷文杰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='殷文杰') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：1、医保反欺诈项目验收材料整理，根据审核结果进行优化
2、飞检线索整理
3、协助常委会第三天保障工作，巡检人大项目新闻模块。
下午：1、飞检线索梳理并提交。
2、医保项目质量管理计划文件、培训手册补充。
3、协调厂商沟通关于后续人员安排问题。
本周各类工作时间占比：客户交流与内外部协调30%、编写文档30%、系统维护20%，风险管理与计划控制20%','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='毕爱梓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：
1.扬州综合保税区智慧园区建设项目进展跟踪，跟踪支撑时限延期原因。
下午：
2.常州水站、空气站、噪声站等自动监测站运行维护项目、常州污染源在线监控运行项目支撑情况跟踪及同步地市评价确认。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕爱梓') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：
1.党政行业1-6月累计发展维护更新。
下午：
1.党政行业公共事务支撑（7.31一点调度新增工单台账维护）
2.班组日常公共事务支撑','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='毕雪'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','下午：江苏农牧科技职业学院数据治理项目支撑，项目析标，分析招标文件商务资质得分情况。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='毕雪') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-TEST-12'),'special-work',null,'owner','上午：支撑苏州地市内部合同流程发起；麒麟平台缺失能力工单审核、政策工单审核等','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='江爱'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：与厂家电话沟通对软测问题进行优化，准备第三次复测。
下午：编写江苏省地质局“一门户两平台”项目审计情况材料。下午：准备调度会汇报材料相关 ppt 证明。下午：','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江爱') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、全天参加信创专项培训
2、对接网信安全要求，紧急确认包含提供给工信部、管局、工信部下属支撑单位以及其他部委办局等数据相关要求。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='江磊'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='江磊') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：对接监测监控公司AI财务预警的应用，与技术方讨论天眼查接口对接。下午：准备地质局审计材料，梳理项目调度会 ppt 材料，讨论门户首页关注事项指标','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='汤梦寒'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','全天：太仓“AI+制造”诊断项目支撑，协助地市公司析标，与工信沟通控标策略。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='汤梦寒') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：参加工业专班会议。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='沈云'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沈云') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.梳理项目需求证书，编辑激励方案
2.党建、工会对接事宜','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='沙政兵'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='沙政兵') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、日常服务器巡检，一切正常；
2、常委会重保，一切正常；
3、配合代表进行代表学堂的课题上传；
4、处理镇江账号权限问题。
下午：
1、处理档案系统涉及二次开发的费用讨论；
2、处理客户软key问题。
本周对接江苏数字人大系统，系统维护30%，客户交流沟通与内外部协调30%，故障分析处理25%，风险管理15%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='洪玉'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='洪玉') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','部门周报试点地市专项材料梳理；市场部一点调度流程对接；标准ICT项目工作推进','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='王帆'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','requirements-analysis','owner','1.商务厅网络安全设备项目标书复审。
2.环保厅联网平台项目，沟通后向厂家，讨论给客户提供初版材料的注意事项。
3.应急厅运维项目招标文件讨论修改方案。
4.国家统计局江苏调查总队四农普项目重新招标，比对与前次招标需求不同点。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王帆') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','月度例会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='王思乐'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王思乐') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、参与组织全省XC培训
2、连云港转研发项目上采购三重一大会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='王改霞'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王改霞') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：1、参加数据归集日例会，跟进广电局和市场监督管理局专项信息填报部门复核文件上传；
2、协调解决教育部通过国办平台和公共数据平台将教室资格相关数据提供给教育厅过程中上下行接口网络不同的问题；
下午：1、统计昆山市申请港澳台居民居住证信息核查、比对资源的申请情况反馈给客户；
2、再次修改一季度&二季度考核工作总结报告并将终稿发送给客户；','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='王海娜'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='王睿栋'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王睿栋') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','人社厅数据体系规划设计项目支撑：完善进度计划，与人社厅信息中心初步沟通设计规划和word大纲','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='王雪峰'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='王雪峰') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','全天:招商银行南京分行数字化服务运维外包人员项目，组织战客开会析标，确定驻场人员资质以及人员业绩，投标文件技术方案编写（人员团队方案人员稳定性方案等），慧投商务材料搜集并下载，与商务对接人确定ict人员毕业专业方向，找寻适合匹配岗位人选','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='田金川'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='田金川') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-TEST-08'),'project-support','bid-quotation','owner','1.江苏省商务厅网络安全设备与 LED 屏采购项目相关工作：跟进三家厂商授权函及报价；根据招标文件相关要求进行投标文件会审，并根据会审意见修改完善投标文件；
2.参加省直驻场组月例会。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='申士'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='申士') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','全天：
1、支撑苏州吴江区行政审批局、省市监、政协一体化、省自然资源厅组件迁移对接工作；
2、协助优化组件超市初验文档；
3、测试OCR组件身份证识别、营业执照识别性能，整理测试结果，协助OCR模型性能优化工作。

本周沟通协调占比30%，编写文档占比40%，技术支撑、测试占比30%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='祝力'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='祝力') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、徐州公司、淮安公司特殊项目导入导出等现场支撑；
2、无锡公司、盐城公某融合创新项目商机支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='窦文阳'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='窦文阳') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：
1、在没有烽火工程师协助的情况下分析处理人员根另外两个任务执行失败的问题；
2、协调负责数据库的工程师帮忙核查数据库端是否存在问题；
下午：
1、尝试更换接入的数据库，平台报错导致切换不了；
2、继续尝试解决人员根任务异常问题，控制任务固定执行的服务器后问题恢复；
3、向客户汇报问题已解决，由于时间跨度较久数据量大，任务耗时较久。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='肖明'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1.淮安烟花爆竹监控项目支撑
2.人社厅数据体系规划支撑
3.省消防总队三全一大项目统一门户支撑
4.射阳县沿海处置中心信息化提升项目技术方案','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='肖明') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1.组织筹备SM项目流程与资源投入汇报
2.标准ICT项目场景封装工作','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='胡宇'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1、参加XC软件改造全省培训
2、参加AICoding厂家智生通信交流','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡宇') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','XC及AI虚拟团队汇报','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='胡蕾蕾'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='胡蕾蕾') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','1. 组内周报收集整理，更新室内周报
2. 智慧发改一体化平台项目汇报支撑。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='苗数'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='苗数') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午：中烟工互项目与客户、阿里讨论资产建模建设模块编写；与阿里讨论为徐州卷烟厂提供边端软件平台API接口；
下午：汇总中烟工互项目输项目工作周报，梳理需求调研阶段风险预警；沟通建设方案编写情况，协调下周讨论会人员现场安排；输出资产建模目录树及多种属性关联文档；
本周各类工作时间占比：客户交流沟通与内外部协调50%、编写文档20%、风险管理与计划控制20%，公司内部专项工作10%。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='茆胜华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='茆胜华') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','1. 完成省应急厅应急指挥网与机房维保项目招标文件编制，先后开展组内审核、战略客户中心交叉审核，根据审核意见优化调整文稿，完成定稿并交付客户。
2. 参加驻场团队月度工作例会，会上同步各在手项目推进进度；会议安排后续厂商技术培训、研二玄武平台相关培训，并开展技术交流','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='薛新成'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛新成') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','全天：编写、整合智慧发改一体化平台交流材料','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='薛鸿毅'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='薛鸿毅') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','江苏省港口集团有限公司业务网络专线集中采购项目，集中办公，和战客行业室经理一起过投标文件，确定报价，根据领导意见完成标书修改，技术方案修改，完成2个标段最终版投标文件定稿上传。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='袁浩'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='袁浩') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','上午:
1.处理目录与表对应错误问题；
2.要新老目录变更对应清单，并在平台上查询所有目录信息，根据目录id匹配出准确的目录信息。
下午：
1.根据新老目录变更清单，对老流程进行变更，使用新流程进行数据治理；
2.处理质量检测时报标准表缺少字段问题，删除原标准表并重新创建、物化标准表；
3.查看生态环境厅新增的39个归集目录信息，并创建对应的列分析任务。
本周各类工作时长占比:运维实施60%,异常故障分析30%，内外部协调10%','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='许刘晓'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='许刘晓') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午：惠山5510道路交通安全隐患整改提升工程项目支撑；镇江市普通国省道路网监测项目支撑
下午：腾龙大道智慧快速路项目支撑；“数据要素×”大赛材料梳理','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='赵伟凯'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵伟凯') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午：细分领域、生态收集情况统计；优化缫丝加工生产计划优化、缫丝加工车间智能排产场景方案并提交平台；太仓“AI+制造”诊断项目支撑，协助地市公司析标，与工信沟通控标策略。
下午：与苏州浙远自动化和中有信科技生态沟通；太仓“AI+制造”诊断项目支撑，协助地市公司析标，与工信沟通控标策略。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='赵春燕'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='赵春燕') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.测试小牛人脸机和后台服务器网络；
2.继续对接食堂老系统人员信息及用户余额如何匹配；
下午：
1.收集科创系统周报
2.','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='钱晨'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱晨') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','江苏省12345项目:完成项目合同事宜对接，及多厂家实施对接
两平台项目:当前首批规则问题整改进度提升至 80%，已完成及时性、覆盖面两类规则执行相关问题修复；现阶段重点攻坚全面性规则存在的执行阻塞卡点，持续排查定位阻塞根源并处理。
同步对开发环境跑数产出的异常数据开展深度分析，结合数据实际表现迭代优化规则校验逻辑，提升规则识别精准度；针对前端页面展示不合理、交互不友好等问题，前端同步开展页面优化调整，统一展示规范。','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='钱程'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='钱程') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：1、AI团队成果汇报。
2、知识库批量文件效果测试。
下午：1、embedding模型对比汇报。
2、知识库query plan、子父块检索机制设计。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='陈怡'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈怡') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','implementation','owner','上午：参加疾控省统筹平台（二期）项目周例会，跟进下周症候群系统和舆情系统建设进展，和监理沟通后续人员签到考勤纪律；
下午：收集整理各系统开发状态表；智能流调系统优化完善工作待办项梳理；编写疾控项目周报。
本周参加会议时间30%，编写文档50%，协调沟通20%。','in-progress',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='陈恺'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈恺') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','solution-design','owner','上午
1、准备下午数据中心汇报演示环境，提前预演演示内容
2、集成平台与综合平台服务器资源调度会
3、编写数据治理商机所需材料
下午
1、组织数据中心汇报演示会
2、提交客户数据治理商机材料，吸收客户意见，重新优化调整
3、SSL证书沟通','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='陈秀华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈秀华') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','苏政源-组件超市
上午：
1、专项任务：协助处理组件超市项目关于组件迁移的省级单位以及地市单位系统的组件迁移的对接事项，解决系统人员反馈的系统对接联调问题。
2、整理检查组件超市的初验验收材料，配合监理单位针对未整改的相关材料的内容修改。
海事局项目：
1、梳理海事局搜救中心项目的开发完成情况和下周的进度计划，给客户汇报本周的开发完成内容。
下午：
1、专项任务：继续推进省市单位的系统的进行组件迁移对接工作，解决对接中反馈的问题点并且协助排查定位。
2、沟通OCR组件的接口的开发进度，和省市单位的调用OCR组件的系统厂商人员确认接口的对接情况。
3、和监理单位人员沟通监理测试反馈的组件超市的系统使用问题，并且配合开发人员定位分析具体问题。
4、继续整改监理复审后有问题的验收材料，完成未整改项目的验收材料的修改工作。
本周工作时间占比统计：
客户交流与内外部协调：20%（完成大数据中心客户反馈的问题的修复，配合客户收集wps、视频会议以及短信服务的调用量，对接自然资源厅、省办公厅等单位的首席数据官的配置事项；海事局项目的整体开发进度和客户汇报）
项目内部系统对接：40% （负责组件超市组件迁移专项任务，解决省市单位范围内系统组件迁移对接过程的问题点；OCR组件以及华为语音合成组件的问题的处理进度的跟进）
系统问题处理：20%（组件超市系统问题点进度跟进和质量把控）
编写文档：10%（监理单位复核材料后修改有问题的材料）
系统维护：10%（组件超市系统以及组件服务的相关服务器巡检）','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='陈笑'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','下午：开展数据中心及网络维保项目厂商询价工作，梳理维保服务范围、技术要求，向多家厂商发起询价沟通，收集报价资料与服务方案，对比各家服务内容、价格差异，为项目后续选型提供依据。','completed',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈笑') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','上午：统筹收集组内绩效相关数据，同步梳理门禁备案信息','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='陈耀龙'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','operations-support','owner','上午：1.处理中石油站点故障。2.省消防跟进出具排期计划。3.沿海集团验收资料流程整体
下午：1.辅助检察院新来员工，介绍相关系统功能模块。2.开展检察院站点安全检测。','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈耀龙') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','1、上午参加省公司法务部会议，根据网信安要求讨论检察院个人话务信息的报备和整改举措；
2、下午编辑行业一部部门周报。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='陈苏'),'leave','submitted','Imported from July schedule') returning id;
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='陈雪松'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='陈雪松') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','bid-quotation','owner','上午：1.常委会第三天保障，业务和信创服务器巡检
2.督促厂家解决OA表单字段问题以及档案批量导出没有六格章问题
下午：1.优化OA表单字段配置，并测试验证前端表单字段显示正常
2.对接厂家确认档案批量导出功能为标准功能，如需要导出六格章原文需要二开，已找厂家报价','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='韩威'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='韩威') and report_date='2026-07-31'),'full-day',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','全天支撑环保集团项目。
1. 对齐综合办公系统、三重一大系统、生产企业管理系统建设进度。
2. 整理子系统周报。
3. 编写MES/ERP系统进度及计划汇报材料。
4. 综合办公系统历史数据迁移复测，进行数据和附件验证。

本周工作时长占比：沟通协调40%，编写文档30%，系统分析30%。','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='高翔'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='高翔') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'project-support','requirements-analysis','owner','扬州保税区项目支撑，对接生态沟通业务需求，梳理我司方案优势以及案例','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='麻鑫宁'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','customer-support','owner','上午:新时代船厂8大领域40个场景','in-progress',null,null,null);
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='麻鑫宁') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：参加工业专班会议','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='黄思华'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-TEST-05'),'project-support','bid-quotation','owner','上午：1)省中医院运营管理项目析标、后向沟通
2）省中医院数据中心项目析标、后向寻源
3）军总运维项目踏勘事项协调
下午：1）省人民无人机项目，招标文件核对，评分标准核对
2）军总投标资质沟通','blocked','dependency','technical-expert','Imported blocker needs external coordination');
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄思华') and report_date='2026-07-31'),'afternoon',(select id from projects where code='JUL-UNMATCHED'),'special-work',null,'owner','下午：参加部门月度例会','completed',null,null,null);
insert into daily_reports(report_date,employee_id,attendance_status,status,note) values ('2026-07-31',(select id from employees where name='黄静茹'),'present','submitted','Imported from July schedule') returning id;
insert into daily_tasks(report_id,time_period,project_id,work_type,work_stage,participation_role,progress_result,current_status,issue_type,collaboration_role,collaboration_requirement) values ((select id from daily_reports where employee_id=(select id from employees where name='黄静茹') and report_date='2026-07-31'),'morning',(select id from projects where code='JUL-UNMATCHED'),'project-support','testing-deployment','owner','上午：
1.复测环保投资系统，检查bug是否修改完成；
2.收集环保各子系统周报；
3.跟进发改生产环境服务器关停情况，协调各厂家验证关停的服务器对业务是否产生影响；
4.协调测试环保合同数据能否返回到商机系统。
下午：
1.输出环保人力周报，根据周报内容更新子公司进度表；
2.汇总环保一体化周报。
本周各类工作占比：客户交流沟通与内外部协调45%、编写文档20%、发改项目专项工作5%，环保项目专项工作30%。','completed',null,null,null);
commit;