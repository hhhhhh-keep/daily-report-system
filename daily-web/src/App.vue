<script setup lang="ts">
import { RouterView } from 'vue-router'
import { dismissToast, toasts } from '@/utils/toast'
</script>

<template>
  <RouterView />
  <aside class="toast-stack" aria-live="polite" aria-label="系统提示"><div v-for="toast in toasts" :key="toast.id" :class="['toast', toast.type]">
    <strong>{{ toast.type === 'success' ? '操作成功' : '操作失败' }}</strong><span>{{ toast.text }}</span><button type="button" aria-label="关闭提示" @click="dismissToast(toast.id)">×</button>
  </div></aside>
</template>
