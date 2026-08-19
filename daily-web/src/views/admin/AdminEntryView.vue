<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { adminApi } from '@/api/admin'
import { apiError } from '@/api/http'
import { setAdminSessionMarker } from '@/router/guards'

const REMEMBERED_CREDENTIALS_KEY = 'daily-admin-remembered-credentials'
const REMEMBERED_CREDENTIALS_TTL = 30 * 24 * 60 * 60 * 1000

const route = useRoute()
const router = useRouter()
const username = ref('admin')
const password = ref('')
const rememberMe = ref(false)
const error = ref('')
const pending = ref(false)
const restoringSession = ref(true)

function restoreRememberedCredentials() {
  try {
    const raw = localStorage.getItem(REMEMBERED_CREDENTIALS_KEY)
    if (!raw) return
    const saved = JSON.parse(raw)
    if (typeof saved.username !== 'string' || typeof saved.password !== 'string'
      || typeof saved.expiresAt !== 'number' || saved.expiresAt <= Date.now()) {
      localStorage.removeItem(REMEMBERED_CREDENTIALS_KEY)
      return
    }
    username.value = saved.username
    password.value = saved.password
    rememberMe.value = true
  } catch {
    localStorage.removeItem(REMEMBERED_CREDENTIALS_KEY)
  }
}

function saveRememberedCredentials() {
  if (!rememberMe.value) {
    localStorage.removeItem(REMEMBERED_CREDENTIALS_KEY)
    return
  }
  localStorage.setItem(REMEMBERED_CREDENTIALS_KEY, JSON.stringify({
    username: username.value,
    password: password.value,
    expiresAt: Date.now() + REMEMBERED_CREDENTIALS_TTL,
  }))
}

restoreRememberedCredentials()

onMounted(async () => {
  try {
    await adminApi.session()
    setAdminSessionMarker(true)
    await router.replace('/admin/dashboard')
  } catch {
    setAdminSessionMarker(false)
  } finally {
    restoringSession.value = false
  }
})

async function login() {
  pending.value = true
  error.value = ''
  try {
    await adminApi.login(username.value, password.value, rememberMe.value)
    saveRememberedCredentials()
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
    <p v-if="restoringSession" class="feedback" role="status">正在恢复登录状态…</p>
    <form v-else class="admin-login-card" autocomplete="on" @submit.prevent="login">
      <span class="eyebrow">MANAGEMENT</span>
      <h1>日报管理中心</h1>
      <p>使用唯一管理员账号维护基础数据、查看日报和驾驶舱。</p>
      <label>用户名<input v-model.trim="username" name="username" autocomplete="username" required /></label>
      <label>密码<input v-model="password" name="password" type="password" autocomplete="current-password" required /></label>
      <label class="check-field"><input v-model="rememberMe" type="checkbox" />记住密码并保持登录（30 天）</label>
      <small class="field-hint">仅限个人受控电脑；退出登录后仍会自动回填。</small>
      <p v-if="error" class="feedback error" role="alert">{{ error }}</p>
      <button class="button-primary" :disabled="pending" type="submit">
        {{ pending ? '正在登录…' : '登录管理后台' }}
      </button>
      <RouterLink to="/report">返回日报填写</RouterLink>
    </form>
  </main>
</template>
