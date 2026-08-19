<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import DailyTaskForm from '@/components/report/DailyTaskForm.vue'
import { useReportStore } from '@/stores/report'
import { notify } from '@/utils/toast'

const props = withDefaults(defineProps<{ submitLabel: string; lockEmployee?: boolean; enableDraft?: boolean }>(), { enableDraft: false })
const store = useReportStore()
const employeeSearch = ref('')
const matchingEmployees = computed(() => {
  const keyword = employeeSearch.value.trim().toLocaleLowerCase()
  return keyword ? (store.options?.employees ?? []).filter((item) =>
    `${item.name} ${item.teamName}`.toLocaleLowerCase().includes(keyword)).slice(0, 20) : []
})
const taskPeriods = computed(() => store.form.attendance === 'leave-morning' ? ['afternoon']
  : store.form.attendance === 'leave-afternoon' ? ['morning'] : ['morning', 'afternoon', 'full-day'])
const fullDayLeave = computed(() => store.form.attendance === 'leave')
const weekdays = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
const dateHint = computed(() => {
  const date = new Date(`${store.form.date}T00:00:00`)
  const [, month, day] = store.form.date.split('-')
  return Number.isNaN(date.getTime()) ? store.form.date : `${Number(month)}月${Number(day)}日 · ${weekdays[date.getDay()]}`
})
const greeting = computed(() => new Date().getHours() < 12 ? '上午好，开始记录今天的工作吧' : '下午好，别忘了补充今日进展')
const filledTaskCount = computed(() => fullDayLeave.value ? 0 : store.form.tasks.filter((task) => task.progressResult.trim()).length)
const hasDraftContent = computed(() => Boolean(store.form.employeeId || store.form.note?.trim()
  || store.form.tasks.some((task) => task.projectId || task.projectName?.trim() || task.progressResult.trim())))
const draftStatus = ref('填写内容会自动保存在本机')
const draftKey = computed(() => `daily-report-draft:${store.form.date}`)
const saveStatus = computed(() => store.saving ? '正在提交日报' : store.success ? '日报已提交' : props.enableDraft ? draftStatus.value : '尚未保存')
let draftTimer: ReturnType<typeof setTimeout> | undefined
function selectEmployee() {
  const employee = (store.options?.employees ?? []).find(item => `${item.name} · ${item.teamName}` === employeeSearch.value)
  store.form.employeeId = employee?.id ?? null
}
function syncEmployeeSearch() {
  const employee = (store.options?.employees ?? []).find((item) => item.id === store.form.employeeId)
  employeeSearch.value = employee ? `${employee.name} · ${employee.teamName}` : ''
}
function attendanceChanged() { store.applyAttendanceRules() }
function saveDraft(manual = true) {
  if (!props.enableDraft || !hasDraftContent.value) { draftStatus.value = '填写后将自动保存'; return }
  if (draftTimer) clearTimeout(draftTimer)
  try {
    localStorage.setItem(draftKey.value, JSON.stringify({ form: store.form, savedAt: new Date().toISOString() }))
    draftStatus.value = manual ? '草稿已保存至本机' : '草稿已自动保存'
    if (manual) notify('草稿已保存至本机浏览器')
  } catch { draftStatus.value = '草稿保存失败，请及时提交' }
}
function restoreDraft() {
  if (!props.enableDraft) return
  try {
    const saved = JSON.parse(localStorage.getItem(draftKey.value) ?? 'null')
    if (saved?.form && Array.isArray(saved.form.tasks)) {
      Object.assign(store.form, saved.form)
      draftStatus.value = '已恢复本机草稿'
    }
  } catch { localStorage.removeItem(draftKey.value) }
}
function clearDraft() {
  if (draftTimer) clearTimeout(draftTimer)
  localStorage.removeItem(draftKey.value)
}
watch(store.form, () => {
  if (!props.enableDraft || !hasDraftContent.value) return
  if (draftTimer) clearTimeout(draftTimer)
  draftStatus.value = '正在自动保存草稿…'
  draftTimer = setTimeout(() => saveDraft(false), 700)
}, { deep: true })
onMounted(() => { restoreDraft(); syncEmployeeSearch() })
onBeforeUnmount(() => { if (draftTimer) saveDraft(false) })
async function submit() { try { await store.save(); clearDraft() } catch { /* 页面已展示错误 */ } }
</script>

