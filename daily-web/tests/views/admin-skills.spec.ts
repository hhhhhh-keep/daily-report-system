import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminSkillsView from '@/views/admin/skills/AdminSkillsView.vue'

const { api } = vi.hoisted(() => ({ api: {
  analysisSkills: vi.fn(), analysisSkillTrials: vi.fn(), uploadAnalysisSkill: vi.fn(),
  trialAnalysisSkills: vi.fn(), publishAnalysisSkills: vi.fn(),
} }))

vi.mock('@/api/admin', () => ({ adminApi: api }))

describe('AdminSkillsView', () => {
  beforeEach(() => {
    api.analysisSkills.mockResolvedValue({ data: [] })
    api.analysisSkillTrials.mockResolvedValue({ data: [] })
  })

  it('uses Chinese business labels and does not display trial history', async () => {
    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.text()).toContain('日报规则分析')
    expect(wrapper.text()).toContain('日报报告模板')
    expect(wrapper.text()).toContain('上传 ZIP 文件')
    expect(wrapper.text()).not.toContain('试运行历史')
  })

  it('shows the execution time and versions for the latest successful trial', async () => {
    api.analysisSkillTrials.mockResolvedValue({ data: [{
      id: 8, period: 'DAILY', ruleSkillVersionId: 1, templateSkillVersionId: 2,
      periodStart: '2026-07-31', periodEnd: '2026-07-31', status: 'SUCCEEDED',
      analysisDraft: '{"conclusions":[]}', renderedHtml: '<section>report</section>',
      errorSummary: null, startedAt: '2026-08-13T10:27:36Z', finishedAt: '2026-08-13T10:27:36Z',
    }] })
    api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({
      data: [{ id: kind === 'RULE' ? 1 : 2, versionNumber: 1, status: 'PUBLISHED' }],
    }))
    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.find('[data-testid="latest-successful-trial"]').exists()).toBe(true)
    expect(wrapper.text()).toContain('执行时间')
    expect(wrapper.text()).toContain('使用版本')
    await wrapper.find('[data-testid="view-analysis-draft"]').trigger('click')
    expect(wrapper.find('[role="dialog"]').exists()).toBe(true)
  })
})
