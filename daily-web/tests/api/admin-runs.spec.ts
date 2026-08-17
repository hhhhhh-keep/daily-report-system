import { describe, expect, it, vi } from 'vitest'

const { post } = vi.hoisted(() => ({ post: vi.fn() }))
vi.mock('@/api/http', () => ({ http: { post } }))

import { adminApi } from '@/api/admin'

describe('adminApi.runNow', () => {
  it('allows enough time for the model-backed analysis to finish', () => {
    adminApi.runNow('2026-07-31', 'DAILY')

    expect(post).toHaveBeenCalledWith('/admin/runs', undefined, {
      params: { date: '2026-07-31', period: 'DAILY' },
      timeout: 240_000,
    })
  })
})
