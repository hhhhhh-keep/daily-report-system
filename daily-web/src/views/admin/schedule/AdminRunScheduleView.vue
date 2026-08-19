<script setup lang="ts">
import { onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type AnalysisPeriodConfiguration, type ReportStatisticsConfiguration, type ReportStatisticsSnapshot } from '@/api/admin'
import { apiError } from '@/api/http'

const statistics = ref<ReportStatisticsConfiguration | null>(null)
const periods = ref<AnalysisPeriodConfiguration[]>([])
const message = ref('')
const messageType = ref<'success' | 'error'>('success')
const messageScope = ref<'statistics' | AnalysisPeriodConfiguration['period'] | null>(null)
const snapshots = ref<ReportStatisticsSnapshot[]>([])
const snapshotTypes = ['PROGRESS_1730', 'FINAL'] as const
const names: Record<AnalysisPeriodConfiguration['period'], string> = { DAILY: '日报分析', WEEKLY: '周报分析', MONTHLY: '月报分析' }
const recipientTexts = ref<Record<string, string>>({})
const ccRecipientTexts = ref<Record<string, string>>({})
function timeFromCron(cron: string) { const [, minutes = '0', hours = '0'] = cron.trim().split(/\s+/); return `${hours.padStart(2, '0')}:${minutes.padStart(2, '0')}` }
function latestSnapshot(type: ReportStatisticsSnapshot['snapshotType']) { return snapshots.value.find(snapshot => snapshot.snapshotType === type) }
function snapshotTime(value: string) { return new Intl.DateTimeFormat('zh-CN', { timeZone: 'Asia/Shanghai', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false }).format(new Date(value)) }
function cronWithTime(time: string, current: string) { const [, , , dayOfMonth = '?', month = '*', dayOfWeek = '*'] = current.trim().split(/\s+/); const [hours, minutes] = time.split(':'); return `0 ${Number(minutes)} ${Number(hours)} ${dayOfMonth} ${month} ${dayOfWeek}` }
function setEarlySnapshotTime(event: Event) { if (statistics.value) statistics.value.earlySnapshotCronExpression = cronWithTime((event.target as HTMLInputElement).value, statistics.value.earlySnapshotCronExpression) }
function setFinalSnapshotTime(event: Event) { if (statistics.value) statistics.value.finalSnapshotCronExpression = cronWithTime((event.target as HTMLInputElement).value, statistics.value.finalSnapshotCronExpression) }
function setPeriodTime(period: AnalysisPeriodConfiguration, event: Event) { period.cronExpression = cronWithTime((event.target as HTMLInputElement).value, period.cronExpression) }
async function load() { const values = await Promise.all([adminApi.reportStatisticsConfiguration(), adminApi.analysisPeriodConfigurations(), adminApi.reportStatisticsSnapshotLatest()]); statistics.value = values[0].data; periods.value = values[1].data.map(period => ({ ...period, emailEnabled: period.emailEnabled ?? false, emailRecipients: period.emailRecipients ?? [], emailCcRecipients: period.emailCcRecipients ?? [], emailSubjectTemplate: period.emailSubjectTemplate ?? '{{period}}分析报告｜{{date}}', reportTitleTemplate: period.reportTitleTemplate ?? '{{period}}工作分析报告（截至{{date}}）' })); snapshots.value = values[2].data; periods.value.forEach(period => { recipientTexts.value[period.period] = period.emailRecipients.join(', '); ccRecipientTexts.value[period.period] = period.emailCcRecipients.join(', ') }) }
function saved(text: string, scope: NonNullable<typeof messageScope.value>) { message.value = text; messageType.value = 'success'; messageScope.value = scope }
function failed(error: unknown, scope: NonNullable<typeof messageScope.value>) { message.value = apiError(error).message; messageType.value = 'error'; messageScope.value = scope }
async function saveStatistics() { if (!statistics.value) return; try { statistics.value = (await adminApi.updateReportStatisticsConfiguration(statistics.value)).data; saved('日报统计计划已保存', 'statistics') } catch (error) { failed(error, 'statistics') } }
async function savePeriod(period: AnalysisPeriodConfiguration) { period.emailRecipients = (recipientTexts.value[period.period] || '').split(',').map(value => value.trim()).filter(Boolean); period.emailCcRecipients = (ccRecipientTexts.value[period.period] || '').split(',').map(value => value.trim()).filter(Boolean); try { const updated = (await adminApi.updateAnalysisPeriodConfiguration(period)).data; periods.value = periods.value.map(value => value.period === updated.period ? updated : value); saved(`${names[updated.period]}计划已保存`, updated.period) } catch (error) { failed(error, period.period) } }
onMounted(load)
</script>

