import { http } from '@/api/http'

/** 后端统一分页响应包装（PageResponse<T>） */
export interface Page<T> {
  items: T[]
  totalItems: number
  page: number
  pageSize: number
  totalPages: number
}

export interface EmployeeRecord {
  id: number
  name: string
  teamName: string
  positionType: string
  active: boolean
}

export interface ProjectRecord {
  id: number
  name: string
  customerName: string | null
  industry: string | null
  projectStage: string | null
  ownerName: string | null
  priority: string | null
  status: string
  code: string | null
  formal: boolean
  systemKey: string | null
  active: boolean
}

export interface ProjectActivityTask {
  taskId: number
  reportDate: string
  employeeId: number
  employeeName: string
  workStage: string | null
  currentStatus: string
  progressResult: string
  issueType: string | null
  collaborationRequirement: string | null
}

export interface ProjectActivity {
  projectId: number
  participantCount: number
  latestReportDate: string | null
  blockedOrPausedCount: number
  derivedState: ProjectDerivedState | null
  stateEvents: ProjectStateEvent[]
  tasks: ProjectActivityTask[]
  /** 后端为分页后追加；当前后端把 page/pageSize/totalItems 平铺到顶层 */
  page?: number
  pageSize?: number
  totalItems?: number
}

export interface ProjectDerivedState {
  state: string
  lifecycle: string | null
  currentStage: string | null
  stateStartedDate: string
  triggerTaskId: number
}

export interface ProjectStateEvent {
  occurredDate: string
  state: string
  currentStage: string | null
  triggerTaskId: number
}

export interface DictionaryRecord {
  id: number
  category: string
  code: string
  label: string
  sortOrder: number
  active: boolean
}

export type WorkdaySource = 'ADMIN_OVERRIDE' | 'LEGAL_HOLIDAY' | 'MAKE_UP_WORKDAY'
  | 'COMPANY_WORKDAY' | 'COMPANY_REST_DAY'

export interface WorkdayCalendarRecord {
  id: number
  date: string
  workday: boolean
  source: WorkdaySource
  note: string | null
  active: boolean
}

export interface WorkdayCalendarImportItem {
  date: string
  workday: boolean
  source: Exclude<WorkdaySource, 'ADMIN_OVERRIDE'>
  note?: string | null
}

export interface ReportSummary {
  id: number
  date: string
  employeeId: number
  employeeName: string
  attendance: string
  status: string
  taskCount: number
}

export interface DashboardMetrics {
  date: string
  activeEmployeeCount: number
  submittedReportCount: number
  missingReportCount: number
  taskCount: number
  projectCount: number
  abnormalTaskCount: number
  morningTaskCount: number
  afternoonTaskCount: number
  submissionRate: number
  progress1730Rate: number
  progress1730SubmittedCount: number
  progress1730MissingCount: number
}

export interface AnalysisConfiguration {
  enabled: boolean
  cronExpression: string
  selectedDimensions: string[]
  ruleThresholds: Record<string, number>
  promptVersion: string
  promptTemplate: string
  dashboardEnabled: boolean
  reportEnabled: boolean
  emailEnabled: boolean
  recipients: string[]
  ccRecipients: string[]
  emailSubjectTemplate: string
  reportTemplate: string
  modelEndpoint: string | null
  modelName: string | null
  /** 真实 API key；留空时回落环境变量 LLM_API_KEY */
  modelApiKey: string | null
  smtpHost: string | null
  smtpPort: number | null
  smtpUsername: string | null
  smtpPassword: string | null
  smtpFrom: string | null
}

export interface ReportStatisticsConfiguration {
  earlySnapshotEnabled: boolean
  earlySnapshotCronExpression: string
  finalSnapshotEnabled: boolean
  finalSnapshotCronExpression: string
}

export type AnalysisPeriod = 'DAILY' | 'WEEKLY' | 'MONTHLY'
export type AnalysisSkillKind = 'RULE' | 'TEMPLATE'

export interface AnalysisSkillVersion {
  id: number
  period: AnalysisPeriod
  kind: AnalysisSkillKind
  versionNumber: number
  status: 'DRAFT' | 'PUBLISHED' | 'HISTORICAL'
  skillName: string
  description: string
  packageName: string
  checksum: string
  validationMessage: string
  trialSucceededAt: string | null
  publishedAt: string | null
  createdAt: string
}

