<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type AnalysisPeriod, type DimensionResult } from '@/api/admin'
import { apiError } from '@/api/http'

type Conclusion = { title: string; summary: string; evidence: string[]; recommendation: string }
type AnalysisSummary = { result: DimensionResult; conclusions: Conclusion[] }
const results = ref<DimensionResult[]>([])
const pending = ref(false)
const message = ref('')
const period = ref<AnalysisPeriod>('DAILY')
const endDate = ref(new Date().toISOString().slice(0, 10))
const detailViewer = ref<AnalysisSummary | null>(null)

function parseConclusions(resultText: string): Conclusion[] {
  try {
    const parsed = JSON.parse(resultText) as { conclusions?: Conclusion[] }
    if (Array.isArray(parsed.conclusions)) return parsed.conclusions
  } catch { /* 兼容旧版非结构化结果 */ }
  return [{ title: '分析结论', summary: resultText || '本次未生成可展示的结论。', evidence: [], recommendation: '请结合日报原始记录进一步核实。' }]
}
const summaries = computed<AnalysisSummary[]>(() => results.value.map(result => ({ result, conclusions: parseConclusions(result.resultText) })))
function conclusionCount(summary: AnalysisSummary) { return summary.conclusions.length }
function summaryText(summary: AnalysisSummary) { return summary.conclusions[0]?.summary || '本次未发现需要关注的事项。' }
async function load() { results.value = (await adminApi.latestAnalysis()).data }
async function runNow() {
  pending.value = true
  try { await adminApi.runNow(endDate.value, period.value); message.value = '本次手动分析已完成，结果已刷新。'; await load() }
  catch (caught) { message.value = apiError(caught).message }
  finally { pending.value = false }
}
function viewDetail(summary: AnalysisSummary) { detailViewer.value = summary }
onMounted(load)
</script>

<template>
  <AdminLayout><section class="admin-page">
    <div class="admin-title"><div><span class="eyebrow">分析中心</span><h1>AI 分析中心</h1></div></div>
    <section class="form-card"><h2>手动运行分析</h2><p>用于补跑指定周期、核验规则效果或即时生成管理结论；不改变已保存的日报内容。</p>
      <div class="admin-actions"><label>分析周期<select v-model="period"><option value="DAILY">日报</option><option value="WEEKLY">周报</option><option value="MONTHLY">月报</option></select></label><label>分析结束日期<input v-model="endDate" data-testid="analysis-end-date" type="date" /></label><button class="button-primary" data-testid="run-analysis" :disabled="pending" type="button" @click="runNow">{{ pending ? '分析中…' : '运行分析' }}</button></div>
      <p v-if="message" class="feedback" role="status">{{ message }}</p>
    </section>
    <section v-if="summaries.length" class="analysis-grid" aria-label="分析结论"><article v-for="summary in summaries" :key="summary.result.runId" class="form-card"><span class="eyebrow">分析结论</span><h2>{{ summary.result.analysisDate }}</h2><p>本次共 {{ conclusionCount(summary) }} 条结论</p><h3>{{ summary.conclusions[0]?.title }}</h3><p>{{ summaryText(summary) }}</p><button class="button-secondary" data-testid="view-analysis-detail" type="button" @click="viewDetail(summary)">查看详情</button></article></section>
    <p v-else class="feedback">暂无分析结论。请选择周期和结束日期后手动运行分析。</p>
    <div v-if="detailViewer" class="modal-backdrop" @click.self="detailViewer = null"><section class="form-card modal-panel skill-result-modal" role="dialog" aria-modal="true" aria-label="分析详情"><div class="admin-title"><div><span class="eyebrow">分析详情</span><h2>{{ detailViewer.result.analysisDate }} 分析结论</h2></div><button class="button-secondary" type="button" @click="detailViewer = null">关闭</button></div><article v-for="(conclusion, index) in detailViewer.conclusions" :key="index" class="skill-trial"><h3>{{ conclusion.title }}</h3><p>{{ conclusion.summary }}</p><div v-if="conclusion.evidence?.length"><strong>分析依据</strong><ul><li v-for="evidence in conclusion.evidence" :key="evidence">{{ evidence }}</li></ul></div><div><strong>处理建议</strong><p>{{ conclusion.recommendation }}</p></div></article></section></div>
  </section></AdminLayout>
</template>
