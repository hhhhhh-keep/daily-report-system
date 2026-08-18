update daily_tasks
set collaboration_requirement = null
where collaboration_requirement = 'Imported blocker needs external coordination';