<template><form class="report-form" @submit.prevent="submit">
  <section class="form-card report-meta"><div class="section-heading"><div><span class="step-label">基本信息</span><h2>你好，今天是{{ dateHint }}</h2></div></div><div class="report-context" aria-live="polite"><span>{{ greeting }}</span><span>{{ store.form.employeeId ? '已选择提交人' : '待选择提交人' }}</span><span>已填写工作内容 {{ filledTaskCount }}/{{ fullDayLeave ? 0 : store.form.tasks.length }} 项</span><span>22:00 统计当日最终填报结果</span><span :class="{ saved: store.success, saving: store.saving }">{{ saveStatus }}</span></div><div class="form-grid">
    <label>日期<input v-model="store.form.date" type="date" required /></label>
    <label>姓名<input v-model="employeeSearch" :list="employeeSearch.trim() ? 'employee-options' : undefined" required :disabled="lockEmployee" autocomplete="off" placeholder="输入姓名关键字后选择" @input="selectEmployee" @change="selectEmployee" /><datalist id="employee-options"><option v-for="employee in matchingEmployees" :key="employee.id" :value="`${employee.name} · ${employee.teamName}`" /></datalist></label>
    <label>出勤状态<select v-model="store.form.attendance" required @change="attendanceChanged"><option value="present">正常出勤</option><option value="business-trip">出差</option><option value="training">培训</option><option value="leave">全天请假</option><option value="leave-morning">上午请假</option><option value="leave-afternoon">下午请假</option></select></label>
  </div></section>
  <section v-if="!fullDayLeave" class="tasks-section"><div class="section-heading"><div><span class="step-label">工作明细</span><h2>记录每一项工作</h2></div><span class="task-count">{{ store.form.tasks.length }} 项任务</span></div><DailyTaskForm v-for="(task, index) in store.form.tasks" :key="task.id ?? `new-${index}`" :model-value="task" :index="index" :allowed-time-periods="taskPeriods" :project-choices="store.projectChoices" :dictionaries="store.options?.dictionaries ?? {}" :removable="store.form.tasks.length > 1" @update:model-value="store.form.tasks.splice(index, 1, $event)" @remove="store.removeTask(index)" /><button type="button" class="button-secondary add-task" @click="store.addTask">+ 新增工作任务</button></section>
  <section class="form-card"><label>其他补充（选填）<textarea v-model.trim="store.form.note" maxlength="2000" rows="3" /></label></section><p v-if="store.error" class="feedback error" role="alert">{{ store.error }}</p><p v-if="store.success" class="feedback success" role="status">{{ store.success }}</p><div class="submit-bar"><div class="submit-copy"><span>{{ fullDayLeave ? '全天请假无需填写工作明细' : store.form.attendance === 'leave-morning' ? '上午请假，请填写下午工作明细' : store.form.attendance === 'leave-afternoon' ? '下午请假，请填写上午工作明细' : props.enableDraft ? '草稿仅保存在本机浏览器，不会提交到系统' : '提交后仍可在今天继续修改' }}</span><strong v-if="props.enableDraft" :class="{ saved: draftStatus.includes('已'), saving: store.saving || draftStatus.includes('正在') }">{{ saveStatus }}</strong></div><div class="submit-actions"><button v-if="props.enableDraft" type="button" class="button-secondary" :disabled="store.saving || !hasDraftContent" @click="saveDraft()">保存草稿</button><button type="submit" class="button-primary" :disabled="store.saving">{{ store.saving ? '正在保存…' : submitLabel }}</button></div></div>
</form></template>
