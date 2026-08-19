import { flushPromises, shallowMount } from '@vue/test-utils'
import { describe, expect, it, vi } from 'vitest'
import AdminProjectsView from '@/views/admin/AdminProjectsView.vue'

const api = vi.hoisted(() => ({ projects: vi.fn(), projectActivity: vi.fn() }))
vi.mock('@/api/admin', () => ({ adminApi: api }))
vi.mock('@/api/http', () => ({ apiError: (error: { message: string }) => error }))

describe('AdminProjectsView', () => {
  it('filters projects and opens activity in a dialog', async () => {
    api.projects.mockResolvedValue({ data: {
      items: [
        { id: 1, name: '公安数据湖项目', code: 'PA-01', customerName: '省公安厅', formal: true, active: true },
        { id: 2, name: '省医保五期项目', code: 'MI-05', customerName: '省医保局', formal: true, active: true },
      ],
      totalItems: 2, page: 0, pageSize: 20, totalPages: 1,
    } })
    const wrapper = shallowMount(AdminProjectsView, { global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } } })
    await flushPromises()
    await wrapper.find('[data-testid="project-search"]').setValue('医保')
    expect(wrapper.text()).toContain('省医保五期项目')
    expect(wrapper.text()).not.toContain('公安数据湖项目')
  })

  it('uses the same formal-project and special-work labels as daily reporting', async () => {
    api.projects.mockResolvedValue({ data: {
      items: [
        { id: 1, name: '正式项目', formal: true, active: true },
        { id: 2, name: '专项工作', formal: false, active: true },
      ],
      totalItems: 2, page: 0, pageSize: 20, totalPages: 1,
    } })
    const wrapper = shallowMount(AdminProjectsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    await wrapper.get('button.button-primary').trigger('click')
    expect(wrapper.text()).toContain('正式项目（未勾选为专项工作）')
    expect(wrapper.find('tbody').text()).toContain('专项工作')
    expect(wrapper.find('tbody').text()).not.toContain('非正式专项')
  })

  it('loads project report activity when opening the timeline', async () => {
    api.projects.mockResolvedValue({ data: {
      items: [{ id: 1, name: '项目1', formal: true, active: true }],
      totalItems: 1, page: 0, pageSize: 20, totalPages: 1,
    } })
    api.projectActivity.mockResolvedValue({ data: {
      projectId: 1, participantCount: 1, latestReportDate: '2026-08-12', blockedOrPausedCount: 0,
      derivedState: { state: 'PRESALES_IN_PROGRESS', lifecycle: 'presales',
        currentStage: 'solution-design', stateStartedDate: '2026-08-12', triggerTaskId: 2 },
      stateEvents: [{ occurredDate: '2026-08-12', state: 'PRESALES_IN_PROGRESS',
        currentStage: 'solution-design', triggerTaskId: 2 }],
      tasks: [
        { taskId: 1, reportDate: '2026-08-11', employeeId: 1, employeeName: '张三',
          workStage: 'requirements-analysis', currentStatus: 'in-progress', progressResult: '调研', issueType: null, collaborationRequirement: null },
        { taskId: 2, reportDate: '2026-08-12', employeeId: 1, employeeName: '张三',
          workStage: 'solution-design', currentStatus: 'in-progress', progressResult: '方案', issueType: null, collaborationRequirement: null },
      ],
    } })
    const wrapper = shallowMount(AdminProjectsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })

    await flushPromises()
    await wrapper.find('.activity-button').trigger('click')
    await flushPromises()

    expect(api.projectActivity).toHaveBeenCalledWith(1, { days: 30, page: 0, size: 20 })
    expect(wrapper.text()).toContain('张三')
    expect(wrapper.text()).toContain('方案编写/设计')
    expect(wrapper.text()).toContain('售前推进')
  })
})
