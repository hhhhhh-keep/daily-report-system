<script setup lang="ts">
import { onMounted, ref } from 'vue'
import ReportForm from '@/components/report/ReportForm.vue'
import EmployeeLayout from '@/layouts/EmployeeLayout.vue'
import { useReportStore } from '@/stores/report'

const store = useReportStore()
const employeeId = ref<number | null>(null)

onMounted(async () => {
  store.reset()
  await store.loadOptions()
})

async function load(): Promise<void> {
  if (employeeId.value) await store.loadCurrent(employeeId.value)
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
          <select v-model="employeeId" required>
            <option :value="null" disabled>请选择姓名</option>
            <option v-for="employee in store.options?.employees ?? []" :key="employee.id" :value="employee.id">
              {{ employee.name }} · {{ employee.teamName }}
            </option>
          </select>
        </label>
        <button class="button-primary" type="submit" :disabled="store.loading">读取今日日报</button>
      </form>
      <p v-if="store.error && !store.loaded" class="feedback error" role="alert">{{ store.error }}</p>
      <ReportForm v-if="store.loaded" submit-label="保存修改" lock-employee />
    </section>
  </EmployeeLayout>
</template>
