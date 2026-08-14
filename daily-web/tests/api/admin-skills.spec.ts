import { describe, expect, it, vi } from 'vitest'

const { post } = vi.hoisted(() => ({ post: vi.fn() }))
vi.mock('@/api/http', () => ({ http: { post } }))

import { adminApi } from '@/api/admin'

describe('adminApi.trialAnalysisSkills', () => {
  it('allows enough time for the model-backed trial to finish', () => {
    adminApi.trialAnalysisSkills('DAILY', '2026-07-31', 1, 2)

    expect(post).toHaveBeenCalledWith('/admin/analysis-skills/DAILY/trial', undefined, {
      params: { endDate: '2026-07-31', ruleVersionId: 1, templateVersionId: 2 },
      timeout: 120_000,
    })
  })
})
