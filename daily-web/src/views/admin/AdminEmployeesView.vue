<script setup lang="ts">
import { onMounted, reactive, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type EmployeeRecord, type Page } from '@/api/admin'
import { apiError } from '@/api/http'
import Pagination from '@/components/Pagination.vue'

const rows = ref<EmployeeRecord[]>([])
const totalItems = ref(0)
const totalPages = ref(0)
const page = ref(0)
const pageSize = ref(20)
const loading = ref(false)
const editingId = ref<number | null>(null)
const message = ref('')
const form = reactive({ name: '', teamName: '', positionType: '', active: true })

async function load() {
  loading.value = true
  try {
    const data = (await adminApi.employees({ page: page.value, size: pageSize.value })).data as Page<EmployeeRecord>
    rows.value = data.items
    totalItems.value = data.totalItems
    totalPages.value = data.totalPages
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
    <div class="admin-table-wrap"><table><thead><tr><th>姓名</th><th>团队</th><th>岗位</th><th>状态</th><th>操作</th></tr></thead>
      <tbody><tr v-for="row in rows" :key="row.id"><td>{{ row.name }}</td><td>{{ row.teamName }}</td>
        <td>{{ row.positionType }}</td><td>{{ row.active ? '启用' : '停用' }}</td><td class="table-actions">
          <button type="button" @click="edit(row)">编辑</button><button v-if="row.active" type="button" @click="deactivate(row.id)">停用</button>
        </td></tr></tbody></table></div>
    <Pagination v-model:page="page" v-model:page-size="pageSize"
      :total-items="totalItems" :total-pages="totalPages"
      :loading="loading" @change="load" />
  </section></AdminLayout>
</template>
