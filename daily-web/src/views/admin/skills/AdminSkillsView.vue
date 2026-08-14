<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type AnalysisPeriod, type AnalysisSkillKind, type AnalysisSkillTrial, type AnalysisSkillVersion } from '@/api/admin'
import { apiError } from '@/api/http'

const period = ref<AnalysisPeriod>('DAILY')
const endDate = ref(new Date().toISOString().slice(0, 10))
const versions = ref<Record<AnalysisSkillKind, AnalysisSkillVersion[]>>({ RULE: [], TEMPLATE: [] })
const trials = ref<AnalysisSkillTrial[]>([])
const selected = ref<Record<AnalysisSkillKind, number | null>>({ RULE: null, TEMPLATE: null })
const message = ref('')
const resultViewer = ref<{ title: string; content: string; html: boolean } | null>(null)

const names: Record<AnalysisPeriod, string> = { DAILY: '日报', WEEKLY: '周报', MONTHLY: '月报' }
const kinds: { kind: AnalysisSkillKind; label: string }[] = [
  { kind: 'RULE', label: '规则分析' }, { kind: 'TEMPLATE', label: '报告模板' },
]
const latestTrial = computed(() => trials.value.find(trial => trial.ruleSkillVersionId === selected.value.RULE
  && trial.templateSkillVersionId === selected.value.TEMPLATE && trial.status === 'SUCCEEDED'))
const canPublish = computed(() => Boolean(latestTrial.value && selected.value.RULE && selected.value.TEMPLATE))

function versionStatus(status: string) {
  return ({ DRAFT: '草稿', PUBLISHED: '已发布', HISTORICAL: '已归档' } as Record<string, string>)[status] ?? '未知状态'
}
function versionLabel(kind: AnalysisSkillKind, id: number | null) {
  const version = versions.value[kind].find(item => item.id === id)
  return `v${version?.versionNumber ?? '-'}（${versionStatus(version?.status ?? '')}）`
}
function formatDateTime(value?: string | null) {
  if (!value) return '—'
  return new Intl.DateTimeFormat('zh-CN', {
    dateStyle: 'medium', timeStyle: 'short', timeZone: 'Asia/Shanghai',
  }).format(new Date(value))
}

async function load() {
  const [rule, template, currentTrials] = await Promise.all([
    adminApi.analysisSkills(period.value, 'RULE'), adminApi.analysisSkills(period.value, 'TEMPLATE'),
    adminApi.analysisSkillTrials(period.value),
  ])
  versions.value = { RULE: rule.data, TEMPLATE: template.data }
  trials.value = currentTrials.data
  for (const kind of ['RULE', 'TEMPLATE'] as AnalysisSkillKind[]) {
    const preferred = versions.value[kind].find(item => item.status === 'DRAFT') ?? versions.value[kind][0]
    selected.value[kind] = preferred?.id ?? null
  }
}
async function changePeriod(value: AnalysisPeriod) { period.value = value; await load() }
async function upload(kind: AnalysisSkillKind, event: Event) {
  const file = (event.target as HTMLInputElement).files?.[0]
  if (!file) return
  try { await adminApi.uploadAnalysisSkill(period.value, kind, file); message.value = `${kinds.find(item => item.kind === kind)?.label}已上传`; await load() }
  catch (error) { message.value = apiError(error).message }
}
async function runTrial() {
  if (!selected.value.RULE || !selected.value.TEMPLATE) return
  try { await adminApi.trialAnalysisSkills(period.value, endDate.value, selected.value.RULE, selected.value.TEMPLATE); message.value = '试运行已完成'; await load() }
  catch (error) { message.value = apiError(error).message }
}
async function publish() {
  if (!selected.value.RULE || !selected.value.TEMPLATE) return
  try { await adminApi.publishAnalysisSkills(period.value, selected.value.RULE, selected.value.TEMPLATE); message.value = '规则与模板已成对发布'; await load() }
  catch (error) { message.value = apiError(error).message }
}
function download(id: number) { window.open(`/api/admin/analysis-skills/download/${id}`, '_blank') }
function viewResult(title: string, content: string, html = false) { resultViewer.value = { title, content, html } }

