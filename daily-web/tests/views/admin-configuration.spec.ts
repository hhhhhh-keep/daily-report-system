import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminTechnicalConnectionView from '@/views/admin/config/AdminTechnicalConnectionView.vue'

const api = vi.hoisted(() => ({ analysisConfiguration: vi.fn(), updateAnalysisConfiguration: vi.fn(), testAnalysisConnection: vi.fn() }))

vi.mock('@/api/admin', () => ({ adminApi: api }))
vi.mock('@/api/http', () => ({ apiError: (error: { message: string }) => error }))

describe('AdminTechnicalConnectionView', () => {
  beforeEach(() => {
    api.analysisConfiguration.mockResolvedValue({ data: {
      enabled: true, cronExpression: '0 0 22 ? * MON-FRI', selectedDimensions: [], ruleThresholds: {},
      promptVersion: 'v1', promptTemplate: 'template', dashboardEnabled: true, reportEnabled: true,
      emailEnabled: false, recipients: [], ccRecipients: [], emailSubjectTemplate: 'subject', reportTemplate: 'report',
      modelEndpoint: null, modelName: null, modelApiKey: null, modelApiKeyReference: 'LLM_API_KEY',
      smtpHost: null, smtpPort: null, smtpUsername: null, smtpPassword: null, smtpFrom: null,
    } })
  })

  it('uses card headings instead of fieldset legends for connection settings', async () => {
    const wrapper = shallowMount(AdminTechnicalConnectionView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()

    expect(wrapper.text()).toContain('技术连接')
    expect(wrapper.text()).toContain('模型名称')
    expect(wrapper.text()).toContain('通过 SMTP 发送邮件')
    expect(wrapper.find('fieldset').exists()).toBe(false)
    expect(wrapper.text()).not.toContain('Prompt 模板')
    expect(wrapper.text()).not.toContain('业务规则')
  })

  it('tests the unsaved model connection from the current form values', async () => {
    api.testAnalysisConnection.mockResolvedValue({ data: { connected: true, message: '连接成功' } })
    const wrapper = shallowMount(AdminTechnicalConnectionView, {
      global: { stubs: { AdminLayout: { template: '<main><slot /></main>' } } },
    })
    await flushPromises()
    await wrapper.find('[data-testid="test-model-connection"]').trigger('click')
    await flushPromises()
    expect(api.testAnalysisConnection).toHaveBeenCalledWith(expect.objectContaining({ modelName: null }))
    expect(wrapper.text()).toContain('连接成功')
  })
})
