<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi } from '@/api/admin'
import { apiError } from '@/api/http'

const currentPassword = ref('')
const newPassword = ref('')
const confirmation = ref('')
const message = ref('')
async function save() {
  if (newPassword.value !== confirmation.value) { message.value = '两次输入的新密码不一致'; return }
  try {
    await adminApi.changePassword(currentPassword.value, newPassword.value)
    currentPassword.value = ''; newPassword.value = ''; confirmation.value = ''
    message.value = '管理员密码已更新'
  } catch (caught) { message.value = apiError(caught).message }
}
</script>

<template><AdminLayout><section class="admin-page narrow">
  <div class="admin-title"><div><span class="eyebrow">SECURITY</span><h1>修改管理员密码</h1></div></div>
  <form class="admin-form single" @submit.prevent="save">
    <label>当前密码<input v-model="currentPassword" type="password" autocomplete="current-password" required /></label>
    <label>新密码<input v-model="newPassword" type="password" minlength="12" autocomplete="new-password" required /></label>
    <label>确认新密码<input v-model="confirmation" type="password" minlength="12" autocomplete="new-password" required /></label>
    <button class="button-primary" type="submit">更新密码</button>
  </form><p v-if="message" class="feedback" role="status">{{ message }}</p>
</section></AdminLayout></template>
