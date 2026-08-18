import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminSkillsView from '@/views/admin/skills/AdminSkillsView.vue'

const { api } = vi.hoisted(() => ({ api: {
  analysisSkills: vi.fn(), analysisSkillTrials: vi.fn(), uploadAnalysisSkill: vi.fn(),
  trialAnalysisSkills: vi.fn(), publishAnalysisSkills: vi.fn(), deleteAnalysisSkill: vi.fn(),
} }))

vi.mock('@/api/admin', () => ({ adminApi: api }))

describe('AdminSkillsView', () => {
  beforeEach(() => {
    vi.clearAllMocks()
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
    expect(wrapper.text()).toContain('报告截止日期')
    expect(wrapper.text()).toContain('日报只看这一天；周报统计本周一至这一天；月报统计本月1日至这一天')
    expect(wrapper.text()).not.toContain('试运行历史')
  })

  it('offers deletion only for draft versions', async () => {
    api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({ data: [
      { id: kind === 'RULE' ? 1 : 2, versionNumber: 2, status: 'DRAFT' },
      { id: kind === 'RULE' ? 3 : 4, versionNumber: 1, status: 'PUBLISHED' },
    ] }))
    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.findAll('[data-testid="delete-skill-version"]').length).toBe(2)
  })

  it('shows the execution time and versions for the latest successful trial', async () => {
    api.analysisSkillTrials.mockResolvedValue({ data: [{
      id: 8, period: 'DAILY', ruleSkillVersionId: 1, templateSkillVersionId: 2,
      periodStart: '2026-07-31', periodEnd: '2026-07-31', status: 'SUCCEEDED',
      analysisDraft: '{"conclusions":[]}', renderedHtml: '<section>report</section>',
      errorSummary: null, hasDocument: true, startedAt: '2026-08-13T10:27:36Z', finishedAt: '2026-08-13T10:27:36Z',
    }] })
    api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({
      data: [{ id: kind === 'RULE' ? 1 : 2, versionNumber: 1, status: 'PUBLISHED' }],
    }))
    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.find('[data-testid="latest-successful-trial"]').exists()).toBe(true)
    expect(wrapper.find('[data-testid="download-docx"]').exists()).toBe(true)
    expect(wrapper.text()).toContain('执行时间')
    expect(wrapper.text()).toContain('使用版本')
    await wrapper.find('[data-testid="view-analysis-draft"]').trigger('click')
    expect(wrapper.find('[role="dialog"]').exists()).toBe(true)
  })

  it('labels a facts-only result as degraded instead of successful', async () => {
    api.analysisSkillTrials.mockResolvedValue({ data: [{
      id: 18, period: 'DAILY', ruleSkillVersionId: 1, templateSkillVersionId: 2,
      periodStart: '2026-08-11', periodEnd: '2026-08-11', status: 'SUCCEEDED',
      analysisDraft: null, renderedHtml: '<section>基础报告</section>',
      errorSummary: 'AI 语义分析未通过证据校验，已生成基础报告',
      startedAt: '2026-08-14T06:56:20Z', finishedAt: '2026-08-14T06:58:24Z',
    }] })
    api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({
      data: [{ id: kind === 'RULE' ? 1 : 2, versionNumber: 2, status: 'DRAFT' }],
    }))
    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.find('[data-testid="latest-successful-trial"]').exists()).toBe(false)
    expect(wrapper.find('[data-testid="latest-skill-trial"]').text()).toContain('降级完成')
    expect(wrapper.find('[data-testid="latest-skill-trial"]').text()).toContain('AI 语义分析未通过证据校验')
  })

  it('shows the actual trial failure instead of reporting completion', async () => {
    api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({
      data: [{ id: kind === 'RULE' ? 1 : 2, versionNumber: 1, status: 'DRAFT' }],
    }))
    api.trialAnalysisSkills.mockResolvedValue({ data: {
      id: 9, period: 'DAILY', ruleSkillVersionId: 1, templateSkillVersionId: 2,
      periodStart: '2026-08-11', periodEnd: '2026-08-11', status: 'RULE_FAILED',
      analysisDraft: null, renderedHtml: null, errorSummary: '确定性日报事实生成失败',
      startedAt: '2026-08-14T03:00:00Z', finishedAt: '2026-08-14T03:00:01Z',
    } })
    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    const trialButton = wrapper.findAll('button').find(button => button.text() === '试运行所选版本')
    await trialButton?.trigger('click')
    await flushPromises()

    expect(wrapper.find('[role="status"]').text()).toBe('试运行失败：确定性日报事实生成失败')
  })

  it('shows a running state immediately and prevents duplicate trials', async () => {
    api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({
      data: [{ id: kind === 'RULE' ? 1 : 2, versionNumber: 1, status: 'DRAFT' }],
    }))
    let resolveTrial!: (value: unknown) => void
    api.trialAnalysisSkills.mockImplementation(() => new Promise(resolve => { resolveTrial = resolve }))
    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    const trialButton = wrapper.findAll('button').find(button => button.text() === '试运行所选版本')!
    await trialButton.trigger('click')

    expect(wrapper.find('[role="status"]').text()).toBe('正在试运行，请稍候…')
    expect(trialButton.attributes('disabled')).toBeDefined()
    expect(trialButton.text()).toBe('正在试运行…')

    resolveTrial({ data: {
      id: 10, period: 'DAILY', ruleSkillVersionId: 1, templateSkillVersionId: 2,
      periodStart: '2026-08-11', periodEnd: '2026-08-11', status: 'SUCCEEDED',
      analysisDraft: '{}', renderedHtml: '<section>report</section>', errorSummary: null,
      startedAt: '2026-08-14T03:00:00Z', finishedAt: '2026-08-14T03:00:01Z',
    } })
    await flushPromises()

    expect(trialButton.attributes('disabled')).toBeUndefined()
    expect(trialButton.text()).toBe('试运行所选版本')
    expect(wrapper.find('[role="status"]').text()).toContain('试运行成功')
  })

  it('restores a persisted running trial after the page is mounted again', async () => {
    api.analysisSkills.mockImplementation((_period: string, kind: string) => Promise.resolve({
      data: [{ id: kind === 'RULE' ? 1 : 2, versionNumber: 1, status: 'DRAFT' }],
    }))
    api.analysisSkillTrials.mockResolvedValue({ data: [{
      id: 11, period: 'DAILY', ruleSkillVersionId: 1, templateSkillVersionId: 2,
      periodStart: '2026-08-14', periodEnd: '2026-08-14', status: 'RUNNING',
      analysisDraft: null, renderedHtml: null, errorSummary: null,
      startedAt: '2026-08-14T06:40:00Z', finishedAt: null,
    }] })

    const wrapper = shallowMount(AdminSkillsView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.find('[data-testid="latest-skill-trial"]').exists()).toBe(true)
    expect(wrapper.find('[data-testid="latest-skill-trial"]').text()).toContain('正在试运行')
    const trialButton = wrapper.find('[data-testid="run-skill-trial"]')
    expect(trialButton.attributes('disabled')).toBeDefined()
    expect(trialButton.text()).toBe('正在试运行…')
  })
})
