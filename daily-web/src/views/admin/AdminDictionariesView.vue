<script setup lang="ts">
import { onMounted, reactive, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type DictionaryRecord, type Page } from '@/api/admin'
import { apiError } from '@/api/http'
import Pagination from '@/components/Pagination.vue'

const rows = ref<DictionaryRecord[]>([])
const totalItems = ref(0)
const totalPages = ref(0)
const page = ref(0)
const pageSize = ref(20)
const loading = ref(false)
const editingId = ref<number | null>(null)
const message = ref('')
const form = reactive({ category: 'work_type', code: '', label: '', sortOrder: 0, active: true })
const categories = [
  ['work_type', '工作任务类型'], ['work_stage', '工作阶段'],
  ['participation_role', '参与角色'], ['current_status', '当前状态'],
  ['risk_type', '问题类型'], ['collaboration_role', '协同角色'],
] as const
async function load() {
  loading.value = true
  try {
    const data = (await adminApi.dictionaries({ page: page.value, size: pageSize.value })).data as Page<DictionaryRecord>
    rows.value = data.items
    totalItems.value = data.totalItems
    totalPages.value = data.totalPages
  } finally {
    loading.value = false
  }
}
function edit(row: DictionaryRecord) { editingId.value = row.id; Object.assign(form, row) }
function reset() { editingId.value = null; Object.assign(form, { category: 'work_type', code: '', label: '', sortOrder: 0, active: true }) }
async function save() { try { if (editingId.value) await adminApi.updateDictionary({ id: editingId.value, ...form }); else await adminApi.createDictionary(form); message.value = '字典项已保存'; reset(); await load() } catch (cause) { message.value = apiError(cause).message } }
async function deactivate(id: number) { await adminApi.deleteDictionary(id); await load() }
onMounted(load)
</script>

<template><AdminLayout><section class="admin-page"><div class="admin-title"><div><span class="eyebrow">MASTER DATA</span><h1>业务字典维护</h1></div></div>
  <form class="admin-form" @submit.prevent="save"><label>分类<select v-model="form.category"><option v-for="[code, label] in categories" :key="code" :value="code">{{ label }}</option></select></label><label>编码<input v-model.trim="form.code" required /></label><label>显示名称<input v-model.trim="form.label" required /></label><label>排序<input v-model.number="form.sortOrder" type="number" min="0" required /></label><label class="check-field"><input v-model="form.active" type="checkbox" /> 启用</label><div class="form-actions"><button class="button-primary" type="submit">{{ editingId ? '保存修改' : '新增字典项' }}</button><button v-if="editingId" type="button" @click="reset">取消</button></div></form>
  <p v-if="message" class="feedback" role="status">{{ message }}</p><div class="admin-table-wrap"><table><thead><tr><th>分类</th><th>编码</th><th>名称</th><th>排序</th><th>状态</th><th>操作</th></tr></thead><tbody><tr v-for="row in rows" :key="row.id"><td>{{ row.category }}</td><td>{{ row.code }}</td><td>{{ row.label }}</td><td>{{ row.sortOrder }}</td><td>{{ row.active ? '启用' : '停用' }}</td><td class="table-actions"><button type="button" @click="edit(row)">编辑</button><button v-if="row.active" type="button" @click="deactivate(row.id)">停用</button></td></tr></tbody></table></div>
  <Pagination v-model:page="page" v-model:page-size="pageSize"
    :total-items="totalItems" :total-pages="totalPages"
    :loading="loading" @change="load" />
</section></AdminLayout></template>
