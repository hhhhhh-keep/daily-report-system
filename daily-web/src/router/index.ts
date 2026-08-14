import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'
import ReportEntryView from '@/views/report/ReportEntryView.vue'
import MyReportView from '@/views/report/MyReportView.vue'
import { installRouteGuards } from '@/router/guards'
import { adminRoutes } from '@/router/admin'

export const routes: RouteRecordRaw[] = [
  { path: '/', redirect: '/report' },
  { path: '/report', name: 'report', component: ReportEntryView },
  { path: '/my-report', name: 'my-report', component: MyReportView },
  ...adminRoutes,
]

export const router = createRouter({ history: createWebHistory(), routes })

installRouteGuards(router)
