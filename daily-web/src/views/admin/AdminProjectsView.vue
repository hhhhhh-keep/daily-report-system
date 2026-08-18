<script setup lang="ts">
import { computed, onMounted, reactive, ref, watch } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type Page, type ProjectActivity, type ProjectRecord } from '@/api/admin'
import { apiError } from '@/api/http'
import Pagination from '@/components/Pagination.vue'

const rows = ref<ProjectRecord[]>([])
const totalItems = ref(0)
const totalPages = ref(0)
const page = ref(0)
const pageSize = ref(20)
const loading = ref(false)
const search = ref('')
const editingId = ref<number | null>(null)
const formOpen = ref(false)
const message = ref('')
const selectedProject = ref<ProjectRecord | null>(null)
const activity = ref<ProjectActivity | null>(null)
const activityDays = ref(30)
const activityPage = ref(0)
const activityPageSize = ref(20)
const activityLoading = ref(false)
const activityMessage = ref('')
const empty = () => ({ name: '', customerName: '', industry: '', projectStage: '', ownerName: '',
  priority: '', status: 'active', code: '', formal: true, systemKey: '', active: true })
const form = reactive(empty())
async function load() {
  loading.value = true
  try {
    const data = (await adminApi.projects({ page: page.value, size: pageSize.value })).data as Page<ProjectRecord>
    rows.value = data.items
    totalItems.value = data.totalItems
    totalPages.value = data.totalPages
  } finally {
    loading.value = false
  }
}
const filteredRows = computed(() => {
  const keyword = search.value.trim().toLowerCase()
  if (!keyword) return rows.value
  return rows.value.filter(row => [row.name, row.code, row.customerName, row.ownerName, row.status]
    .some(value => value?.toLowerCase().includes(keyword)))
})
function edit(row: ProjectRecord) {
  editingId.value = row.id
  formOpen.value = true
  Object.assign(form, row, { customerName: row.customerName || '', industry: row.industry || '',
    projectStage: row.projectStage || '', ownerName: row.ownerName || '', priority: row.priority || '',
    code: row.code || '', systemKey: row.systemKey || '' })
}
function reset() { editingId.value = null; formOpen.value = false; Object.assign(form, empty()) }
function create() { Object.assign(form, empty()); editingId.value = null; formOpen.value = true }
watch(() => form.formal, (formal) => { if (formal) form.systemKey = '' })
async function save() {
  try {
    const payload = { ...form, customerName: form.customerName || null, industry: form.industry || null,
      projectStage: form.projectStage || null, ownerName: form.ownerName || null,
      priority: form.priority || null, code: form.code || null, systemKey: form.systemKey || null }
    if (editingId.value) await adminApi.updateProject({ id: editingId.value, ...payload })
    else await adminApi.createProject(payload)
    message.value = '项目资料已保存'; reset(); await load()
  } catch (caught) { message.value = apiError(caught).message }
}
async function deactivate(row: ProjectRecord) {
  const confirmed = window.confirm(`确定停用“${row.name}”吗？\n\n停用后：不能再填写该项目；后续新生成的分析报告不会包含该项目。\n既有日报记录和已生成报告将保留。`)
  if (!confirmed) return
  try {
    await adminApi.deleteProject(row.id)
    message.value = `已停用“${row.name}”：后续填报和新分析报告不再包含该项目；历史记录保留。`
    await load()
  } catch (caught) { message.value = apiError(caught).message }
}
const stageLabels: Record<string, string> = {
  'requirements-analysis': '需求调研与分析', 'solution-design': '方案编写/设计',
  'bid-quotation': '投标/报价支持', 'technical-presentation': '技术交流/演示汇报',
  implementation: '开发/配置/实施', 'testing-deployment': '测试/上线部署',
  'training-acceptance': '培训/验收交付', 'operations-support': '运维保障',
  'incident-handling': '故障/问题处理', 'optimization-upgrade': '优化升级',
  'customer-support': '客户持续支撑',
}
const statusLabels: Record<string, string> = {
  active: '正常', started: '已启动', 'in-progress': '进行中', completed: '已完成', blocked: '遇到阻碍', paused: '暂停/搁置',
}
const priorityOptions = [['low', '低'], ['medium', '中'], ['high', '高'], ['urgent', '紧急']]
const projectStatusOptions = [['active', '正常'], ['started', '已启动'], ['in-progress', '进行中'], ['completed', '已完成'], ['blocked', '遇到阻碍'], ['paused', '暂停/搁置']]
const derivedStateLabels: Record<string, string> = {
  NOT_STARTED: '未启动', PRESALES_IN_PROGRESS: '售前推进', DELIVERY_IN_PROGRESS: '交付推进',
  AFTERSALES_IN_PROGRESS: '售中/交付推进', IN_PROGRESS: '进行中', BLOCKED: '存在阻碍',
  PAUSED: '暂停', COMPLETED: '已完成',
}
const activityTimeline = computed(() => activity.value?.tasks.slice().sort((left, right) =>
  right.reportDate.localeCompare(left.reportDate) || right.taskId - left.taskId) || [])
