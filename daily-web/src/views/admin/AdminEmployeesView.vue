<script setup lang="ts">
import { computed, onMounted, reactive, ref, watch } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type EmployeeRecord } from '@/api/admin'
import { apiError } from '@/api/http'
import Pagination from '@/components/Pagination.vue'

const rows = ref<EmployeeRecord[]>([])
const page = ref(0)
const pageSize = ref(20)
const loading = ref(false)
const editingId = ref<number | null>(null)
const message = ref('')
const teamFilter = ref('')
const statusFilter = ref<'ALL' | 'ACTIVE' | 'INACTIVE'>('ALL')
const keyword = ref('')
const form = reactive({ name: '', teamName: '', positionType: '', active: true })

// ponytail: 当前部门约 100 人，一次加载 200 条即可完成本地筛选与分组；超过该规模时改为后端筛选。
const employeeLoadSize = 200

async function load() {
  loading.value = true
  try {
    const data = (await adminApi.employees({ page: 0, size: employeeLoadSize })).data
    rows.value = data.items
  } finally {
    loading.value = false
  }
}
function edit(row: EmployeeRecord) {
  editingId.value = row.id
  Object.assign(form, row)
}
function reset() {
  editingId.value = null
  Object.assign(form, { name: '', teamName: '', positionType: '', active: true })
}
async function save() {
  try {
    if (editingId.value) await adminApi.updateEmployee({ id: editingId.value, ...form })
    else await adminApi.createEmployee(form)
    message.value = '人员资料已保存'
    reset()
    await load()
  } catch (caught) { message.value = apiError(caught).message }
}
async function deactivate(id: number) { await adminApi.deleteEmployee(id); await load() }
const teams = computed(() => [...new Set(rows.value.map((item) => item.teamName))].sort((left, right) => left.localeCompare(right, 'zh-CN')))
const filteredRows = computed(() => {
  const search = keyword.value.trim().toLocaleLowerCase('zh-CN')
  return rows.value.filter((item) =>
    (!teamFilter.value || item.teamName === teamFilter.value)
    && (statusFilter.value === 'ALL' || item.active === (statusFilter.value === 'ACTIVE'))
    && (!search || [item.name, item.teamName, item.positionType].some((value) => value.toLocaleLowerCase('zh-CN').includes(search))),
  ).sort((left, right) => left.teamName.localeCompare(right.teamName, 'zh-CN') || left.name.localeCompare(right.name, 'zh-CN'))
})
const totalItems = computed(() => filteredRows.value.length)
const totalPages = computed(() => Math.ceil(totalItems.value / pageSize.value))
const pagedRows = computed(() => filteredRows.value.slice(page.value * pageSize.value, (page.value + 1) * pageSize.value))
const groupedRows = computed(() => {
  const groups = new Map<string, EmployeeRecord[]>()
  pagedRows.value.forEach((row) => groups.set(row.teamName, [...(groups.get(row.teamName) ?? []), row]))
  return [...groups.entries()].map(([teamName, members]) => ({ teamName, members }))
})
const hasActiveFilter = computed(() => Boolean(teamFilter.value || keyword.value || statusFilter.value !== 'ALL'))
function resetFilters() { teamFilter.value = ''; statusFilter.value = 'ALL'; keyword.value = '' }
watch([teamFilter, statusFilter, keyword, pageSize], () => { page.value = 0 })
onMounted(load)
</script>

<template>
  <AdminLayout><section class="admin-page">
    <div class="admin-title"><div><span class="eyebrow">MASTER DATA</span><h1>人员维护</h1></div></div>
    <form class="admin-form" @submit.prevent="save">
      <label>姓名<input v-model.trim="form.name" required /></label>
      <label>团队<input v-model.trim="form.teamName" required /></label>
      <label>岗位类型<input v-model.trim="form.positionType" required /></label>
      <label class="check-field"><input v-model="form.active" type="checkbox" /> 启用</label>
      <div class="form-actions"><button class="button-primary" type="submit">{{ editingId ? '保存修改' : '新增人员' }}</button>
        <button v-if="editingId" type="button" @click="reset">取消</button></div>
    </form>
    <p v-if="message" class="feedback" role="status">{{ message }}</p>
    <div class="admin-form wide employee-filters" role="search">
      <label>团队<select v-model="teamFilter"><option value="">全部团队</option><option v-for="team in teams" :key="team" :value="team">{{ team }}</option></select></label>
      <label>状态<select v-model="statusFilter"><option value="ALL">全部状态</option><option value="ACTIVE">启用</option><option value="INACTIVE">停用</option></select></label>
      <label>关键词<input v-model.trim="keyword" type="search" placeholder="匹配姓名、团队或岗位" /></label>
      <button v-if="hasActiveFilter" type="button" class="button-link" @click="resetFilters">清空筛选</button>
    </div>
    <div class="admin-table-wrap"><table><thead><tr><th>姓名</th><th>团队</th><th>岗位</th><th>状态</th><th>操作</th></tr></thead>
      <tbody v-for="group in groupedRows" :key="group.teamName">
        <tr class="team-group"><th colspan="5">团队：{{ group.teamName }}</th></tr>
        <tr v-for="row in group.members" :key="row.id"><td>{{ row.name }}</td><td>{{ row.teamName }}</td>
          <td>{{ row.positionType }}</td><td>{{ row.active ? '启用' : '停用' }}</td><td class="table-actions">
            <button type="button" @click="edit(row)">编辑</button><button v-if="row.active" type="button" @click="deactivate(row.id)">停用</button>
          </td></tr>
      </tbody>
      <tbody v-if="!filteredRows.length"><tr><td colspan="5" class="empty-row">当前筛选下没有人员</td></tr></tbody></table></div>
    <Pagination v-model:page="page" v-model:page-size="pageSize"
      :total-items="totalItems" :total-pages="totalPages"
      :loading="loading" />
  </section></AdminLayout>
</template>

<style scoped>
.employee-filters { margin: 18px 0; }
.team-group th { background: #eff4ff; color: #344054; text-align: left; }
</style>
