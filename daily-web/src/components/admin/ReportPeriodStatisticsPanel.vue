<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { adminApi, type ReportPeriodStatistics } from '@/api/admin'
import { apiError } from '@/api/http'
import Pagination from '@/components/Pagination.vue'

const periodMode = ref<'WEEKLY' | 'MONTHLY' | 'CUSTOM'>('WEEKLY')
const periodStatistics = ref<ReportPeriodStatistics | null>(null)
const periodLoading = ref(false)
const periodStart = ref('')
const periodEnd = ref(localIsoDate())
const periodPage = ref(0)
const periodPageSize = ref(20)
const periodExporting = ref(false)
const error = ref('')

function localIsoDate() {
  const now = new Date()
  const offset = now.getTimezoneOffset() * 60_000
  return new Date(now.getTime() - offset).toISOString().slice(0, 10)
}

async function loadPeriodStatistics() {
  periodLoading.value = true
  try {
    const response = periodMode.value === 'CUSTOM'
      ? await adminApi.reportPeriodStatistics('CUSTOM', periodStart.value, periodEnd.value)
      : await adminApi.reportPeriodStatistics(periodMode.value, periodEnd.value)
    periodStatistics.value = response.data
    periodStart.value = response.data.periodStart
    periodEnd.value = response.data.periodEnd
    periodPage.value = 0
    error.value = ''
  } catch (caught) {
    error.value = apiError(caught).message
  } finally {
    periodLoading.value = false
  }
}

async function switchPeriod(value: 'WEEKLY' | 'MONTHLY') {
  periodMode.value = value
  await loadPeriodStatistics()
}

async function queryCustomPeriod() {
  if (!periodStart.value || !periodEnd.value) {
    error.value = '请选择统计开始日期和结束日期。'
    return
  }
  if (periodStart.value > periodEnd.value) {
    error.value = '统计开始日期不能晚于结束日期。'
    return
  }
  periodMode.value = 'CUSTOM'
  await loadPeriodStatistics()
}

async function exportPeriodStatistics() {
  if (!periodStatistics.value) return
  periodExporting.value = true
  try {
    const response = await adminApi.exportReportPeriodStatistics(
      periodStatistics.value.periodStart,
      periodStatistics.value.periodEnd,
    )
    if (typeof URL.createObjectURL !== 'function') return
    const url = URL.createObjectURL(response.data as Blob)
    const link = document.createElement('a')
    link.href = url
    link.download = `填报累计统计_${periodStart.value}至${periodEnd.value}.xlsx`
    link.click()
    URL.revokeObjectURL(url)
  } catch (caught) {
    error.value = apiError(caught).message
  } finally {
    periodExporting.value = false
  }
}

const periodPeople = computed(() => {
  const people = periodStatistics.value?.people ?? []
  const start = periodPage.value * periodPageSize.value
  return people.slice(start, start + periodPageSize.value)
})
const periodTotalItems = computed(() => periodStatistics.value?.people.length ?? 0)
const periodTotalPages = computed(() => Math.ceil(periodTotalItems.value / periodPageSize.value))
function coverageLabel(value: ReportPeriodStatistics['coverageMode']) {
  const labels: Record<ReportPeriodStatistics['coverageMode'], string> = {
    FROZEN_SNAPSHOTS: '全部使用已冻结的 22:00 快照',
    MIXED_SNAPSHOT_FALLBACK: '部分使用已冻结快照，其余按当前员工名单回算',
    CURRENT_ROSTER_FALLBACK: '按当前员工名单回算（所选日期暂无 22:00 快照）',
  }
  return labels[value]
}

onMounted(loadPeriodStatistics)
</script>