const latestStateEvent = computed(() => activity.value?.stateEvents[0] || null)
const activityTotalItems = computed(() => activity.value?.totalItems ?? activity.value?.tasks.length ?? 0)
const activityTotalPages = computed(() => {
  const total = activityTotalItems.value
  const size = activityPageSize.value
  return total === 0 ? 0 : Math.ceil(total / size)
})
function stageLabel(stage: string | null) { return stage ? (stageLabels[stage] || stage) : '专项工作' }
function statusLabel(status: string) { return statusLabels[status] || status }
function derivedStateLabel(state: string) { return derivedStateLabels[state] || state }
async function showActivity(row: ProjectRecord) {
  selectedProject.value = row
  activityMessage.value = ''
  activityPage.value = 0
  await loadActivity()
}
async function loadActivity() {
  if (!selectedProject.value) return
  activityLoading.value = true
  try {
    activity.value = (await adminApi.projectActivity(selectedProject.value.id, {
      days: activityDays.value,
      page: activityPage.value,
      size: activityPageSize.value,
    })).data
  } catch (caught) { activity.value = null; activityMessage.value = apiError(caught).message }
  finally { activityLoading.value = false }
}
async function changeActivityDays(days: number) {
  activityDays.value = days
  activityPage.value = 0
  if (selectedProject.value) await loadActivity()
}
onMounted(load)
</script>

