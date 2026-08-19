import axios, { AxiosError } from 'axios'
import { notify } from '@/utils/toast'

declare module 'axios' {
  interface AxiosRequestConfig {
    silent?: boolean
  }
}

export interface ApiErrorPayload {
  code: string
  message: string
  fieldErrors: Record<string, string>
  correlationId: string
  timestamp: string
}

export const http = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
  timeout: 15_000,
  withCredentials: true,
  headers: { Accept: 'application/json' },
})

http.interceptors.response.use(
  (response) => {
    if (['post', 'put', 'patch', 'delete'].includes(response.config.method?.toLowerCase() ?? '')) notify('操作已完成')
    return response
  },
  (error) => {
    if (!error.config?.silent) notify(apiError(error).message, 'error')
    return Promise.reject(error)
  },
)

export function apiError(error: unknown): ApiErrorPayload {
  if (error instanceof AxiosError && error.response?.data) {
    const payload = error.response.data as Partial<ApiErrorPayload>
    return {
      code: payload.code ?? 'REQUEST_FAILED',
      message: payload.message && payload.message !== 'No message available'
        ? payload.message : '操作失败，请稍后重试。',
      fieldErrors: payload.fieldErrors ?? {},
      correlationId: payload.correlationId ?? '',
      timestamp: payload.timestamp ?? new Date().toISOString(),
    }
  }
  return {
    code: 'NETWORK_ERROR',
    message: '暂时无法连接服务器，请稍后重试。',
    fieldErrors: {},
    correlationId: '',
    timestamp: new Date().toISOString(),
  }
}
