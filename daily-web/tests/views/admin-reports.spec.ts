import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminReportsView from '@/views/admin/AdminReportsView.vue'

const { api } = vi.hoisted(() => ({ api: {
  reports: vi.fn(), report: vi.fn(), employees: vi.fn(), dictionaries: vi.fn(),
} }))
vi.mock('@/api/admin', () => ({ adminApi: api }))

describe('AdminReportsView', () => {
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
  })

  function mountView() {
    return shallowMount(AdminReportsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' }, Pagination: true } },
    })
  }

  it('shows daily report filters and keeps cumulative statistics out of this view', async () => {
    const wrapper = mountView()
    await flushPromises()

    expect(wrapper.text()).toContain('首次提交时间')
    expect(wrapper.text()).toContain('最后修改时间')
    expect(wrapper.text()).toContain('出勤状态')
    expect(wrapper.text()).toContain('正常出勤')
    expect(wrapper.text()).not.toContain('填报累计统计')
    expect(api.reports).toHaveBeenCalledWith(expect.objectContaining({ page: 0, size: 20 }))
  })

  it('filters the report list by attendance status', async () => {
    const wrapper = mountView()
    await flushPromises()

    await wrapper.get('button.chip').trigger('click')
    await flushPromises()

    expect(api.reports).toHaveBeenLastCalledWith(expect.objectContaining({ attendance: 'present' }))
  })

  it('opens task details for a selected report', async () => {
    api.report.mockResolvedValue({ data: {
      id: 1, employeeId: 11, employeeName: '测试员工', date: '2026-08-10', attendance: 'present',
      note: null, status: 'submitted', submittedAt: '2026-08-10T09:00:00Z', updatedAt: '2026-08-10T12:00:00Z',
      tasks: [],
    } })
    const wrapper = mountView()
    await flushPromises()

    await wrapper.get('tbody button').trigger('click')
    await flushPromises()

    expect(api.report).toHaveBeenCalledWith(1)
    expect(wrapper.text()).toContain('测试员工 · 2026-08-10')
  })
})
