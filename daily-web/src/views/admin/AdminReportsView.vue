<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type DictionaryRecord, type EmployeeRecord, type Page, type ReportSummary } from '@/api/admin'
import { apiError } from '@/api/http'
import Pagination from '@/components/Pagination.vue'
import {
  ATTENDANCE_FILTER_OPTIONS,
  COLLABORATION_ROLE_LABELS,
  RISK_TYPE_LABELS,
  WORK_STAGE_LABELS,
  WORK_TYPE_LABELS,
  attendanceLabel,
  currentStatusLabel,
  dictionaryLabel,
  participationRoleLabel,
  timePeriodLabel,
} from '@/utils/labels'

interface TaskDetail {
  id: number
  timePeriod: string
  projectId: number | null
  projectName: string
  workType: string | null
  workStage: string | null
  participationRole: string
  progressResult: string
  currentStatus: string
  issueType: string | null
  collaborationRole: string | null
  collaborationRequirement: string | null
}

interface ReportDetail {
  id: number
  employeeId: number
  employeeName: string
  date: string
  attendance: string
  note: string | null
  status: string
  tasks: TaskDetail[]
}

const date = ref('')
const employeeId = ref<number | ''>('')
const keyword = ref('')
const attendances = ref<string[]>([])
const page = ref(0)
const pageSize = ref(20)
const loading = ref(false)
const rows = ref<ReportSummary[]>([])
const totalItems = ref(0)
const totalPages = ref(0)
const detail = ref<ReportDetail | null>(null)
const employees = ref<EmployeeRecord[]>([])
const dictionaries = ref<DictionaryRecord[]>([])
const error = ref('')
const detailError = ref('')

let loadToken = 0
async function load() {
  const token = ++loadToken
  loading.value = true
  try {
    const response = await adminApi.reports({
      date: date.value || undefined,
      employeeId: employeeId.value === '' ? undefined : Number(employeeId.value),
      attendance: attendances.value.length ? attendances.value.join(',') : undefined,
      keyword: keyword.value.trim() || undefined,
      page: page.value,
      size: pageSize.value,
    })
    if (token !== loadToken) return
    const data = response.data as Page<ReportSummary>
    rows.value = data.items
    totalItems.value = data.totalItems
    totalPages.value = data.totalPages
    detail.value = null
  } catch (caught) {
    if (token !== loadToken) return
    error.value = apiError(caught).message
  } finally {
    if (token === loadToken) loading.value = false
  }
}

function onPageChange() { load() }

async function open(id: number) {
  detailError.value = ''
  detail.value = null
  try {
    detail.value = (await adminApi.report(id)).data as ReportDetail
  } catch (caught) {
    detailError.value = apiError(caught).message
  }
}

async function loadFilters() {
  try {
    const [employeesRes, dictionariesRes] = await Promise.all([
      adminApi.employees(),
      adminApi.dictionaries(),
    ])
    employees.value = employeesRes.data.items.filter((item) => item.active)
    dictionaries.value = dictionariesRes.data.items.filter((item) => item.active)
  } catch (caught) {
    error.value = apiError(caught).message
  }
}

function toggleAttendance(code: string) {
  const index = attendances.value.indexOf(code)
  if (index === -1) attendances.value = [...attendances.value, code]
  else attendances.value = attendances.value.filter((value) => value !== code)
}

function resetFilters() {
  employeeId.value = ''
  keyword.value = ''
  attendances.value = []
}

let debounceHandle: number | undefined
function debounceLoad() {
  if (debounceHandle !== undefined) window.clearTimeout(debounceHandle)
  debounceHandle = window.setTimeout(() => { load() }, 250)
}

watch(keyword, () => { page.value = 0; debounceLoad() })
watch([date, employeeId, () => attendances.value.join(',')], () => { page.value = 0; load() })

// 阶段分类（售前/售中/售后）按 workStage code 前缀划分。
// 与 DailyTaskForm.vue 的 stageGroups 保持一致。
const stageGroups: ReadonlyArray<{ label: string; prefixes: string[] }> = [
  { label: '售前', prefixes: ['presales-'] },
  { label: '售中/交付', prefixes: ['delivery-'] },
  { label: '售后', prefixes: ['after-sales-'] },
]

function workStageCategory(code: string | null | undefined): string {
  if (!code) return '-'
  const match = stageGroups.find((group) => group.prefixes.some((prefix) => code.startsWith(prefix)))
  return match?.label ?? '其他'
}

function workStageLabel(code: string | null | undefined): string {
  return dictionaryLabel(dictionaries.value, 'work_stage', code, WORK_STAGE_LABELS)
}

function workTypeLabel(code: string | null | undefined): string {
  return dictionaryLabel(dictionaries.value, 'work_type', code, WORK_TYPE_LABELS)
}

const hasActiveFilter = computed(() =>
  employeeId.value !== '' || keyword.value.trim() !== '' || attendances.value.length > 0,
)

onMounted(async () => {
  await loadFilters()
  await load()
})
</script>

