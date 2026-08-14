<script setup lang="ts">
import { computed, ref } from 'vue'
import DailyTaskForm from '@/components/report/DailyTaskForm.vue'
import { useReportStore } from '@/stores/report'

defineProps<{ submitLabel: string; lockEmployee?: boolean }>()
const store = useReportStore()
const employeeSearch = ref('')
const taskPeriods = computed(() => store.form.attendance === 'leave-morning' ? ['afternoon']
  : store.form.attendance === 'leave-afternoon' ? ['morning'] : ['morning', 'afternoon', 'full-day'])
const fullDayLeave = computed(() => store.form.attendance === 'leave')
function selectEmployee() {
  const employee = (store.options?.employees ?? []).find(item => `${item.name} · ${item.teamName}` === employeeSearch.value)
  store.form.employeeId = employee?.id ?? null
}
function attendanceChanged() { store.applyAttendanceRules() }
async function submit() { try { await store.save() } catch { /* 页面已展示错误 */ } }
</script>

<template><form class="report-form" @submit.prevent="submit">
  <section class="form-card report-meta"><div class="section-heading"><div><span class="step-label">基本信息</span><h2>今天由谁提交</h2></div><span class="date-badge">{{ store.form.date }}</span></div><div class="form-grid">
    <label>日期<input v-model="store.form.date" type="date" required /></label>
    <label>姓名<input v-model="employeeSearch" list="employee-options" required :disabled="lockEmployee" placeholder="输入姓名或选择候选项" @change="selectEmployee" /><datalist id="employee-options"><option v-for="employee in store.options?.employees ?? []" :key="employee.id" :value="`${employee.name} · ${employee.teamName}`" /></datalist></label>
    <label>出勤状态<select v-model="store.form.attendance" required @change="attendanceChanged"><option value="present">正常出勤</option><option value="business-trip">出差</option><option value="training">培训</option><option value="leave">全天请假</option><option value="leave-morning">上午请假</option><option value="leave-afternoon">下午请假</option></select></label>
  </div></section>
  <section v-if="!fullDayLeave" class="tasks-section"><div class="section-heading"><div><span class="step-label">工作明细</span><h2>记录每一项工作</h2></div><span class="task-count">{{ store.form.tasks.length }} 项任务</span></div><DailyTaskForm v-for="(task, index) in store.form.tasks" :key="task.id ?? `new-${index}`" :model-value="task" :index="index" :allowed-time-periods="taskPeriods" :project-choices="store.projectChoices" :dictionaries="store.options?.dictionaries ?? {}" :removable="store.form.tasks.length > 1" @update:model-value="store.form.tasks.splice(index, 1, $event)" @remove="store.removeTask(index)" /><button type="button" class="button-secondary add-task" @click="store.addTask">+ 新增工作任务</button></section>
  <section class="form-card"><label>其他补充（选填）<textarea v-model.trim="store.form.note" maxlength="2000" rows="3" /></label></section><p v-if="store.error" class="feedback error" role="alert">{{ store.error }}</p><p v-if="store.success" class="feedback success" role="status">{{ store.success }}</p><div class="submit-bar"><span>{{ fullDayLeave ? '全天请假无需填写工作明细' : store.form.attendance === 'leave-morning' ? '上午请假，请填写下午工作明细' : store.form.attendance === 'leave-afternoon' ? '下午请假，请填写上午工作明细' : '提交后仍可在今天继续修改' }}</span><button type="submit" class="button-primary" :disabled="store.saving">{{ store.saving ? '正在保存…' : submitLabel }}</button></div>
</form></template>
