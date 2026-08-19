import { flushPromises, shallowMount } from '@vue/test-utils'
import { describe, expect, it, vi } from 'vitest'
import AdminWorkdayCalendarView from '@/views/admin/AdminWorkdayCalendarView.vue'

const { previewOfficialWorkdayCalendar } = vi.hoisted(() => ({
  previewOfficialWorkdayCalendar: vi.fn(() => Promise.resolve({ data: { year: 2026, noticeUrl: 'https://www.gov.cn/notice', entries: [{ date: '2026-01-01', workday: false, source: 'LEGAL_HOLIDAY', note: '元旦' }] } })),
}))
vi.mock('@/api/admin', () => ({ adminApi: { workdayCalendar: vi.fn(() => Promise.resolve({
  data: { items: [], totalItems: 0, page: 0, pageSize: 366, totalPages: 0 },
})), previewOfficialWorkdayCalendar, importWorkdayCalendar: vi.fn(), saveWorkdayOverride: vi.fn(), deleteWorkdayOverride: vi.fn() } }))

describe('AdminWorkdayCalendarView', () => {
  it('shows an annual calendar grid instead of a record table', () => {
    const wrapper = shallowMount(AdminWorkdayCalendarView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    expect(wrapper.find('.workday-calendar-grid').exists()).toBe(true)
    expect(wrapper.findAll('.workday-month')).toHaveLength(12)
    expect(wrapper.find('table').exists()).toBe(false)
  })

  it('previews an official notice before importing the calendar', async () => {
    const wrapper = shallowMount(AdminWorkdayCalendarView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await wrapper.find('input[type="url"]').setValue('https://www.gov.cn/notice')
    await wrapper.find('.official-calendar-import').trigger('submit')
    await flushPromises()
    expect(previewOfficialWorkdayCalendar).toHaveBeenCalledWith(2026, 'https://www.gov.cn/notice')
    expect(wrapper.text()).toContain('确认导入 2026 年日历')
  })
})
