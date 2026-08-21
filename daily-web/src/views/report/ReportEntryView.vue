<script setup lang="ts">
import { onMounted } from 'vue'
import ReportForm from '@/components/report/ReportForm.vue'
import EmployeeLayout from '@/layouts/EmployeeLayout.vue'
import { useReportStore } from '@/stores/report'

const store = useReportStore()
onMounted(async () => {
  store.reset()
  await store.loadOptions()
})
</script>

<template>
  <EmployeeLayout>
    <section class="page-shell report-page">
      <div class="page-intro">
        <span class="eyebrow">TODAY · CURRENT REPORT</span>
        <h1>把今天做成的事，清楚地留下来</h1>
        <p>每项工作单独记录，项目进展、风险和协同需求一目了然。</p>
      </div>
      <p v-if="store.optionsLoading" class="feedback">正在加载日报选项…</p>
      <ReportForm v-else-if="store.options" submit-label="提交今日日报" enable-draft />
      <p v-else class="feedback error" role="alert">{{ store.error }}</p>
    </section>
  </EmployeeLayout>
</template>
