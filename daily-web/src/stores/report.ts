import { isAxiosError } from 'axios'
import { computed, reactive, ref } from 'vue'
import { defineStore } from 'pinia'
import { apiError } from '@/api/http'
import {
  reportApi,
  type CurrentReportPayload,
  type ReportOptions,
  type ReportTaskInput,
} from '@/api/report'

function localToday(): string {
  const today = new Date()
  const year = today.getFullYear()
  const month = String(today.getMonth() + 1).padStart(2, '0')
  const day = String(today.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

function newTask(): ReportTaskInput {
  return {
    timePeriod: 'morning',
    projectId: null,
    workType: 'project-support',
    workStage: '',
    participationRole: 'owner',
    progressResult: '',
    currentStatus: 'in-progress',
    issueType: '',
    collaborationRole: '',
    collaborationRequirement: '',
  }
}

function emptyForm(): CurrentReportPayload {
  return {
    employeeId: null,
    date: localToday(),
    attendance: 'present',
    note: '',
    tasks: [newTask()],
  }
}

export const useReportStore = defineStore('report', () => {
  const options = ref<ReportOptions | null>(null)
  const form = reactive<CurrentReportPayload>(emptyForm())
  const optionsLoading = ref(false)
  const loading = ref(false)
  const saving = ref(false)
  const loaded = ref(false)
  const error = ref('')
  const success = ref('')

  const projectChoices = computed(() => [
    ...(options.value?.projects ?? []).map((project) => ({ id: project.id, label: project.name, type: 'project' as const })),
    ...(options.value?.nonFormalOptions ?? []).map((project) => ({ id: project.id, label: project.label, type: 'special' as const })),
  ])

  async function loadOptions(): Promise<void> {
    if (options.value) return
    optionsLoading.value = true
    error.value = ''
    try {
      options.value = await reportApi.options()
      const firstWorkType = options.value.dictionaries.work_type?.[0]?.code
      if (firstWorkType) form.tasks.forEach((task) => { task.workType = firstWorkType })
    } catch (cause) {
      error.value = apiError(cause).message
    } finally {
      optionsLoading.value = false
    }
  }

  function reset(): void {
    Object.assign(form, emptyForm())
    optionsLoading.value = false
    loading.value = false
    saving.value = false
    loaded.value = false
    error.value = ''
    success.value = ''
  }

  function addTask(): void {
    const task = newTask()
    const firstWorkType = options.value?.dictionaries.work_type?.[0]?.code
    if (firstWorkType) task.workType = firstWorkType
    form.tasks.push(task)
    applyAttendanceRules()
  }

  function removeTask(index: number): void {
    if (form.tasks.length > 1) form.tasks.splice(index, 1)
  }

  function clearStageForSpecialWork(task: ReportTaskInput): void {
    if (task.workType === 'special-work') task.workStage = ''
  }

  function applyAttendanceRules(): void {
    if (form.attendance === 'leave-morning') {
      form.tasks.forEach((task) => { task.timePeriod = 'afternoon' })
    }
    if (form.attendance === 'leave-afternoon') {
      form.tasks.forEach((task) => { task.timePeriod = 'morning' })
    }
  }

  async function save(): Promise<void> {
    saving.value = true
    error.value = ''
    success.value = ''
    try {
      applyAttendanceRules()
      const tasks = form.attendance === 'leave' ? [] : form.tasks.map((task) => {
        clearStageForSpecialWork(task)
        return { ...task }
      })
      const saved = await reportApi.saveCurrent({ ...form, tasks })
      applyReport(saved)
      success.value = '日报已保存，可在“修改今日日报”中继续更新。'
    } catch (cause) {
      error.value = apiError(cause).message
      throw cause
    } finally {
      saving.value = false
    }
  }

  async function loadCurrent(employeeId: number): Promise<void> {
    loading.value = true
    error.value = ''
    success.value = ''
    try {
      applyReport(await reportApi.current(employeeId, localToday()))
      loaded.value = true
    } catch (cause) {
      loaded.value = false
      error.value = apiError(cause).message
    } finally {
      loading.value = false
    }
  }

  async function selectEmployee(employeeId: number): Promise<boolean> {
    Object.assign(form, emptyForm(), { employeeId })
    loading.value = true
    error.value = ''
    success.value = ''
    try {
      applyReport(await reportApi.current(employeeId, form.date))
      success.value = '已加载该人员当日日报，可继续修改。'
      return true
    } catch (cause) {
      if (!isAxiosError(cause) || cause.response?.status !== 404) {
        error.value = apiError(cause).message
      }
      return false
    } finally {
      loading.value = false
    }
  }

  function applyReport(report: Awaited<ReturnType<typeof reportApi.current>>): void {
    form.employeeId = report.employeeId
    form.date = report.date
    form.attendance = report.attendance
    form.note = report.note ?? ''
    form.tasks.splice(0, form.tasks.length, ...report.tasks.map((task) => ({ ...task })))
  }

  return {
    options,
    form,
    optionsLoading,
    loading,
    saving,
    loaded,
    error,
    success,
    projectChoices,
    loadOptions,
    reset,
    addTask,
    removeTask,
    clearStageForSpecialWork,
    applyAttendanceRules,
    save,
    loadCurrent,
    selectEmployee,
  }
})