<template><AdminLayout><section class="admin-page">
  <div class="admin-title">
    <div><span class="eyebrow">REPORTS</span><h1>日报与任务明细</h1></div>
    <div class="admin-title-actions">
      <label>报告日期<input v-model="date" type="date" /></label>
      <button v-if="hasActiveFilter" type="button" class="button-link" @click="resetFilters">清空筛选</button>
    </div>
  </div>

  <div class="admin-form wide reports-filter" role="search">
    <label>员工
      <select v-model="employeeId">
        <option value="">全部员工</option>
        <option v-for="item in employees" :key="item.id" :value="item.id">{{ item.name }}（{{ item.teamName }}）</option>
      </select>
    </label>
    <label>关键字
      <input v-model="keyword" type="search" placeholder="匹配项目名称或工作内容" />
    </label>
    <div class="filter-chips">
      <span class="filter-chips-label">出勤</span>
      <button v-for="option in ATTENDANCE_FILTER_OPTIONS" :key="option.code" type="button"
        :class="['chip', { active: attendances.includes(option.code) }]"
        :aria-pressed="attendances.includes(option.code)" @click="toggleAttendance(option.code)">
        {{ option.label }}
      </button>
    </div>
  </div>

  <p v-if="error" class="feedback error" role="alert">{{ error }}</p>

  <div class="admin-table-wrap">
    <table>
      <thead><tr><th>日期</th><th>员工</th><th>出勤</th><th>任务数</th><th>操作</th></tr></thead>
      <tbody><tr v-for="row in rows" :key="row.id">
        <td>{{ row.date }}</td>
        <td>{{ row.employeeName }}</td>
        <td>{{ attendanceLabel(row.attendance) }}</td>
        <td>{{ row.taskCount }}</td>
        <td><button type="button" @click="open(row.id)">查看任务</button></td>
      </tr>
      <tr v-if="!rows.length"><td colspan="5" class="empty-row">当前筛选下没有日报</td></tr>
      </tbody>
    </table>
  </div>

  <Pagination v-model:page="page" v-model:page-size="pageSize"
    :total-items="totalItems" :total-pages="totalPages"
    :loading="loading" @change="onPageChange" />

  <p v-if="detailError" class="feedback error" role="alert">{{ detailError }}</p>

  <section v-if="detail" class="report-detail">
    <header class="report-detail-head">
      <div>
        <h2>{{ detail.employeeName }} · {{ detail.date }}</h2>
        <small>出勤 {{ attendanceLabel(detail.attendance) }} · 任务 {{ detail.tasks.length }} 条</small>
      </div>
      <button type="button" class="button-link" @click="detail = null">关闭详情</button>
    </header>
    <p v-if="detail.note" class="report-note">{{ detail.note }}</p>
    <article v-for="(task, index) in detail.tasks" :key="task.id">
      <header class="task-summary">
        <span class="task-summary-title">任务 {{ index + 1 }} · {{ timePeriodLabel(task.timePeriod) }} · {{ task.projectName }}</span>
        <small class="task-summary-status">{{ currentStatusLabel(task.currentStatus) }}</small>
      </header>
      <dl class="task-fields">
        <div><dt>工作任务类型</dt><dd>{{ workTypeLabel(task.workType) }}</dd></div>
        <div><dt>阶段分类</dt><dd>{{ workStageCategory(task.workStage) }}</dd></div>
        <div><dt>工作阶段</dt><dd>{{ workStageLabel(task.workStage) }}</dd></div>
        <div><dt>参与角色</dt><dd>{{ participationRoleLabel(task.participationRole) }}</dd></div>
        <div><dt>当前状态</dt><dd>{{ currentStatusLabel(task.currentStatus) }}</dd></div>
        <div class="task-fields-wide"><dt>工作内容与进展</dt><dd>{{ task.progressResult }}</dd></div>
        <template v-if="task.currentStatus === 'blocked'">
          <div><dt>问题类型</dt><dd>{{ dictionaryLabel(dictionaries, 'risk_type', task.issueType, RISK_TYPE_LABELS) }}</dd></div>
          <div><dt>需要协同角色</dt><dd>{{ dictionaryLabel(dictionaries, 'collaboration_role', task.collaborationRole, COLLABORATION_ROLE_LABELS) }}</dd></div>
          <div class="task-fields-wide"><dt>风险及协同需求</dt><dd>{{ task.collaborationRequirement || '-' }}</dd></div>
        </template>
      </dl>
    </article>
  </section>
</section></AdminLayout></template>

<style scoped>
.admin-title-actions { display: flex; gap: 12px; align-items: end; }
.reports-filter { margin-bottom: 0; }
.filter-chips { display: flex; flex-wrap: wrap; gap: 8px; align-items: center; min-height: 42px; }
.filter-chips-label { color: #667085; font-size: 0.82rem; font-weight: 600; }
.chip { padding: 6px 14px; border-radius: 999px; border: 1px solid #d0d5dd; background: #fff; color: #344054; font-weight: 600; font-size: 0.85rem; }
.chip:hover { border-color: #84adff; }
.chip.active { background: #155eef; border-color: #155eef; color: #fff; }
.empty-row { text-align: center; color: #667085; padding: 28px 12px; }
.report-detail-head { display: flex; justify-content: space-between; align-items: start; gap: 16px; }
.report-detail-head small { display: block; margin-top: 6px; color: #667085; }
.report-note { padding: 12px 14px; border-radius: 10px; background: #f8fafc; color: #344054; }
.task-summary { display: flex; justify-content: space-between; align-items: center; gap: 12px; }
.task-summary-title { color: #101828; font-weight: 700; }
.task-summary-status { color: #155eef; font-weight: 600; }
.task-fields { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px 18px; margin: 6px 0 0; }
.task-fields > div { margin: 0; }
.task-fields dt { color: #667085; font-size: 0.78rem; font-weight: 600; letter-spacing: 0.04em; }
.task-fields dd { margin: 2px 0 0; color: #101828; line-height: 1.55; white-space: pre-wrap; word-break: break-word; }
.task-fields-wide { grid-column: 1 / -1; }
</style>
