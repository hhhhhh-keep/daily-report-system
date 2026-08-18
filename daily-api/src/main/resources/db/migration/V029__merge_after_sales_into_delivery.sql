update project_derived_states
set state = 'DELIVERY_IN_PROGRESS', lifecycle = 'delivery'
where state = 'AFTERSALES_IN_PROGRESS';

update project_state_events
set state = 'DELIVERY_IN_PROGRESS'
where state = 'AFTERSALES_IN_PROGRESS';

update project_state_snapshots
set state = 'DELIVERY_IN_PROGRESS', lifecycle = 'delivery'
where state = 'AFTERSALES_IN_PROGRESS' or lifecycle = 'aftersales';
