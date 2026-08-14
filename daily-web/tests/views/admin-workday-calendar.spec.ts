import { shallowMount } from '@vue/test-utils'
import { describe, expect, it, vi } from 'vitest'
import AdminWorkdayCalendarView from '@/views/admin/AdminWorkdayCalendarView.vue'

vi.mock('@/api/admin', () => ({ adminApi: { workdayCalendar: vi.fn(() => Promise.resolve({ data: [] })) } }))

describe('AdminWorkdayCalendarView', () => {
  it('shows an annual calendar grid instead of a record table', () => {
    const wrapper = shallowMount(AdminWorkdayCalendarView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    expect(wrapper.find('.workday-calendar-grid').exists()).toBe(true)
    expect(wrapper.findAll('.workday-month')).toHaveLength(12)
    expect(wrapper.find('table').exists()).toBe(false)
  })
})