<template>
  <AdminLayout><section class="admin-page">
    <div class="admin-title"><div><span class="eyebrow">MASTER DATA</span><h1>项目与专项维护</h1></div></div>
    <button class="button-primary" type="button" @click="create">新增项目 / 专项</button>
    <div v-if="formOpen" class="modal-backdrop" @click.self="reset"><form class="admin-form wide modal-panel" @submit.prevent="save">
      <label>名称<input v-model.trim="form.name" required /></label><label>项目编号<input v-model.trim="form.code" /></label>
      <label>客户<input v-model.trim="form.customerName" /></label><label>行业<input v-model.trim="form.industry" /></label>
      <label>项目阶段<input v-model.trim="form.projectStage" /></label><label>负责人<input v-model.trim="form.ownerName" /></label>
      <label>优先级<select v-model="form.priority"><option value="">未设置</option><option v-for="[value, text] in priorityOptions" :key="value" :value="value">{{ text }}</option></select></label>
      <label>状态<select v-model="form.status" required><option v-for="[value, text] in projectStatusOptions" :key="value" :value="value">{{ text }}</option></select></label>
      <label class="check-field"><input v-model="form.formal" type="checkbox" /> 正式项目</label>
      <label v-if="!form.formal">系统标识<input v-model.trim="form.systemKey" required /></label>
      <label class="check-field"><input v-model="form.active" type="checkbox" /> 启用</label>
      <div class="form-actions"><button class="button-primary" type="submit">{{ editingId ? '保存修改' : '保存项目' }}</button>
        <button type="button" @click="reset">取消</button></div>
    </form></div>
    <p v-if="message" class="feedback" role="status">{{ message }}</p>
    <label class="project-search">搜索项目<input data-testid="project-search" v-model.trim="search" placeholder="名称、编号、客户、负责人或状态" /></label>
    <div class="admin-table-wrap"><table><thead><tr><th>名称</th><th>类型</th><th>编号 / 标识</th><th>状态</th><th>操作</th></tr></thead>
      <tbody><tr v-for="row in filteredRows" :key="row.id"><td>{{ row.name }}</td><td>{{ row.formal ? '正式项目' : '非正式专项' }}</td>
        <td>{{ row.code || row.systemKey }}</td><td>{{ row.active ? '启用' : '停用' }}</td><td class="table-actions"><button type="button" @click="edit(row)">编辑</button>
          <button class="activity-button" type="button" @click="showActivity(row)">日报动态</button>
          <button v-if="row.active" type="button" @click="deactivate(row)">停用</button></td></tr></tbody></table></div>
    <Pagination v-model:page="page" v-model:page-size="pageSize"
      :total-items="totalItems" :total-pages="totalPages"
      :loading="loading" @change="load" />
    <div v-if="selectedProject" class="modal-backdrop" @click.self="selectedProject = null; activity = null"><section class="form-card project-activity modal-panel" role="dialog" aria-modal="true"><div class="admin-title"><div><span class="eyebrow">REPORT ACTIVITY</span><h2>{{ selectedProject.name }} · 日报动态</h2></div>
      <button type="button" @click="selectedProject = null; activity = null">收起</button></div>
      <div class="form-actions"><button v-for="days in [7, 30, 90, 0]" :key="days" type="button" :class="{ active: activityDays === days }" @click="changeActivityDays(days)">{{ days === 0 ? '全周期' : `${days} 天` }}</button></div>
      <p v-if="activityMessage" class="feedback">{{ activityMessage }}</p>
      <template v-else-if="activity"><div class="project-activity-summary"><span>参与人员：{{ activity.participantCount }}</span><span>最近日报：{{ activity.latestReportDate || '暂无' }}</span><span>阻碍/暂停：{{ activity.blockedOrPausedCount }}</span></div>
        <div v-if="activity.derivedState" class="project-derived-state"><strong>系统派生状态：{{ derivedStateLabel(activity.derivedState.state) }}</strong><span>当前环节：{{ stageLabel(activity.derivedState.currentStage) }}</span><span>状态起始：{{ activity.derivedState.stateStartedDate }}</span><span>依据任务：#{{ activity.derivedState.triggerTaskId }}</span></div>
        <p v-if="latestStateEvent" class="feedback">最近状态变更：{{ latestStateEvent.occurredDate }} · {{ derivedStateLabel(latestStateEvent.state) }}（任务 #{{ latestStateEvent.triggerTaskId }}）</p>
        <p v-if="!activity.tasks.length" class="feedback">所选周期暂无日报任务。</p>
        <div class="project-activity-track"><h3>历史动态</h3><button v-for="task in activityTimeline" :key="task.taskId" class="project-activity-task" :class="task.currentStatus" type="button" :title="task.progressResult">
          <strong>{{ task.reportDate }} · {{ task.employeeName }} · {{ stageLabel(task.workStage) }}</strong><span>{{ statusLabel(task.currentStatus) }}</span><small>{{ task.progressResult }}</small>
        </button></div>
        <Pagination v-model:page="activityPage" v-model:page-size="activityPageSize"
          :total-items="activityTotalItems" :total-pages="activityTotalPages"
          :loading="activityLoading" @change="loadActivity" />
      </template>
    </section></div>
  </section></AdminLayout>
</template>
