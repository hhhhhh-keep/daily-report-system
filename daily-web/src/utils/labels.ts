// 中文标签映射：把后端返回的英文枚举 code 翻译成展示用的中文。
// 数据库与 Java enum 值都不变，只在 UI 渲染时做映射。
//
// 不在字典里的字典类型（work_type / work_stage 等）走
// dictionaryLookup()，从 /admin/dictionaries 拉的 business_dictionaries 解析。

export const ATTENDANCE_LABELS: Record<string, string> = {
  present: '出勤',
  leave: '请假',
  remote: '远程',
  business_trip: '出差',
  resting: '休息',
  sick_leave: '病假',
  personal_leave: '事假',
}

export const TIME_PERIOD_LABELS: Record<string, string> = {
  morning: '上午',
  afternoon: '下午',
  'full-day': '全天',
}

export const CURRENT_STATUS_LABELS: Record<string, string> = {
  started: '已启动',
  'in-progress': '进行中',
  completed: '已完成',
  blocked: '遇到阻碍',
  paused: '暂停/搁置',
}

export const PARTICIPATION_ROLE_LABELS: Record<string, string> = {
  owner: '主责',
  collaborator: '协同',
}

// 这些 code 在业务上是稳定字典，但展示文案会随运营调整；
// 优先用字典查，没有回落到静态映射。保持一份 fallback 以防字典未拉到。
export const WORK_TYPE_LABELS: Record<string, string> = {
  'project-support': '行业/项目支撑',
  'special-work': '专项工作',
}

export const WORK_STAGE_LABELS: Record<string, string> = {
  'requirements-analysis': '需求调研与分析',
  'solution-design': '方案编写/设计',
  'bid-quotation': '投标/报价支持',
  'technical-presentation': '技术交流/演示汇报',
  implementation: '开发/配置/实施',
  'testing-deployment': '测试/上线部署',
  'training-acceptance': '培训/验收交付',
  'operations-support': '运维保障',
  'incident-handling': '故障/问题处理',
  'optimization-upgrade': '优化升级',
  'customer-support': '客户持续支撑',
  // 历史 code（V005 之前的 workStage 旧值）
  'presales-requirements-analysis': '售前·需求调研',
  'presales-solution-design': '售前·方案设计',
  'presales-bid-quotation': '售前·投标报价',
  'presales-technical-presentation': '售前·技术演示',
  'delivery-implementation': '售中·实施',
  'delivery-testing-deployment': '售中·测试部署',
  'delivery-training-acceptance': '售中·培训验收',
  'after-sales-operations-support': '售后·运维',
  'after-sales-incident-handling': '售后·故障处理',
  'after-sales-optimization-upgrade': '售后·优化升级',
  'after-sales-customer-support': '售后·客户支撑',
}

export const RISK_TYPE_LABELS: Record<string, string> = {
  'requirement-change': '需求变更',
  'resource-shortage': '资源不足',
  'technical-issue': '技术难题',
  'external-dependency': '外部依赖',
  'communication-gap': '沟通协同',
}

export const COLLABORATION_ROLE_LABELS: Record<string, string> = {
  pm: '项目经理',
  architect: '架构师',
  qa: '测试',
  ops: '运维',
  bd: '商务',
  other: '其他',
}

export type DictionaryCategory = 'work_type' | 'work_stage' | 'participation_role' | 'current_status' | 'risk_type' | 'collaboration_role'

export interface DictionaryEntry { id: number; category: string; code: string; label: string }

/**
 * 把 (category, code) 翻译成 label。优先查 dict，缺失再走静态 fallback，
 * 再缺失返回 `code`，让前端能看到原始值。
 */
export function dictionaryLabel(
  dictionaries: DictionaryEntry[],
  category: DictionaryCategory | string,
  code: string | null | undefined,
  fallback?: Record<string, string>,
): string {
  if (!code) return '-'
  const fromDict = dictionaries.find((entry) => entry.category === category && entry.code === code)
  if (fromDict) return fromDict.label
  const fromFallback = fallback?.[code]
  if (fromFallback) return fromFallback
  return code
}

/** 暴露给模板用的 helper，避免每处都手写三目。 */
export function attendanceLabel(code: string | null | undefined): string {
  return code ? (ATTENDANCE_LABELS[code] ?? code) : '-'
}

export function timePeriodLabel(code: string | null | undefined): string {
  return code ? (TIME_PERIOD_LABELS[code] ?? code) : '-'
}

export function currentStatusLabel(code: string | null | undefined): string {
  return code ? (CURRENT_STATUS_LABELS[code] ?? code) : '-'
}

export function participationRoleLabel(code: string | null | undefined): string {
  return code ? (PARTICIPATION_ROLE_LABELS[code] ?? code) : '-'
}

/**
 * 列出所有可用于 chips 过滤的出勤类型选项。`code` 是后端存的英文枚举值，
 * `label` 是给用户看的中文。
 */
export const ATTENDANCE_FILTER_OPTIONS: Array<{ code: string; label: string }> = [
  { code: 'present', label: ATTENDANCE_LABELS.present ?? '正常出勤' },
  { code: 'leave', label: ATTENDANCE_LABELS.leave ?? '请假' },
  { code: 'remote', label: ATTENDANCE_LABELS.remote ?? '远程办公' },
  { code: 'business_trip', label: ATTENDANCE_LABELS.business_trip ?? '出差' },
]
