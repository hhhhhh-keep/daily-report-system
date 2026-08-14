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
  try { const run = (await adminApi.retryRun(id)).data; message.value = `重试运行 #${run.id}：${run.status}`; await load() }
  catch (caught) { message.value = apiError(caught).message }
}
onMounted(load)
</script>

<template><AdminLayout><section class="admin-page">
  <div class="admin-title"><div><span class="eyebrow">TASK RUNS</span><h1>分析任务记录</h1></div><button type="button" @click="load">刷新</button></div>
  <p v-if="message" class="feedback" role="status">{{ message }}</p>
  <div class="admin-table-wrap"><table><thead><tr><th>日期</th><th>触发</th><th>状态</th><th>人数</th><th>LLM</th><th>邮件</th><th>错误</th><th>操作</th></tr></thead>
    <tbody><tr v-for="run in runs" :key="run.id"><td>{{ run.analysisDate }}<small>#{{ run.id }}</small></td><td>{{ run.triggerType }}</td><td>{{ run.status }}</td>
      <td>{{ run.analyzedEmployeeCount }}</td><td>{{ run.llmStatus }}</td><td>{{ run.emailStatus }}</td><td>{{ run.errorSummary || '—' }}</td><td class="table-actions">
        <a v-if="run.reportAvailable" :href="`/api/admin/runs/${run.id}/report.pdf`">PDF</a>
        <button v-if="['failed','partial-failure'].includes(run.status)" type="button" @click="retry(run.id)">重新执行</button>
      </td></tr></tbody></table></div>
  <Pagination v-model:page="page" v-model:page-size="pageSize"
    :total-items="totalItems" :total-pages="totalPages"
    :loading="loading" @change="load" />
</section></AdminLayout></template>