<template><AdminLayout><section class="admin-page">
  <div class="admin-title"><div><span class="eyebrow">SCHEDULE</span><h1>运行计划</h1></div></div>
  <p class="feedback">设置统计和分析的执行时间。系统仅在工作日自动执行；分析内容由已发布的 Skill 对决定。任务触发后的分析、报告和邮件结果请在“任务记录”查看。</p>
  <form v-if="statistics" class="schedule-card" @submit.prevent="saveStatistics">
    <div class="card-heading"><h2>日报统计</h2><span>工作日执行</span></div>
    <section class="snapshot-status" aria-label="最近保存快照"><h3>最近保存快照</h3><p v-for="type in snapshotTypes" :key="type"><strong>最近 {{ type === 'PROGRESS_1730' ? '17:30 快照' : '22:00 快照' }}：</strong><template v-if="latestSnapshot(type)">{{ snapshotTime(latestSnapshot(type)!.capturedAt) }} · 应填{{ latestSnapshot(type)!.expectedCount }} · 已填{{ latestSnapshot(type)!.submittedCount }} · 未填{{ latestSnapshot(type)!.missingCount }}</template><template v-else>尚未保存快照</template></p></section>
    <div class="schedule-row"><label class="check-field"><input v-model="statistics.earlySnapshotEnabled" type="checkbox" /> 启用 17:30 填报快照</label><label>执行时间<input type="time" :value="timeFromCron(statistics.earlySnapshotCronExpression)" @change="setEarlySnapshotTime" /></label></div>
    <div class="schedule-row"><label class="check-field"><input v-model="statistics.finalSnapshotEnabled" type="checkbox" /> 启用 22:00 最终统计</label><label>执行时间<input type="time" :value="timeFromCron(statistics.finalSnapshotCronExpression)" @change="setFinalSnapshotTime" /></label></div>
    <div class="save-bar"><button class="button-primary" type="submit">保存日报统计计划</button><p v-if="messageScope === 'statistics'" :class="['save-feedback', messageType]" role="status">{{ messageType === 'success' ? '✓' : '!' }} {{ message }}</p></div>
  </form>
  <article v-for="period in periods" :key="period.period" class="schedule-card">
    <div class="card-heading"><h2>{{ names[period.period] }}</h2><span>{{ period.period === 'DAILY' ? '工作日' : period.period === 'WEEKLY' ? '每周最后一个工作日' : '每月最后一个工作日' }}</span></div>
    <div class="schedule-row"><label class="check-field"><input v-model="period.enabled" type="checkbox" /> 启用{{ names[period.period] }}</label><label>执行时间<input type="time" :value="timeFromCron(period.cronExpression)" @change="setPeriodTime(period, $event)" /></label></div>
    <section class="period-email-settings"><h3>邮件发送设置</h3><label class="check-field"><input v-model="period.emailEnabled" type="checkbox" /> 发送本周期报告邮件</label><label>收件人（逗号分隔）<input v-model="recipientTexts[period.period]" type="email" multiple /></label><label>抄送人（逗号分隔）<input v-model="ccRecipientTexts[period.period]" type="email" multiple /></label><label>邮件标题<input v-model.trim="period.emailSubjectTemplate" :placeholder="'{{period}}分析报告｜{{date}}'" /></label><label>报告标题<input v-model.trim="period.reportTitleTemplate" :placeholder="'{{period}}工作分析报告（截至{{date}}）'" /></label><p v-pre class="hint">{{period}} 会替换为日报、周报或月报；{{date}} 会替换为报告截止日期。</p></section>
    <div class="save-bar"><button class="button-secondary" type="button" @click="savePeriod(period)">保存{{ names[period.period] }}计划</button><p v-if="messageScope === period.period" :class="['save-feedback', messageType]" role="status">{{ messageType === 'success' ? '✓' : '!' }} {{ message }}</p></div>
  </article>
</section></AdminLayout></template>
