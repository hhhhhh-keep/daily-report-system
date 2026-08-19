<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type WorkdayCalendarImportItem, type WorkdayCalendarRecord } from '@/api/admin'
import { apiError } from '@/api/http'

const year = ref(new Date().getFullYear())
const rows = ref<WorkdayCalendarRecord[]>([])
const message = ref('')
const noticeUrl = ref('')
const previewEntries = ref<WorkdayCalendarImportItem[]>([])
const form = reactive({ date: new Date().toISOString().slice(0, 10), workday: true, note: '' })
const months = Array.from({ length: 12 }, (_, index) => index + 1)
const weekdayLabels = ['一', '二', '三', '四', '五', '六', '日']
const entriesByDate = computed(() => new Map(rows.value.filter(row => row.active)
  .map(row => [row.date, row] as const)))

function dateKey(month: number, day: number) { return `${year.value}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')}` }
function daysInMonth(month: number) { return new Date(year.value, month, 0).getDate() }
function monthCells(month: number) {
  const firstDay = (new Date(year.value, month - 1, 1).getDay() + 6) % 7
  return Array.from({ length: firstDay + daysInMonth(month) }, (_, index) => index < firstDay ? null : index - firstDay + 1)
}
function entry(month: number, day: number) { return entriesByDate.value.get(dateKey(month, day)) }
function dayClass(month: number, day: number) {
  const value = entry(month, day)
  if (value?.source === 'ADMIN_OVERRIDE') return value.workday ? 'calendar-override-workday' : 'calendar-override-rest'
  if (value?.source === 'MAKE_UP_WORKDAY') return 'calendar-makeup'
  if (value?.source === 'LEGAL_HOLIDAY') return 'calendar-holiday'
  const weekday = new Date(year.value, month - 1, day).getDay()
  return weekday === 0 || weekday === 6 ? 'calendar-weekend' : ''
}
function dayHint(month: number, day: number) {
  const value = entry(month, day)
  if (value) return value.note || (value.workday ? '工作日' : '非工作日')
  return new Date(year.value, month - 1, day).getDay() % 6 === 0 ? '周末' : '工作日'
}
function selectDay(month: number, day: number) {
  const value = entry(month, day)
  form.date = dateKey(month, day); form.workday = value?.workday ?? !dayClass(month, day).includes('weekend')
  form.note = value?.source === 'ADMIN_OVERRIDE' ? value.note || '' : ''
}
async function load() { try { rows.value = (await adminApi.workdayCalendar(year.value, { page: 0, size: 366 })).data.items } catch (caught) { message.value = apiError(caught).message } }
async function saveOverride() { try { await adminApi.saveWorkdayOverride({ ...form, note: form.note || null }); message.value = '工作日人工配置已保存'; await load() } catch (caught) { message.value = apiError(caught).message } }
async function removeOverride() { try { await adminApi.deleteWorkdayOverride(form.date); message.value = '已停用人工配置，日期将按官方日历或默认规则判断'; await load() } catch (caught) { message.value = apiError(caught).message } }
async function previewOfficialNotice() { try { const response = await adminApi.previewOfficialWorkdayCalendar(year.value, noticeUrl.value); previewEntries.value = response.data.entries; message.value = `已识别 ${previewEntries.value.length} 个节假日或补班日期，请确认后导入` } catch (caught) { previewEntries.value = []; message.value = apiError(caught).message } }
async function importPreview() { try { await adminApi.importWorkdayCalendar(year.value, previewEntries.value); message.value = `${year.value} 年官方日历已导入；人工配置保持不变`; previewEntries.value = []; await load() } catch (caught) { message.value = apiError(caught).message } }
onMounted(load)
</script>

<template><AdminLayout><section class="admin-page"><div class="admin-title"><div><span class="eyebrow">WORKDAY CALENDAR</span><h1>工作日历</h1></div></div>
  <form class="admin-form wide" @submit.prevent="saveOverride"><label>日期<input v-model="form.date" type="date" required /></label><label>日期类型<select v-model="form.workday"><option :value="true">工作日</option><option :value="false">非工作日</option></select></label><label>说明（选填）<input v-model.trim="form.note" maxlength="500" /></label><div class="form-actions"><button class="button-primary" type="submit">保存人工配置</button><button v-if="entriesByDate.get(form.date)?.source === 'ADMIN_OVERRIDE'" type="button" @click="removeOverride">停用人工配置</button></div></form>
  <section class="form-card"><label>年度<input v-model.number="year" type="number" min="2000" max="9999" @change="load" /></label><p class="feedback">可粘贴国务院官方公告链接，自动生成所选年度的节假日和补班；确认导入前不会修改日历。</p><form class="official-calendar-import" @submit.prevent="previewOfficialNotice"><label>国务院公告链接<input v-model.trim="noticeUrl" type="url" placeholder="https://www.gov.cn/..." required /></label><button class="button-secondary" type="submit">解析并预览</button></form><div v-if="previewEntries.length" class="calendar-import-preview"><p>已识别 {{ previewEntries.filter(entry => !entry.workday).length }} 个节假日、{{ previewEntries.filter(entry => entry.workday).length }} 个补班日期。</p><p>{{ previewEntries.map(entry => `${entry.date} ${entry.workday ? '补班' : entry.note}`).join('；') }}</p><button class="button-primary" type="button" @click="importPreview">确认导入 {{ year }} 年日历</button></div><div class="calendar-legend"><span class="calendar-holiday">节假日</span><span class="calendar-makeup">补班</span><span class="calendar-override-rest">人工休息</span><span class="calendar-override-workday">人工工作</span></div></section>
  <p v-if="message" class="feedback" role="status">{{ message }}</p>
  <section class="workday-calendar-grid"><article v-for="month in months" :key="month" class="workday-month"><h2>{{ month }} 月</h2><div class="calendar-weekdays"><span v-for="label in weekdayLabels" :key="label">{{ label }}</span></div><div class="calendar-days"><span v-for="(day, index) in monthCells(month)" :key="index" :class="['calendar-day', day ? dayClass(month, day) : 'calendar-empty']" :title="day ? dayHint(month, day) : ''" @click="day && selectDay(month, day)"><template v-if="day"><strong>{{ day }}</strong><small v-if="entry(month, day)">{{ dayHint(month, day) }}</small></template></span></div></article></section>
</section></AdminLayout></template>
