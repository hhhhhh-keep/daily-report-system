import { shallowMount } from '@vue/test-utils'
import { describe, expect, it, vi } from 'vitest'
import ReportEntryView from '@/views/report/ReportEntryView.vue'

const { reset, loadOptions } = vi.hoisted(() => ({ reset: vi.fn(), loadOptions: vi.fn() }))

vi.mock('@/stores/report', () => ({
  useReportStore: () => ({
    reset,
    loadOptions,
    optionsLoading: false,
    options: {},
    error: '',
  }),
}))

describe('ReportEntryView', () => {
  it('marks the daily report headline as a no-wrap entry title', () => {
    const wrapper = shallowMount(ReportEntryView, {
      global: { stubs: { EmployeeLayout: { template: '<main><slot /></main>' }, ReportForm: true } },
    })

    expect(wrapper.get('.page-intro').classes()).toContain('report-entry-intro')
  })
})