export interface AnalysisSkillTrial {
  id: number
  period: AnalysisPeriod
  ruleSkillVersionId: number
  templateSkillVersionId: number
  periodStart: string
  periodEnd: string
  status: string
  analysisDraft: string | null
  renderedHtml: string | null
  errorSummary: string | null
  startedAt: string
  finishedAt: string | null
}

export interface AnalysisPeriodConfiguration {
  period: AnalysisPeriod
  enabled: boolean
  cronExpression: string
  enabledModules: string[]
  retentionMonths: number
  includeEvidenceInDelivery: boolean
}

export interface AnalysisRuleVersion {
  id: number
  period: AnalysisPeriod
  versionNumber: number
  status: 'DRAFT' | 'PUBLISHED' | 'HISTORICAL'
  changeNote: string
  rulesJson: string
  promptTemplate: string
  customSchemaJson: string
  trialSucceededAt: string | null
  publishedAt: string | null
}

export interface AnalysisRun {
  id: number
  analysisDate: string
  analysisPeriod: AnalysisPeriod | null
  periodStart: string | null
  periodEnd: string | null
  ruleVersionId: number | null
  promptVersion: string | null
  taskName: string
  triggerType: string
  status: string
  selectedDimensions: string[]
  startedAt: string
  finishedAt: string | null
  analyzedEmployeeCount: number
  advisoryText: string | null
  llmStatus: string | null
  reportAvailable: boolean
  reportFileName: string | null
  emailStatus: string
  errorSummary: string | null
  retryOfRunId: number | null
  retryCount: number
}

export interface DimensionResult {
  runId: number
  analysisDate: string
  dimension: string
  resultText: string
}

