update business_dictionaries set code = case code
  when 'requirements-analysis' then 'presales-requirements-analysis'
  when 'solution-design' then 'presales-solution-design'
  when 'bid-quotation' then 'presales-bid-quotation'
  when 'technical-presentation' then 'presales-technical-presentation'
  when 'implementation' then 'delivery-implementation'
  when 'testing-deployment' then 'delivery-testing-deployment'
  when 'training-acceptance' then 'delivery-training-acceptance'
  when 'operations-support' then 'after-sales-operations-support'
  when 'incident-handling' then 'after-sales-incident-handling'
  when 'optimization-upgrade' then 'after-sales-optimization-upgrade'
  when 'customer-support' then 'after-sales-customer-support'
end
where category = 'work_stage';

update daily_tasks set work_stage = case work_stage
  when 'requirements-analysis' then 'presales-requirements-analysis'
  when 'solution-design' then 'presales-solution-design'
  when 'bid-quotation' then 'presales-bid-quotation'
  when 'technical-presentation' then 'presales-technical-presentation'
  when 'implementation' then 'delivery-implementation'
  when 'testing-deployment' then 'delivery-testing-deployment'
  when 'training-acceptance' then 'delivery-training-acceptance'
  when 'operations-support' then 'after-sales-operations-support'
  when 'incident-handling' then 'after-sales-incident-handling'
  when 'optimization-upgrade' then 'after-sales-optimization-upgrade'
  when 'customer-support' then 'after-sales-customer-support'
end;
