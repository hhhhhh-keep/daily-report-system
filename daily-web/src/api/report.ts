import { http } from './http'

export interface EmployeeOption {
  id: number
  name: string
  teamName: string
  positionType: string
}

export interface ProjectOption {
  id: number
  name: string
  customerName?: string
  industry?: string
  projectStage?: string
  ownerName?: string
  priority?: string
  status: string
  code?: string
}

export interface DictionaryOption {
  id: number
  code: string
  label: string
}

export interface NonFormalOption {
  id: number
  code: string
  label: string
}

export interface ReportOptions {
  employees: EmployeeOption[]
  projects: ProjectOption[]
  dictionaries: Record<string, DictionaryOption[]>
  nonFormalOptions: NonFormalOption[]
}

export interface ReportTaskInput {
  id?: number
  timePeriod: string
  projectId: number | null
  projectName?: string
  workType: string
  workStage?: string
  participationRole: string
  progressResult: string
  currentStatus: string
  issueType?: string
  collaborationRole?: string
  collaborationRequirement?: string
}

export interface CurrentReportPayload {
  employeeId: number | null
  date: string
  attendance: string
  note?: string
  tasks: ReportTaskInput[]
}

export interface CurrentReport extends Omit<CurrentReportPayload, 'employeeId'> {
  id: number
  employeeId: number
  employeeName: string
  status: string
  submittedAt: string
  updatedAt: string
  tasks: Array<ReportTaskInput & { id: number; projectName: string }>
}

export const reportApi = {
  async options(): Promise<ReportOptions> {
    const response = await http.get<ReportOptions>('/report/options')
    return response.data
  },
  async current(employeeId: number, date: string): Promise<CurrentReport> {
    const response = await http.get<CurrentReport>('/reports', { params: { employeeId, date } })
    return response.data
  },
  async saveCurrent(payload: CurrentReportPayload): Promise<CurrentReport> {
    const response = await http.put<CurrentReport>('/reports/current', payload)
    return response.data
  },
}
