<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue'
import SearchCandidateInput, { type SearchCandidate } from '@/components/common/SearchCandidateInput.vue'
import ReportForm from '@/components/report/ReportForm.vue'
import EmployeeLayout from '@/layouts/EmployeeLayout.vue'
import { useReportStore } from '@/stores/report'
import { notify } from '@/utils/toast'

const store = useReportStore()
const employeeId = ref<number | null>(null)
const employeeSearch = ref('')
const employeeCandidates = computed<SearchCandidate[]>(() => (store.options?.employees ?? []).map((employee) => ({
  key: String(employee.id), value: `${employee.name} · ${employee.teamName}`, title: employee.name, detail: employee.teamName,
})))

onMounted(async () => {
  store.reset()
  await store.loadOptions()
})

function selectEmployee(): void {
  const employees = store.options?.employees ?? []
  const sameName = employees.filter((employee) => employee.name === employeeSearch.value)
  const matched = employees.find((employee) => `${employee.name} · ${employee.teamName}` === employeeSearch.value)
    ?? (sameName.length === 1 ? sameName[0] : undefined)
  employeeId.value = matched?.id ?? null
}
watch(employeeSearch, selectEmployee)

async function load(): Promise<void> {
  selectEmployee()
  if (!employeeId.value) {
    const message = '请从候选人员中选择姓名'
    store.error = message
    notify(message, 'error')
    return
  }
  await store.loadCurrent(employeeId.value)
}
</script>

<template>
  <EmployeeLayout>
    <section class="page-shell report-page">
      <div class="page-intro compact">
        <span class="eyebrow">REOPEN · UPDATE TODAY</span>
        <h1>修改今日日报</h1>
        <p>选择姓名，读取今天已经保存的全部任务后再覆盖更新。</p>
      </div>
      <form class="lookup-card" @submit.prevent="load">
        <label>
          姓名
          <SearchCandidateInput v-model="employeeSearch" :candidates="employeeCandidates" required placeholder="输入姓名关键字后选择" empty-message="未找到匹配人员" />
        </label>
        <button class="button-primary" type="submit" :disabled="store.loading">读取今日日报</button>
      </form>
      <p v-if="store.error && !store.loaded" class="feedback error" role="alert">{{ store.error }}</p>
      <ReportForm v-if="store.loaded" submit-label="保存修改" lock-employee />
    </section>
  </EmployeeLayout>
</template>
