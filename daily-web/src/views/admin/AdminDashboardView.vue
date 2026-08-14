<script setup lang="ts">
import { onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type DashboardMetrics } from '@/api/admin'
import { apiError } from '@/api/http'

const date = ref(new Date().toLocaleDateString('en-CA'))
const metrics = ref<DashboardMetrics | null>(null)
const error = ref('')
async function load() {
  try { metrics.value = (await adminApi.dashboard(date.value)).data; error.value = '' }
  catch (caught) { error.value = apiError(caught).message }
}
onMounted(load)
</script>

<template><AdminLayout><section class="admin-page"><div class="admin-title"><div><span class="eyebrow">DASHBOARD</span><h1>管理驾驶舱</h1></div><label>统计日期<input v-model="date" type="date" @change="load" /></label></div>
  <p v-if="error" class="feedback error">{{ error }}</p><div v-if="metrics" class="metric-grid">
    <article><strong>{{ metrics.submittedReportCount }}</strong><span>已提交日报</span></article><article><strong>{{ metrics.missingReportCount }}</strong><span>未填人员</span></article><article><strong>{{ metrics.submissionRate }}%</strong><span>当前填报率</span></article>
    <article><strong>{{ metrics.progress1730Rate }}%</strong><span>17:30 填报率</span><small>{{ metrics.progress1730SubmittedCount }} 已填 / {{ metrics.progress1730MissingCount }} 未填</small></article>
    <article><strong>{{ metrics.taskCount }}</strong><span>工作任务</span></article><article><strong>{{ metrics.projectCount }}</strong><span>涉及项目</span></article><article><strong>{{ metrics.abnormalTaskCount }}</strong><span>风险 / 阻碍</span></article><article><strong>{{ metrics.morningTaskCount }}</strong><span>上午任务</span></article><article><strong>{{ metrics.afternoonTaskCount }}</strong><span>下午任务</span></article>
  </div></section></AdminLayout></template>
