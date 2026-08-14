update business_dictionaries
set active = false
where category = 'participation_role'
  and code = 'temporary-support';