export const adminApi = {
  login: (username: string, password: string) =>
    http.post('/admin/session', { username, password }),
  session: () => http.get('/admin/session'),
  logout: () => http.delete('/admin/session'),
  changePassword: (currentPassword: string, newPassword: string) =>
    http.put('/admin/password', { currentPassword, newPassword }),
  employees: (params: { page?: number; size?: number } = {}) =>
    http.get<Page<EmployeeRecord>>('/admin/employees', { params }),
  createEmployee: (value: Omit<EmployeeRecord, 'id'>) =>
    http.post<EmployeeRecord>('/admin/employees', value),
  updateEmployee: (value: EmployeeRecord) =>
    http.put<EmployeeRecord>(`/admin/employees/${value.id}`, value),
  deleteEmployee: (id: number) => http.delete(`/admin/employees/${id}`),
  projects: (params: { page?: number; size?: number } = {}) =>
    http.get<Page<ProjectRecord>>('/admin/projects', { params }),
  createProject: (value: Omit<ProjectRecord, 'id'>) =>
    http.post<ProjectRecord>('/admin/projects', value),
  updateProject: (value: ProjectRecord) =>
    http.put<ProjectRecord>(`/admin/projects/${value.id}`, value),
  deleteProject: (id: number) => http.delete(`/admin/projects/${id}`),
  projectActivity: (id: number, params: { days?: number; page?: number; size?: number } = {}) =>
    http.get<ProjectActivity>(`/admin/projects/${id}/activity`, { params }),
  dictionaries: (params: { page?: number; size?: number } = {}) =>
    http.get<Page<DictionaryRecord>>('/admin/dictionaries', { params }),
  createDictionary: (value: Omit<DictionaryRecord, 'id'>) =>
    http.post<DictionaryRecord>('/admin/dictionaries', value),
  updateDictionary: (value: DictionaryRecord) =>
    http.put<DictionaryRecord>(`/admin/dictionaries/${value.id}`, value),
  deleteDictionary: (id: number) => http.delete(`/admin/dictionaries/${id}`),
  workdayCalendar: (year: number, params: { page?: number; size?: number } = {}) =>
    http.get<Page<WorkdayCalendarRecord>>('/admin/workday-calendar', { params: { year, ...params } }),
  saveWorkdayOverride: (value: { date: string; workday: boolean; note?: string | null }) =>
    http.put<WorkdayCalendarRecord>('/admin/workday-calendar/override', value),
  deleteWorkdayOverride: (date: string) =>
    http.delete(`/admin/workday-calendar/override/${date}`),
  importWorkdayCalendar: (year: number, entries: WorkdayCalendarImportItem[]) =>
    http.post<WorkdayCalendarRecord[]>('/admin/workday-calendar/import', { year, entries }),
  reports: (params: {
    date?: string
    employeeId?: number
    attendance?: string
    keyword?: string
    page?: number
    size?: number
  } = {}) =>
    http.get<Page<ReportSummary>>('/admin/reports', { params }),
  report: (id: number) => http.get(`/admin/reports/${id}`),
  dashboard: (date?: string) =>
    http.get<DashboardMetrics>('/admin/dashboard', { params: { date } }),
  analysisConfiguration: () =>
    http.get<AnalysisConfiguration>('/admin/configuration/analysis'),
  updateAnalysisConfiguration: (value: AnalysisConfiguration) =>
    http.put<AnalysisConfiguration>('/admin/configuration/analysis', value),
  testAnalysisConnection: (value: Pick<AnalysisConfiguration, 'modelEndpoint' | 'modelName' | 'modelApiKey'>) =>
    http.post<{ connected: boolean; message: string }>('/admin/configuration/analysis/test-connection', value),
  reportStatisticsConfiguration: () =>
    http.get<ReportStatisticsConfiguration>('/admin/configuration/report-statistics'),
  updateReportStatisticsConfiguration: (value: ReportStatisticsConfiguration) =>
    http.put<ReportStatisticsConfiguration>('/admin/configuration/report-statistics', value),
  analysisPeriodConfigurations: () =>
    http.get<AnalysisPeriodConfiguration[]>('/admin/configuration/analysis-periods'),
  updateAnalysisPeriodConfiguration: (value: AnalysisPeriodConfiguration) =>
    http.put<AnalysisPeriodConfiguration>(`/admin/configuration/analysis-periods/${value.period}`, value),
  analysisSkills: (period: AnalysisPeriod, kind: AnalysisSkillKind) =>
    http.get<AnalysisSkillVersion[]>(`/admin/analysis-skills/${period}/${kind}`),
  uploadAnalysisSkill: (period: AnalysisPeriod, kind: AnalysisSkillKind, file: File) => {
    const form = new FormData(); form.append('file', file)
    return http.post<AnalysisSkillVersion>(`/admin/analysis-skills/${period}/${kind}`, form)
  },
  downloadAnalysisSkill: (id: number) =>
    http.get(`/admin/analysis-skills/download/${id}`, { responseType: 'blob' }),
  trialAnalysisSkills: (period: AnalysisPeriod, endDate: string, ruleVersionId: number, templateVersionId: number) =>
    http.post<AnalysisSkillTrial>(`/admin/analysis-skills/${period}/trial`, undefined,
      { params: { endDate, ruleVersionId, templateVersionId }, timeout: 120_000 }),
  analysisSkillTrials: (period: AnalysisPeriod) =>
    http.get<AnalysisSkillTrial[]>(`/admin/analysis-skills/${period}/trials`),
  publishAnalysisSkills: (period: AnalysisPeriod, ruleVersionId: number, templateVersionId: number) =>
    http.post(`/admin/analysis-skills/${period}/publish`, undefined, { params: { ruleVersionId, templateVersionId } }),
  analysisRuleVersions: (period: AnalysisPeriod) =>
    http.get<AnalysisRuleVersion[]>(`/admin/analysis-rule-versions/${period}`),
  createAnalysisRuleVersion: (period: AnalysisPeriod, value: Omit<AnalysisRuleVersion,
    'id' | 'period' | 'versionNumber' | 'status' | 'trialSucceededAt' | 'publishedAt'>) =>
    http.post<AnalysisRuleVersion>(`/admin/analysis-rule-versions/${period}`, value),
  publishAnalysisRuleVersion: (id: number, allowUntriedFirstVersion = false) =>
    http.post<AnalysisRuleVersion>(`/admin/analysis-rule-versions/${id}/publish`, undefined,
      { params: { allowUntriedFirstVersion } }),
  runs: (params: { page?: number; size?: number } = {}) =>
    http.get<Page<AnalysisRun>>('/admin/runs', { params }),
  runNow: (date?: string, period: AnalysisPeriod = 'DAILY') =>
    http.post<AnalysisRun>('/admin/runs', undefined, { params: { date, period } }),
  retryRun: (id: number) => http.post<AnalysisRun>(`/admin/runs/${id}/retry`),
  latestAnalysis: () => http.get<DimensionResult[]>('/admin/analysis/latest'),
}