onMounted(load)
</script>

<template>
  <AdminLayout>
    <section class="admin-page">
      <div class="admin-title"><div><span class="eyebrow">智能分析</span><h1>智能分析技能</h1></div></div>
      <p class="feedback">上传受控 ZIP 包（根目录含 SKILL.md）。系统仅向分析技能提供日报、项目、工作日历与快照数据，不提供数据库或网络权限。</p>
      <div class="period-tabs" role="tablist"><button v-for="(_, key) in names" :key="key" type="button" :class="{ active: period === key }" @click="changePeriod(key)">{{ names[key] }}</button></div>

      <div class="analysis-grid">
        <article v-for="slot in kinds" :key="slot.kind" class="skill-slot">
          <h2>{{ names[period] }}{{ slot.label }}</h2>
          <label>上传 ZIP 文件<input type="file" accept=".zip,application/zip" @change="upload(slot.kind, $event)" /></label>
          <label>用于试运行 / 发布的版本<select v-model="selected[slot.kind]"><option :value="null">请选择</option><option v-for="version in versions[slot.kind]" :key="version.id" :value="version.id">v{{ version.versionNumber }}（{{ versionStatus(version.status) }}）</option></select></label>
          <ul v-if="versions[slot.kind].length"><li v-for="version in versions[slot.kind]" :key="version.id"><strong>版本 v{{ version.versionNumber }}</strong><br /><small>{{ version.validationMessage ? '校验通过' : '待校验' }} · {{ versionStatus(version.status) }}</small> <button type="button" @click="download(version.id)">下载</button></li></ul>
          <p v-else class="field-hint">尚未上传此类 ZIP 文件。</p>
        </article>
      </div>

      <section class="form-card">
        <h2>成对试运行与发布</h2>
        <p>先生成分析结论，再生成管理报告。两者针对同一历史周期试运行成功后，才可成对发布。</p>
        <label>历史周期结束日期<input v-model="endDate" type="date" /></label><button class="button-secondary" type="button" :disabled="!selected.RULE || !selected.TEMPLATE" @click="runTrial">试运行所选版本</button>
        <button class="button-primary" type="button" :disabled="!canPublish" @click="publish">成对发布</button>
        <p v-if="message" class="feedback" role="status">{{ message }}</p>
      </section>

      <section v-if="latestTrial" class="form-card skill-result-card" data-testid="latest-successful-trial">
        <span class="eyebrow">最近执行结果</span><div class="admin-title"><div><h2>最近成功试运行</h2><p>分析周期：{{ latestTrial.periodStart }} 至 {{ latestTrial.periodEnd }}</p></div><span class="status-badge success">成功</span></div>
        <p>执行时间：{{ formatDateTime(latestTrial.startedAt) }}</p>
        <p>使用版本：规则分析 {{ versionLabel('RULE', latestTrial.ruleSkillVersionId) }} · 报告模板 {{ versionLabel('TEMPLATE', latestTrial.templateSkillVersionId) }}</p>
        <p>规则结论和管理报告已生成，可分别查看。</p>
        <div class="button-row"><button data-testid="view-analysis-draft" class="button-secondary" type="button" @click="viewResult('分析结论', latestTrial.analysisDraft ?? '')">查看分析结论</button><button data-testid="view-rendered-report" class="button-primary" type="button" @click="viewResult('报告预览', latestTrial.renderedHtml ?? '', true)">查看报告预览</button></div>
      </section>

      <div v-if="resultViewer" class="modal-backdrop" @click.self="resultViewer = null"><section class="form-card modal-panel skill-result-modal" role="dialog" aria-modal="true" :aria-label="resultViewer.title"><div class="admin-title"><h2>{{ resultViewer.title }}</h2><button class="button-secondary" type="button" @click="resultViewer = null">关闭</button></div><div v-if="resultViewer.html" class="skill-report-preview" v-html="resultViewer.content" /><pre v-else class="skill-draft-preview">{{ resultViewer.content }}</pre></section></div>
    </section>
  </AdminLayout>
</template>
