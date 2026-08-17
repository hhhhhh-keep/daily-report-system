import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminAnalysisView from '@/views/admin/analysis/AdminAnalysisView.vue'

const { api } = vi.hoisted(() => ({ api: { latestAnalysis: vi.fn(), runNow: vi.fn() } }))
vi.mock('@/api/admin', () => ({ adminApi: api }))

describe('AdminAnalysisView', () => {
  beforeEach(() => {
    api.latestAnalysis.mockResolvedValue({ data: [{
      runId: 2, analysisDate: '2026-08-13', dimension: 'collaboration',
      resultText: JSON.stringify({ conclusions: [{
        title: '日报未包含任何任务提交记录', severity: 'risk', summary: '当前快照没有任务数据。',
        evidence: ['tasks=[]'], recommendation: '请补录任务。', confidence: 'high',
      }] }),
    }] })
    api.runNow.mockResolvedValue({ data: { id: 3, status: 'SUCCEEDED' } })
  })

  it('shows a business summary instead of raw analysis JSON', async () => {
    const wrapper = shallowMount(AdminAnalysisView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.text()).toContain('分析结论')
    expect(wrapper.text()).toContain('日报未包含任何任务提交记录')
    expect(wrapper.text()).toContain('共 1 条结论')
    expect(wrapper.text()).not.toContain('"conclusions"')
    expect(wrapper.text()).not.toContain('collaboration')
  })

  it('uses the chosen date and opens a structured detail dialog', async () => {
    const wrapper = shallowMount(AdminAnalysisView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()
    await wrapper.find('[data-testid="analysis-end-date"]').setValue('2026-07-31')
    await wrapper.find('[data-testid="run-analysis"]').trigger('click')
    expect(api.runNow).toHaveBeenCalledWith('2026-07-31', 'DAILY')
    await wrapper.find('[data-testid="view-analysis-detail"]').trigger('click')
    expect(wrapper.find('[role="dialog"]').exists()).toBe(true)
    expect(wrapper.text()).toContain('分析依据')
    expect(wrapper.text()).toContain('处理建议')
  })

  it('keeps the action disabled and shows progress while analysis is running', async () => {
    let finish!: (value: unknown) => void
    api.runNow.mockImplementation(() => new Promise(resolve => { finish = resolve }))
    const wrapper = shallowMount(AdminAnalysisView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    await wrapper.find('[data-testid="run-analysis"]').trigger('click')

    expect(wrapper.find('[data-testid="run-analysis"]').attributes('disabled')).toBeDefined()
    expect(wrapper.text()).toContain('AI 分析中，预计需要 1～3 分钟，请勿重复提交')
    finish({ data: { status: 'succeeded', llmStatus: 'succeeded', emailStatus: 'sent' } })
  })

  it('shows run, AI and email status after completion', async () => {
    api.runNow.mockResolvedValue({
      data: { status: 'succeeded', llmStatus: 'succeeded', emailStatus: 'sent' },
    })
    const wrapper = shallowMount(AdminAnalysisView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    await wrapper.find('[data-testid="run-analysis"]').trigger('click')
    await flushPromises()

    expect(wrapper.text()).toContain('运行：成功')
    expect(wrapper.text()).toContain('AI：成功')
    expect(wrapper.text()).toContain('邮件：已发送')
  })
})
