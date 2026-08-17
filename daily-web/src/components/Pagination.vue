<script setup lang="ts">
import { computed } from 'vue'

defineOptions({ name: 'AppPagination' })

/**
 * 通用分页组件：双向绑定 page + pageSize，总数变化时自动回正到第 0 页。
 *
 * 用法：
 *   <Pagination v-model:page="page" v-model:page-size="pageSize"
 *               :total-items="data.totalItems" :total-pages="data.totalPages"
 *               @change="reload" />
 */
const props = defineProps<{
  page: number
  pageSize: number
  totalItems: number
  totalPages: number
  /** 每页条数候选项，默认 10/20/50/100 */
  pageSizes?: number[]
  /** 数据加载中时禁用按钮 */
  loading?: boolean
}>()

const emit = defineEmits<{
  (e: 'update:page', value: number): void
  (e: 'update:pageSize', value: number): void
  (e: 'change'): void
}>()

const pageSizes = computed(() => props.pageSizes ?? [10, 20, 50, 100])

const hasPrev = computed(() => props.page > 0)
const hasNext = computed(() => props.page < Math.max(0, props.totalPages - 1))

const range = computed<[number, number]>(() => {
  if (props.totalItems === 0) return [0, 0]
  const start = props.page * props.pageSize + 1
  const end = Math.min(props.totalItems, (props.page + 1) * props.pageSize)
  return [start, end]
})

function goto(target: number) {
  if (props.loading) return
  const clamped = Math.max(0, Math.min(target, Math.max(0, props.totalPages - 1)))
  if (clamped === props.page) return
  emit('update:page', clamped)
  emit('change')
}

function changeSize(event: Event) {
  const target = event.target as HTMLSelectElement
  const value = Number(target.value)
  if (!Number.isFinite(value) || value === props.pageSize) return
  emit('update:pageSize', value)
  emit('update:page', 0) // 切换每页条数时回到第一页
  emit('change')
}
</script>

<template>
  <div class="pagination" v-if="totalItems > 0">
    <div class="pagination-range">
      第 <strong>{{ range[0] }}</strong> - <strong>{{ range[1] }}</strong> 条
      &nbsp;/&nbsp; 共 <strong>{{ totalItems }}</strong> 条
    </div>
    <div class="pagination-controls">
      <button type="button" class="page-btn" :disabled="!hasPrev || loading"
        aria-label="首页" @click="goto(0)">«</button>
      <button type="button" class="page-btn" :disabled="!hasPrev || loading"
        aria-label="上一页" @click="goto(page - 1)">‹</button>
      <span class="page-indicator">第 {{ page + 1 }} / {{ Math.max(1, totalPages) }} 页</span>
      <button type="button" class="page-btn" :disabled="!hasNext || loading"
        aria-label="下一页" @click="goto(page + 1)">›</button>
      <button type="button" class="page-btn" :disabled="!hasNext || loading"
        aria-label="末页" @click="goto(Math.max(0, totalPages - 1))">»</button>
    </div>
    <label class="pagination-size">
      每页
      <select :value="pageSize" :disabled="loading" @change="changeSize">
        <option v-for="size in pageSizes" :key="size" :value="size">{{ size }}</option>
      </select>
      条
    </label>
  </div>
</template>

<style scoped>
.pagination {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  align-items: center;
  justify-content: space-between;
  padding: 12px 0;
  color: #475467;
  font-size: 0.86rem;
}
.pagination-range strong { color: #101828; }
.pagination-controls { display: flex; gap: 6px; align-items: center; }
.page-btn {
  min-width: 32px;
  height: 32px;
  border-radius: 8px;
  border: 1px solid #d0d5dd;
  background: #fff;
  color: #344054;
  font-weight: 600;
  cursor: pointer;
}
.page-btn:hover:not(:disabled) { border-color: #84adff; color: #155eef; }
.page-btn:disabled { color: #cbd5e1; cursor: not-allowed; background: #f8fafc; }
.page-indicator { padding: 0 10px; color: #101828; font-weight: 600; }
.pagination-size { display: flex; gap: 6px; align-items: center; }
.pagination-size select {
  height: 32px;
  padding: 0 8px;
  border: 1px solid #d0d5dd;
  border-radius: 8px;
  background: #fff;
  color: #101828;
}
</style>
