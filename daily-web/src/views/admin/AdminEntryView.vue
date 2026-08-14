<script setup lang="ts">
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { adminApi } from '@/api/admin'
import { apiError } from '@/api/http'
import { setAdminSessionMarker } from '@/router/guards'

const route = useRoute()
const router = useRouter()
const username = ref('admin')
const password = ref('')
const error = ref('')
const pending = ref(false)

async function login() {
  pending.value = true
  error.value = ''
  try {
    await adminApi.login(username.value, password.value)
    setAdminSessionMarker(true)
    const redirect = typeof route.query.redirect === 'string'
      ? route.query.redirect : '/admin/dashboard'
    await router.push(redirect)
  } catch (caught) {
    error.value = apiError(caught).message
  } finally {
    pending.value = false
  }
}
</script>

<template>
  <main class="admin-login-page">
    <form class="admin-login-card" @submit.prevent="login">
      <span class="eyebrow">MANAGEMENT</span>
      <h1>日报管理中心</h1>
      <p>使用唯一管理员账号维护基础数据、查看日报和驾驶舱。</p>
      <label>用户名<input v-model.trim="username" autocomplete="username" required /></label>
      <label>密码<input v-model="password" type="password" autocomplete="current-password" required /></label>
      <p v-if="error" class="feedback error" role="alert">{{ error }}</p>
      <button class="button-primary" :disabled="pending" type="submit">
        {{ pending ? '正在登录…' : '登录管理后台' }}
      </button>
      <RouterLink to="/report">返回日报填写</RouterLink>
    </form>
  </main>
</template>
