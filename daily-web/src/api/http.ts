import axios, { AxiosError } from 'axios'
import { notify } from '@/utils/toast'

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
    notify(apiError(error).message, 'error')
    return Promise.reject(error)
  },
)

export function apiError(error: unknown): ApiErrorPayload {
  if (error instanceof AxiosError && error.response?.data) {
    return error.response.data as ApiErrorPayload
  }
  return {
    code: 'NETWORK_ERROR',
    message: '暂时无法连接服务器，请稍后重试。',
    fieldErrors: {},
    correlationId: '',
    timestamp: new Date().toISOString(),
  }
}
