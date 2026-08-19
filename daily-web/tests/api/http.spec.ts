import { AxiosError, type AxiosResponse } from 'axios'
import { describe, expect, it, vi } from 'vitest'
import { adminApi } from '@/api/admin'
import { apiError, http } from '@/api/http'

describe('HTTP client', () => {
  it('targets the backend API and carries the administrator session cookie', () => {
    expect(http.defaults.baseURL).toBe('/api')
    expect(http.defaults.withCredentials).toBe(true)
  })

  it('silences the session probe while keeping it credentialed', async () => {
    const get = vi.spyOn(http, 'get').mockResolvedValue({ data: {} } as never)
    await adminApi.session()
    expect(get).toHaveBeenCalledWith('/admin/session', { silent: true })
  })

  it('replaces an empty backend error message with a readable Chinese message', () => {
    const response = { data: { message: 'No message available' } } as AxiosResponse
    const error = new AxiosError('request failed', undefined, undefined, undefined, response)
    expect(apiError(error).message).toBe('操作失败，请稍后重试。')
  })
})
