import type { RouteRecordRaw } from 'vue-router'
import AdminEntryView from '@/views/admin/AdminEntryView.vue'
import AdminDashboardView from '@/views/admin/AdminDashboardView.vue'
import AdminDictionariesView from '@/views/admin/AdminDictionariesView.vue'
import AdminEmployeesView from '@/views/admin/AdminEmployeesView.vue'
import AdminPasswordView from '@/views/admin/AdminPasswordView.vue'
import AdminProjectsView from '@/views/admin/AdminProjectsView.vue'
import AdminReportsView from '@/views/admin/AdminReportsView.vue'
import AdminAnalysisView from '@/views/admin/analysis/AdminAnalysisView.vue'
import AdminTechnicalConnectionView from '@/views/admin/config/AdminTechnicalConnectionView.vue'
import AdminRunsView from '@/views/admin/runs/AdminRunsView.vue'
import AdminWorkdayCalendarView from '@/views/admin/AdminWorkdayCalendarView.vue'
import AdminRunScheduleView from '@/views/admin/schedule/AdminRunScheduleView.vue'
import AdminSkillsView from '@/views/admin/skills/AdminSkillsView.vue'

export const adminRoutes: RouteRecordRaw[] = [
  { path: '/admin', name: 'admin', component: AdminEntryView },
  { path: '/admin/dashboard', name: 'admin-dashboard', component: AdminDashboardView,
    meta: { requiresAdmin: true } },
  { path: '/admin/employees', name: 'admin-employees', component: AdminEmployeesView,
    meta: { requiresAdmin: true } },
  { path: '/admin/projects', name: 'admin-projects', component: AdminProjectsView,
    meta: { requiresAdmin: true } },
  { path: '/admin/dictionaries', name: 'admin-dictionaries', component: AdminDictionariesView,
    meta: { requiresAdmin: true } },
  { path: '/admin/workday-calendar', name: 'admin-workday-calendar', component: AdminWorkdayCalendarView,
    meta: { requiresAdmin: true } },
  { path: '/admin/reports', name: 'admin-reports', component: AdminReportsView,
    meta: { requiresAdmin: true } },
  { path: '/admin/analysis', name: 'admin-analysis', component: AdminAnalysisView,
    meta: { requiresAdmin: true } },
  { path: '/admin/configuration', redirect: '/admin/run-schedule', meta: { requiresAdmin: true } },
  { path: '/admin/run-schedule', name: 'admin-run-schedule', component: AdminRunScheduleView,
    meta: { requiresAdmin: true } },
  { path: '/admin/technical-connections', name: 'admin-technical-connections', component: AdminTechnicalConnectionView,
    meta: { requiresAdmin: true } },
  { path: '/admin/skills', name: 'admin-skills', component: AdminSkillsView,
    meta: { requiresAdmin: true } },
  { path: '/admin/runs', name: 'admin-runs', component: AdminRunsView,
    meta: { requiresAdmin: true } },
  { path: '/admin/password', name: 'admin-password', component: AdminPasswordView,
    meta: { requiresAdmin: true } },
]
