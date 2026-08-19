import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminRunScheduleView from '@/views/admin/schedule/AdminRunScheduleView.vue'

const api = vi.hoisted(() => ({
  reportStatisticsConfiguration: vi.fn(),
  reportStatisticsSnapshots: vi.fn(),
  reportStatisticsSnapshotLatest: vi.fn(),
  analysisPeriodConfigurations: vi.fn(),
  updateReportStatisticsConfiguration: vi.fn(),
  updateAnalysisPeriodConfiguration: vi.fn(),
}))

vi.mock('@/api/admin', () => ({ adminApi: api }))
vi.mock('@/api/http', () => ({ apiError: (error: { message: string }) => error }))

describe('AdminRunScheduleView', () => {
  beforeEach(() => {
    api.reportStatisticsConfiguration.mockResolvedValue({ data: {
      earlySnapshotEnabled: true, earlySnapshotCronExpression: '0 30 17 ? * MON-FRI',
      finalSnapshotEnabled: true, finalSnapshotCronExpression: '0 0 22 ? * MON-FRI',
    } })
    api.analysisPeriodConfigurations.mockResolvedValue({ data: [
      { period: 'DAILY', enabled: true, cronExpression: '0 10 22 ? * MON-FRI', enabledModules: [], retentionMonths: 12, includeEvidenceInDelivery: true },
      { period: 'WEEKLY', enabled: true, cronExpression: '0 0 9 ? * MON', enabledModules: [], retentionMonths: 12, includeEvidenceInDelivery: true },
      { period: 'MONTHLY', enabled: true, cronExpression: '0 0 9 1 * ?', enabledModules: [], retentionMonths: 12, includeEvidenceInDelivery: true },
    ] })
    api.reportStatisticsSnapshotLatest.mockResolvedValue({ data: [
      { id: 2, snapshotType: 'FINAL', snapshotDate: '2026-08-18', capturedAt: '2026-08-18T14:00:00Z', expectedCount: 100, submittedCount: 95, missingCount: 5, submissionRate: 0.95 },
      { id: 1, snapshotType: 'PROGRESS_1730', snapshotDate: '2026-08-18', capturedAt: '2026-08-18T09:30:00Z', expectedCount: 100, submittedCount: 80, missingCount: 20, submissionRate: 0.8 },
    ] })
  })

  it('uses time pickers instead of exposing Cron expressions', async () => {
    const wrapper = shallowMount(AdminRunScheduleView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })

    await flushPromises()

    expect(wrapper.findAll('input[type="time"]')).toHaveLength(5)
    expect(wrapper.text()).toContain('执行时间')
    expect(wrapper.text()).toContain('最近 17:30 快照')
    expect(wrapper.text()).toContain('最近 22:00 快照')
    expect(wrapper.text()).toContain('应填100 · 已填80 · 未填20')
    expect(wrapper.text()).toContain('工作日')
    expect(wrapper.text()).toContain('每周最后一个工作日')
    expect(wrapper.text()).toContain('每月最后一个工作日')
    expect(api.reportStatisticsSnapshotLatest).toHaveBeenCalledOnce()
    expect(wrapper.text()).not.toContain('Cron')
  })

  it('only shows a save result in the schedule card that was saved', async () => {
    api.updateAnalysisPeriodConfiguration.mockImplementation((period: { period: string }) => Promise.resolve({ data: period }))
    const wrapper = shallowMount(AdminRunScheduleView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    await wrapper.findAll('button').find(button => button.text() === '保存周报分析计划')!.trigger('click')
    await flushPromises()

    expect(wrapper.findAll('[role="status"]')).toHaveLength(1)
    expect(wrapper.find('[role="status"]').text()).toBe('✓ 周报分析计划已保存')
  })
})
