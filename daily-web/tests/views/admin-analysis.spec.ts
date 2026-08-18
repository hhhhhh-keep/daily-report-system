import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminAnalysisView from '@/views/admin/analysis/AdminAnalysisView.vue'

const { api } = vi.hoisted(() => ({ api: { runs: vi.fn(), runNow: vi.fn() } }))
vi.mock('@/api/admin', () => ({ adminApi: api }))

const reportRun = {
  id: 2, analysisPeriod: 'DAILY', analysisDate: '2026-08-13', status: 'succeeded',
  llmStatus: 'succeeded', emailStatus: 'sent', startedAt: '2026-08-17T09:10:48Z',
  llmErrorSummary: null,
  reportAvailable: true, reportFileName: 'daily-analysis.docx',
}

describe('AdminAnalysisView', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    api.runs.mockResolvedValue({ data: { items: [reportRun] } })
    api.runNow.mockResolvedValue({ data: reportRun })
  })

  it('shows concise task records and downloads the saved report attachment', async () => {
    const open = vi.spyOn(window, 'open').mockImplementation(() => null)
    const wrapper = shallowMount(AdminAnalysisView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.text()).toContain('最近分析任务')
    expect(wrapper.text()).toContain('分析截止日')
    expect(wrapper.text()).toContain('运行时间')
    expect(wrapper.text()).toContain('报告状态')
    expect(wrapper.text()).toContain('AI 分析状态')
    expect(wrapper.text()).toContain('AI 降级原因')
    expect(wrapper.text()).toContain('邮件状态')
    expect(wrapper.text()).toContain('2026-08-13')
    expect(wrapper.text()).toContain('下载附件')
    await wrapper.find('button.button-secondary').trigger('click')
    expect(open).toHaveBeenCalledWith('/api/admin/runs/2/report', '_blank')
  })

  it('runs the selected period and refreshes task records', async () => {
    const wrapper = shallowMount(AdminAnalysisView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()
    await wrapper.find('[data-testid="analysis-end-date"]').setValue('2026-07-31')
    await wrapper.find('[data-testid="run-analysis"]').trigger('click')
    await flushPromises()

    expect(api.runNow).toHaveBeenCalledWith('2026-07-31', 'DAILY')
    expect(api.runs).toHaveBeenCalledTimes(2)
    expect(wrapper.text()).toContain('运行：成功')
    expect(wrapper.text()).toContain('邮件：已发送')
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
    finish({ data: reportRun })
  })
})
