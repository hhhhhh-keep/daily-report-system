import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminRunScheduleView from '@/views/admin/schedule/AdminRunScheduleView.vue'

const api = vi.hoisted(() => ({
  reportStatisticsConfiguration: vi.fn(),
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
  })

  it('uses time pickers instead of exposing Cron expressions', async () => {
    const wrapper = shallowMount(AdminRunScheduleView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })

    await flushPromises()

    expect(wrapper.findAll('input[type="time"]')).toHaveLength(5)
    expect(wrapper.text()).toContain('执行时间')
    expect(wrapper.text()).not.toContain('Cron')
  })
})
