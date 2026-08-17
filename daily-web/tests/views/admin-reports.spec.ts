import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminReportsView from '@/views/admin/AdminReportsView.vue'

const { api } = vi.hoisted(() => ({ api: {
  reports: vi.fn(), report: vi.fn(), employees: vi.fn(), dictionaries: vi.fn(),
  reportPeriodStatistics: vi.fn(),
} }))
vi.mock('@/api/admin', () => ({ adminApi: api }))

describe('AdminReportsView period statistics', () => {
  beforeEach(() => {
    api.employees.mockResolvedValue({ data: { items: [] } })
    api.dictionaries.mockResolvedValue({ data: { items: [] } })
    api.reports.mockResolvedValue({ data: {
      items: [{
        id: 1, date: '2026-08-10', employeeId: 11, employeeName: '测试员工',
        attendance: 'present', status: 'submitted', taskCount: 2,
        submittedAt: '2026-08-10T09:00:00Z', updatedAt: '2026-08-10T12:00:00Z',
      }], totalItems: 1, totalPages: 1, page: 0, pageSize: 20,
    } })
    api.reportPeriodStatistics.mockResolvedValue({ data: {
      period: 'WEEKLY', periodStart: '2026-08-10', periodEnd: '2026-08-16',
      workdayCount: 5, coverageMode: 'CURRENT_ROSTER_FALLBACK',
      totals: {
        expectedReportCount: 5, earlySubmittedCount: 4, earlySubmissionRate: 80,
        missingCount: 1, leaveOccurrences: 1, leaveEquivalentDays: 0.5, trainingCount: 1,
      },
      people: [{
        employeeId: 11, employeeName: '测试员工', teamName: '测试组',
        expectedReportCount: 5, earlySubmittedCount: 4, earlySubmissionRate: 80,
        missingCount: 1, leaveOccurrences: 1, leaveEquivalentDays: 0.5, trainingCount: 1,
      }],
    } })
  })

  it('shows first submission, last modification and weekly counters', async () => {
    const wrapper = shallowMount(AdminReportsView, {
      global: {
        stubs: {
          AdminLayout: { template: '<main><slot /></main>' },
          Pagination: true,
        },
      },
    })
    await flushPromises()

    expect(wrapper.text()).toContain('首次提交时间')
    expect(wrapper.text()).toContain('最后修改时间')
    expect(wrapper.text()).toContain('周统计')
    expect(wrapper.text()).toContain('17:30前填写')
    expect(wrapper.text()).toContain('请假折算天数')
    expect(wrapper.text()).toContain('0.5')
    expect(api.reportPeriodStatistics).toHaveBeenCalledWith('WEEKLY', expect.any(String))
  })

  it('reloads the aggregation when switching to monthly statistics', async () => {
    const wrapper = shallowMount(AdminReportsView, {
      global: {
        stubs: {
          AdminLayout: { template: '<main><slot /></main>' },
          Pagination: true,
        },
      },
    })
    await flushPromises()
    await wrapper.get('[data-testid="period-monthly"]').trigger('click')
    await flushPromises()

    expect(api.reportPeriodStatistics).toHaveBeenLastCalledWith('MONTHLY', expect.any(String))
  })
})
