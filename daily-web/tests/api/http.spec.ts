import { describe, expect, it } from 'vitest'
import { http } from '@/api/http'

describe('HTTP client', () => {
  it('targets the backend API and carries the administrator session cookie', () => {
    expect(http.defaults.baseURL).toBe('/api')
    expect(http.defaults.withCredentials).toBe(true)
  })
})