<template>
  <section class="period-statistics form-card" aria-labelledby="period-statistics-title">
    <header class="period-statistics-head">
      <div>
        <span class="eyebrow">PERIOD SUMMARY</span>
        <h2 id="period-statistics-title">填报累计统计</h2>
        <small v-if="periodStatistics">{{ periodStatistics.periodStart }} 至 {{ periodStatistics.periodEnd }} · {{ periodStatistics.workdayCount }} 个工作日</small>
        <small v-if="periodStatistics" class="period-coverage">统计依据：{{ coverageLabel(periodStatistics.coverageMode) }}</small>
      </div>
    </header>
    <div v-if="periodStatistics" class="period-summary-grid">
      <article><strong>{{ periodStatistics.totals.expectedReportCount }}</strong><span>应填</span></article>
      <article><strong>{{ periodStatistics.totals.earlySubmittedCount }}</strong><span>17:30前填写</span></article>
      <article><strong>{{ periodStatistics.totals.missingCount }}</strong><span>未填</span></article>
      <article><strong>{{ periodStatistics.totals.earlySubmissionRate }}%</strong><span>早填率</span></article>
    </div>
    <details class="period-statistics-details">
      <summary>查看 / 调整统计明细</summary>
      <p v-if="error" class="feedback error" role="alert">{{ error }}</p>
      <div class="period-tabs" aria-label="统计周期">
        <button type="button" data-testid="period-weekly" :class="{ active: periodMode === 'WEEKLY' }" @click="switchPeriod('WEEKLY')">周统计</button>
        <button type="button" data-testid="period-monthly" :class="{ active: periodMode === 'MONTHLY' }" @click="switchPeriod('MONTHLY')">月统计</button>
      </div>
      <div class="period-statistics-controls">
        <label>统计开始日期<input v-model="periodStart" data-testid="period-start" type="date" /></label>
        <label>统计结束日期<input v-model="periodEnd" data-testid="period-end" type="date" /></label>
        <button class="button-secondary" type="button" data-testid="period-query" :disabled="periodLoading" @click="queryCustomPeriod">查询统计</button>
        <button class="button-primary" type="button" data-testid="period-export" :disabled="!periodStatistics || periodExporting" @click="exportPeriodStatistics">{{ periodExporting ? '正在导出…' : '导出 Excel' }}</button>
      </div>
      <div v-if="periodStatistics" class="admin-table-wrap">
        <table>
          <thead><tr><th>人员</th><th>应填</th><th>17:30前填写</th><th>早填率</th><th>未填</th><th>请假次数</th><th>请假折算天数</th><th>培训次数</th></tr></thead>
          <tbody>
            <tr class="period-total"><td>部门合计</td><td>{{ periodStatistics.totals.expectedReportCount }}</td><td>{{ periodStatistics.totals.earlySubmittedCount }}</td><td>{{ periodStatistics.totals.earlySubmissionRate }}%</td><td>{{ periodStatistics.totals.missingCount }}</td><td>{{ periodStatistics.totals.leaveOccurrences }}</td><td>{{ periodStatistics.totals.leaveEquivalentDays }}</td><td>{{ periodStatistics.totals.trainingCount }}</td></tr>
            <tr v-for="person in periodPeople" :key="person.employeeId"><td>{{ person.employeeName }}<small>{{ person.teamName }}</small></td><td>{{ person.expectedReportCount }}</td><td>{{ person.earlySubmittedCount }}</td><td>{{ person.earlySubmissionRate }}%</td><td>{{ person.missingCount }}</td><td>{{ person.leaveOccurrences }}</td><td>{{ person.leaveEquivalentDays }}</td><td>{{ person.trainingCount }}</td></tr>
            <tr v-if="!periodStatistics.people.length"><td colspan="8" class="empty-row">当前周期暂无人员数据</td></tr>
          </tbody>
        </table>
      </div>
      <p v-else class="empty-row">{{ periodLoading ? '正在统计…' : '当前周期暂无统计数据' }}</p>
      <Pagination v-if="periodStatistics" v-model:page="periodPage" v-model:page-size="periodPageSize" :total-items="periodTotalItems" :total-pages="periodTotalPages" :loading="periodLoading" />
    </details>
  </section>
</template>

<style scoped>
.period-statistics { margin-top: 24px; }
.period-statistics-head { display: flex; justify-content: space-between; align-items: end; gap: 16px; }
.period-statistics-head h2 { margin: 3px 0; }
.period-statistics-head small { color: #667085; }
.period-statistics-details { margin-top: 18px; }
.period-statistics-details summary { color: #155eef; cursor: pointer; font-weight: 700; }
.period-statistics-details[open] summary { margin-bottom: 18px; }
.period-tabs { display: flex; gap: 8px; }
.period-tabs button { border: 1px solid #d0d5dd; background: #fff; color: #344054; border-radius: 8px; padding: 8px 16px; font-weight: 700; }
.period-tabs button.active { background: #155eef; color: #fff; border-color: #155eef; }
.period-statistics-controls { display: flex; flex-wrap: wrap; gap: 12px; align-items: end; margin: 18px 0; }
.period-statistics-controls label { display: grid; gap: 6px; color: #344054; font-size: 0.84rem; font-weight: 600; }
.period-statistics-controls input { min-height: 38px; }
.period-summary-grid { display: grid; grid-template-columns: repeat(4, minmax(120px, 1fr)); gap: 12px; margin-bottom: 18px; }
.period-summary-grid article { display: grid; gap: 4px; padding: 14px; background: #eff4ff; border-radius: 10px; }
.period-summary-grid strong { color: #101828; font-size: 1.35rem; }
.period-summary-grid span, .period-statistics td small { color: #667085; font-size: 0.84rem; }
.period-total { background: #eff4ff; font-weight: 700; }
@media (max-width: 640px) { .period-summary-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
</style>
