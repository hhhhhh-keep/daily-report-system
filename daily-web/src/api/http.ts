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

const REPORT_FIELD_LABELS: Record<string, string> = {
  employeeId: '请选择姓名',
  date: '请选择日报日期',
  attendance: '请选择出勤状态',
  'task.timePeriod': '请选择工作时段',
  'task.workType': '请选择工作任务类型',
  'task.workStage': '请选择工作阶段',
  'task.participationRole': '请选择参与角色',
  'task.progressResult': '请填写工作内容与产出',
  'task.currentStatus': '请选择当前状态',
}

function validationMessage(fieldErrors: Record<string, string>): string | null {
  const labels = [...new Set(Object.keys(fieldErrors)
    .map((field) => field.replace(/^tasks\[\d+\]\./, 'task.'))
    .map((field) => REPORT_FIELD_LABELS[field])
    .filter((label): label is string => Boolean(label)))]
  return labels.length ? `请完善以下内容：${labels.join('、')}` : null
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
    const fieldErrors = payload.fieldErrors ?? {}
    return {
      code: payload.code ?? 'REQUEST_FAILED',
      message: validationMessage(fieldErrors)
        ?? (payload.message && payload.message !== 'No message available'
          ? payload.message : '操作失败，请稍后重试。'),
      fieldErrors,
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
