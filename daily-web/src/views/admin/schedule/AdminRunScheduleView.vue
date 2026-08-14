<script setup lang="ts">
import { onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type AnalysisPeriodConfiguration, type ReportStatisticsConfiguration } from '@/api/admin'
import { apiError } from '@/api/http'

const statistics = ref<ReportStatisticsConfiguration | null>(null)
const periods = ref<AnalysisPeriodConfiguration[]>([])
const message = ref('')
const messageType = ref<'success' | 'error'>('success')
const names: Record<AnalysisPeriodConfiguration['period'], string> = { DAILY: '日报分析', WEEKLY: '周报分析', MONTHLY: '月报分析' }
function timeFromCron(cron: string) { const [, minutes = '0', hours = '0'] = cron.trim().split(/\s+/); return `${hours.padStart(2, '0')}:${minutes.padStart(2, '0')}` }
function cronWithTime(time: string, current: string) { const [, , , dayOfMonth = '?', month = '*', dayOfWeek = '*'] = current.trim().split(/\s+/); const [hours, minutes] = time.split(':'); return `0 ${Number(minutes)} ${Number(hours)} ${dayOfMonth} ${month} ${dayOfWeek}` }
function setEarlySnapshotTime(event: Event) { if (statistics.value) statistics.value.earlySnapshotCronExpression = cronWithTime((event.target as HTMLInputElement).value, statistics.value.earlySnapshotCronExpression) }
function setFinalSnapshotTime(event: Event) { if (statistics.value) statistics.value.finalSnapshotCronExpression = cronWithTime((event.target as HTMLInputElement).value, statistics.value.finalSnapshotCronExpression) }
function setPeriodTime(period: AnalysisPeriodConfiguration, event: Event) { period.cronExpression = cronWithTime((event.target as HTMLInputElement).value, period.cronExpression) }
async function load() { const values = await Promise.all([adminApi.reportStatisticsConfiguration(), adminApi.analysisPeriodConfigurations()]); statistics.value = values[0].data; periods.value = values[1].data }
function saved(text: string) { message.value = text; messageType.value = 'success' }
function failed(error: unknown) { message.value = apiError(error).message; messageType.value = 'error' }
async function saveStatistics() { if (!statistics.value) return; try { statistics.value = (await adminApi.updateReportStatisticsConfiguration(statistics.value)).data; saved('日报统计计划已保存') } catch (error) { failed(error) } }
async function savePeriod(period: AnalysisPeriodConfiguration) { try { const updated = (await adminApi.updateAnalysisPeriodConfiguration(period)).data; periods.value = periods.value.map(value => value.period === updated.period ? updated : value); saved(`${names[updated.period]}计划已保存`) } catch (error) { failed(error) } }
onMounted(load)
</script>

<template><AdminLayout><section class="admin-page">
  <div class="admin-title"><div><span class="eyebrow">SCHEDULE</span><h1>运行计划</h1></div></div>
  <p class="feedback">设置统计和分析的执行时间。系统仅在工作日自动执行；分析内容由已发布的 Skill 对决定。</p>
  <form v-if="statistics" class="schedule-card" @submit.prevent="saveStatistics">
    <div class="card-heading"><h2>日报统计</h2><span>工作日执行</span></div>
    <div class="schedule-row"><label class="check-field"><input v-model="statistics.earlySnapshotEnabled" type="checkbox" /> 启用 17:30 填报快照</label><label>执行时间<input type="time" :value="timeFromCron(statistics.earlySnapshotCronExpression)" @change="setEarlySnapshotTime" /></label></div>
    <div class="schedule-row"><label class="check-field"><input v-model="statistics.finalSnapshotEnabled" type="checkbox" /> 启用 22:00 最终统计</label><label>执行时间<input type="time" :value="timeFromCron(statistics.finalSnapshotCronExpression)" @change="setFinalSnapshotTime" /></label></div>
    <div class="save-bar"><button class="button-primary" type="submit">保存日报统计计划</button><p v-if="message" :class="['save-feedback', messageType]" role="status">{{ messageType === 'success' ? '✓' : '!' }} {{ message }}</p></div>
  </form>
  <article v-for="period in periods" :key="period.period" class="schedule-card">
    <div class="card-heading"><h2>{{ names[period.period] }}</h2><span>{{ period.period === 'DAILY' ? '每日' : period.period === 'WEEKLY' ? '每周' : '每月' }}</span></div>
    <div class="schedule-row"><label class="check-field"><input v-model="period.enabled" type="checkbox" /> 启用{{ names[period.period] }}</label><label>执行时间<input type="time" :value="timeFromCron(period.cronExpression)" @change="setPeriodTime(period, $event)" /></label></div>
    <div class="save-bar"><button class="button-secondary" type="button" @click="savePeriod(period)">保存{{ names[period.period] }}计划</button><p v-if="message" :class="['save-feedback', messageType]" role="status">{{ messageType === 'success' ? '✓' : '!' }} {{ message }}</p></div>
  </article>
</section></AdminLayout></template>
