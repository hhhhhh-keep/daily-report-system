<script setup lang="ts">
import { onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type AnalysisPeriod, type AnalysisRun } from '@/api/admin'
import { apiError } from '@/api/http'

const runs = ref<AnalysisRun[]>([])
const pending = ref(false)
const message = ref('')
const period = ref<AnalysisPeriod>('DAILY')
const endDate = ref(new Date().toISOString().slice(0, 10))
function runStatus(value: string | null | undefined) {
  const statuses: Record<string, string> = {
    succeeded: '成功', 'partial-failure': '部分失败', failed: '失败', running: '运行中',
  }
  return statuses[value?.toLowerCase() || ''] || '未知'
}
function llmStatus(value: string | null | undefined) {
  const statuses: Record<string, string> = { succeeded: '成功', failed: '失败', skipped: '未执行' }
  return statuses[value?.toLowerCase() || ''] || '未执行'
}
function emailStatus(value: string | null | undefined) {
  const statuses: Record<string, string> = {
    sent: '已发送', failed: '发送失败', 'skipped-duplicate': '已跳过（该日期已发送）',
    'not-requested': '未启用',
  }
  return statuses[value?.toLowerCase() || ''] || '未执行'
}
function reportStatus(run: AnalysisRun) {
  if (run.reportAvailable) return '已生成'
  if (run.status?.toLowerCase() === 'running') return '生成中'
  return '未生成'
}
function aiStatus(value: string | null | undefined) {
  const statuses: Record<string, string> = {
    succeeded: '已生效', failed: '已降级', skipped: '未调用',
  }
  return statuses[value?.toLowerCase() || ''] || '未执行'
}
function fallbackReason(value: string | null | undefined) {
  return value?.startsWith('AI 语义分析未通过证据校验')
    ? 'AI 分析未通过证据校验，已生成基础报告，可重新试运行。'
    : value || '—'
}
function periodName(value: string | null | undefined) {
  return value === 'WEEKLY' ? '周报' : value === 'MONTHLY' ? '月报' : '日报'
}
function formatRunTime(value: string | null | undefined) {
  if (!value) return '—'
  return new Intl.DateTimeFormat('zh-CN', {
    timeZone: 'Asia/Shanghai', year: 'numeric', month: '2-digit', day: '2-digit',
    hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false,
  }).format(new Date(value)).replace(/\//g, '-')
}
async function load() { runs.value = (await adminApi.runs({ size: 20 })).data.items }
async function runNow() {
  pending.value = true
  try {
    const response = await adminApi.runNow(endDate.value, period.value)
    const run = response.data
    message.value = `分析完成。运行：${runStatus(run.status)}；AI：${llmStatus(run.llmStatus)}；邮件：${emailStatus(run.emailStatus)}`
    await load()
  }
  catch (caught) { message.value = apiError(caught).message }
  finally { pending.value = false }
}
function downloadReport(run: AnalysisRun) { window.open(`/api/admin/runs/${run.id}/report`, '_blank') }
onMounted(load)
</script>

<template>
  <AdminLayout><section class="admin-page">
    <div class="admin-title"><div><span class="eyebrow">分析中心</span><h1>AI 分析中心</h1></div></div>
    <section class="form-card"><h2>手动运行分析</h2><p>用于补跑指定周期、核验规则效果或即时生成管理结论；不改变已保存的日报内容。</p>
      <div class="admin-actions"><label>分析周期<select v-model="period"><option value="DAILY">日报</option><option value="WEEKLY">周报</option><option value="MONTHLY">月报</option></select></label><label>分析结束日期<input v-model="endDate" data-testid="analysis-end-date" type="date" /></label><button class="button-primary" data-testid="run-analysis" :disabled="pending" type="button" @click="runNow">{{ pending ? '分析中…' : '运行分析' }}</button></div>
      <p v-if="pending" class="feedback" role="status">AI 分析中，预计需要 1～3 分钟，请勿重复提交。</p>
      <p v-if="message" class="feedback" role="status">{{ message }}</p>
    </section>
    <section v-if="runs.length" class="form-card" aria-label="任务记录"><span class="eyebrow">任务记录</span><h2>最近分析任务</h2><div class="admin-table-wrap"><table><thead><tr><th>分析周期</th><th>分析截止日</th><th>运行时间</th><th>报告状态</th><th>AI 分析状态</th><th>AI 降级原因</th><th>邮件状态</th><th>失败原因</th><th>操作</th></tr></thead><tbody><tr v-for="run in runs" :key="run.id"><td>{{ periodName(run.analysisPeriod) }}</td><td>{{ run.analysisDate }}</td><td>{{ formatRunTime(run.startedAt) }}</td><td>{{ reportStatus(run) }}</td><td>{{ aiStatus(run.llmStatus) }}</td><td>{{ fallbackReason(run.llmErrorSummary) }}</td><td>{{ emailStatus(run.emailStatus) }}</td><td>{{ fallbackReason(run.errorSummary) }}</td><td><button v-if="run.reportAvailable" class="button-secondary" type="button" @click="downloadReport(run)">下载附件</button><span v-else>—</span></td></tr></tbody></table></div></section>
    <p v-else class="feedback">暂无任务记录。请选择周期和结束日期后手动运行分析。</p>
  </section></AdminLayout>
</template>
