<script setup lang="ts">
import { onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type AnalysisRun, type Page } from '@/api/admin'
import { apiError } from '@/api/http'
import Pagination from '@/components/Pagination.vue'

const runs = ref<AnalysisRun[]>([])
const totalItems = ref(0)
const totalPages = ref(0)
const page = ref(0)
const pageSize = ref(20)
const loading = ref(false)
const message = ref('')
const triggerLabels: Record<string, string> = { manual: '手动执行', scheduled: '计划执行', retry: '重新执行' }
const runStatusLabels: Record<string, string> = {
  succeeded: '成功', 'partial-failure': '部分失败', failed: '失败', running: '运行中',
}
const llmStatusLabels: Record<string, string> = { succeeded: '成功', failed: '失败', skipped: '未执行' }
const emailStatusLabels: Record<string, string> = {
  sent: '已发送', failed: '发送失败', 'not-requested': '未启用', skipped: '未发送',
}
function label(value: string | null | undefined, labels: Record<string, string>, fallback = '未执行') {
  return labels[value?.toLowerCase() || ''] || fallback
}
async function load() {
  loading.value = true
  try {
    const data = (await adminApi.runs({ page: page.value, size: pageSize.value })).data as Page<AnalysisRun>
    runs.value = data.items
    totalItems.value = data.totalItems
    totalPages.value = data.totalPages
  } finally {
    loading.value = false
  }
}
async function retry(id: number) {
  try { const run = (await adminApi.retryRun(id)).data; message.value = `已重新执行 #${run.id}：${label(run.status, runStatusLabels, '未知')}`; await load() }
  catch (caught) { message.value = apiError(caught).message }
}
onMounted(load)
</script>

<template><AdminLayout><section class="admin-page">
  <div class="admin-title"><div><span class="eyebrow">TASK RUNS</span><h1>分析任务记录</h1></div><button type="button" @click="load">刷新</button></div>
  <p class="feedback">这里汇总计划执行、分析中心手动执行和失败后的重新执行。任务触发后可查看分析状态、报告附件、模型处理和邮件发送结果。</p>
  <p v-if="message" class="feedback" role="status">{{ message }}</p>
  <div class="admin-table-wrap"><table><thead><tr><th>日期</th><th>触发</th><th>状态</th><th>人数</th><th>LLM</th><th>邮件</th><th>错误</th><th>操作</th></tr></thead>
    <tbody><tr v-for="run in runs" :key="run.id"><td>{{ run.analysisDate }}<small>#{{ run.id }}</small></td><td>{{ label(run.triggerType, triggerLabels, '其他触发') }}</td><td>{{ label(run.status, runStatusLabels, '未知') }}</td>
      <td>{{ run.analyzedEmployeeCount }}</td><td>{{ label(run.llmStatus, llmStatusLabels) }}</td><td>{{ label(run.emailStatus, emailStatusLabels) }}</td><td>{{ run.errorSummary || '—' }}</td><td class="table-actions">
        <a v-if="run.reportAvailable" :href="`/api/admin/runs/${run.id}/report`">{{ run.reportFileName || '下载报告附件' }}</a>
        <button v-if="['failed','partial-failure'].includes(run.status)" type="button" @click="retry(run.id)">重新执行</button>
      </td></tr></tbody></table></div>
  <Pagination v-model:page="page" v-model:page-size="pageSize"
    :total-items="totalItems" :total-pages="totalPages"
    :loading="loading" @change="load" />
</section></AdminLayout></template>
