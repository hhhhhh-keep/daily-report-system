<script setup lang="ts">
import { useRouter } from 'vue-router'
import { adminApi } from '@/api/admin'
import { setAdminSessionMarker } from '@/router/guards'

const router = useRouter()

async function logout() {
  await adminApi.logout()
  setAdminSessionMarker(false)
  await router.push({ name: 'admin' })
}
</script>

<template>
  <div class="admin-layout">
    <aside class="admin-sidebar">
      <span class="eyebrow">MANAGEMENT</span>
      <strong>日报管理中心</strong>
      <nav aria-label="管理导航">
        <RouterLink to="/admin/dashboard">驾驶舱</RouterLink>
        <RouterLink to="/admin/employees">人员</RouterLink>
        <RouterLink to="/admin/projects">项目 / 专项</RouterLink>
        <RouterLink to="/admin/dictionaries">业务字典</RouterLink>
        <RouterLink to="/admin/workday-calendar">工作日历</RouterLink>
        <RouterLink to="/admin/reports">日报管理</RouterLink>
        <RouterLink to="/admin/analysis">分析中心</RouterLink>
        <RouterLink to="/admin/run-schedule">运行计划</RouterLink>
        <RouterLink to="/admin/technical-connections">技术连接</RouterLink>
        <RouterLink to="/admin/skills">Skills 中心</RouterLink>
        <RouterLink to="/admin/runs">任务记录</RouterLink>
        <RouterLink to="/admin/password">修改密码</RouterLink>
      </nav>
      <button class="admin-logout" type="button" @click="logout">退出登录</button>
    </aside>
    <main class="admin-content"><slot /></main>
  </div>
</template>
