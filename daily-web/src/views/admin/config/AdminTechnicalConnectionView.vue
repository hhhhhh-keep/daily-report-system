<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { adminApi, type AnalysisConfiguration } from '@/api/admin'
import { apiError } from '@/api/http'

const config = ref<AnalysisConfiguration | null>(null)
const recipientText = ref('')
const ccText = ref('')
const showApiKey = ref(false)
const showSmtpPassword = ref(false)
const message = ref('')
const errorMessage = ref('')
const connectionMessage = ref('')
const smtpHasConfig = computed(() => Boolean(config.value && (config.value.smtpHost || config.value.smtpPort || config.value.smtpUsername || config.value.smtpPassword || config.value.smtpFrom)))

async function load() {
  errorMessage.value = ''
  try {
    config.value = (await adminApi.analysisConfiguration()).data
    recipientText.value = config.value.recipients.join(', ')
    ccText.value = config.value.ccRecipients.join(', ')
  } catch (caught) { errorMessage.value = apiError(caught).message }
}
async function save() {
  if (!config.value) return
  message.value = ''; errorMessage.value = ''
  config.value.recipients = recipientText.value.split(',').map(value => value.trim()).filter(Boolean)
  config.value.ccRecipients = ccText.value.split(',').map(value => value.trim()).filter(Boolean)
  try { config.value = (await adminApi.updateAnalysisConfiguration(config.value)).data; message.value = '技术连接已保存并立即生效' }
  catch (caught) { errorMessage.value = apiError(caught).message }
}
async function testModelConnection() {
  if (!config.value) return
  connectionMessage.value = ''; errorMessage.value = ''
  try { connectionMessage.value = (await adminApi.testAnalysisConnection(config.value)).data.message }
  catch (caught) { errorMessage.value = apiError(caught).message }
}
function clearSmtp() {
  if (!config.value) return
  config.value.smtpHost = null; config.value.smtpPort = null; config.value.smtpUsername = null; config.value.smtpPassword = null; config.value.smtpFrom = null
}
onMounted(load)
</script>

<template>
  <AdminLayout><section class="admin-page">
    <div class="admin-title"><div><span class="eyebrow">CONNECTIONS</span><h1>技术连接</h1></div></div>
    <p class="feedback">配置模型服务与报告发送通道；分析规则、输出结构和报告模板由 Skills 中心管理。</p>
    <p v-if="errorMessage" class="feedback error" role="alert">{{ errorMessage }}</p>
    <form v-if="config" class="connection-form" @submit.prevent="save">
      <section class="connection-card"><div class="card-heading"><h2>模型服务</h2></div><div class="form-grid">
        <label>模型名称<input v-model.trim="config.modelName" placeholder="未配置时使用 LLM_MODEL" /></label>
        <label>模型 API Key<div class="secret-input"><input v-model="config.modelApiKey" :type="showApiKey ? 'text' : 'password'" autocomplete="off" placeholder="留空时回落到环境变量 LLM_API_KEY" /><button type="button" class="button-link" @click="showApiKey = !showApiKey">{{ showApiKey ? '隐藏' : '显示' }}</button></div></label>
        <label class="field-wide">模型端点<input v-model.trim="config.modelEndpoint" placeholder="未配置时使用 LLM_ENDPOINT" /></label>
        <div class="field-wide form-actions"><button data-testid="test-model-connection" type="button" class="button-secondary" @click="testModelConnection">测试模型连接</button><span v-if="connectionMessage" class="feedback">{{ connectionMessage }}</span></div>
      </div></section>
      <section class="connection-card"><div class="card-heading"><h2>邮件发送</h2></div><div class="form-grid">
        <label class="check-field field-wide"><input v-model="config.emailEnabled" type="checkbox" /> 通过 SMTP 发送邮件</label>
        <label class="field-wide">收件人（逗号分隔）<input v-model="recipientText" /></label>
        <label class="field-wide">抄送人（逗号分隔）<input v-model="ccText" /></label>
      </div></section>
      <section class="connection-card"><div class="card-heading"><h2>SMTP 发件箱</h2><span :class="smtpHasConfig ? '' : 'subtle'">{{ smtpHasConfig ? '已自定义' : '使用环境变量' }}</span></div><div class="form-grid">
        <label>SMTP 服务器<input v-model.trim="config.smtpHost" placeholder="例如 smtp.qq.com" /></label>
        <label>SMTP 端口<input v-model.number="config.smtpPort" type="number" min="1" max="65535" placeholder="465 / 587 / 25" /></label>
        <label>用户名<input v-model.trim="config.smtpUsername" autocomplete="off" placeholder="通常是发件邮箱" /></label>
        <label>密码 / 授权码<div class="secret-input"><input v-model="config.smtpPassword" :type="showSmtpPassword ? 'text' : 'password'" autocomplete="off" placeholder="留空时使用 SMTP_PASSWORD" /><button type="button" class="button-link" @click="showSmtpPassword = !showSmtpPassword">{{ showSmtpPassword ? '隐藏' : '显示' }}</button></div></label>
        <label class="field-wide">发件人地址<input v-model.trim="config.smtpFrom" placeholder="例如 noreply@example.com" /></label>
        <div class="field-wide form-actions-inline"><button v-if="smtpHasConfig" type="button" class="button-link danger" @click="clearSmtp">清空发件箱配置（改用环境变量）</button><p class="hint">留空字段将沿用服务器环境变量；保存后立即生效，无需重启服务。</p></div>
      </div></section>
      <div class="save-bar"><button class="button-primary" type="submit">保存技术连接</button><p v-if="message" class="save-feedback success" role="status">✓ {{ message }}</p></div>
    </form>
  </section></AdminLayout>
</template>

<style scoped>
.connection-form { display: grid; gap: 18px; }
.connection-card { display: grid; gap: 16px; padding: 22px; border: 1px solid #e4e7ec; border-radius: 16px; background: #fff; }
.secret-input, .save-bar { display: flex; align-items: center; gap: 8px; }
.secret-input input { flex: 1; }
.card-heading span { padding: 5px 9px; border-radius: 999px; color: #067647; background: #ecfdf3; font-size: .78rem; font-weight: 600; }
.card-heading span.subtle { color: #667085; background: #f2f4f7; }
.form-actions-inline { display: flex; flex-wrap: wrap; align-items: center; gap: 12px; }
.hint { flex: 1; min-width: 240px; margin: 0; color: #667085; font-size: .82rem; }
.save-bar { flex-wrap: wrap; }
.save-feedback { margin: 0; padding: 10px 13px; border-radius: 10px; font-weight: 700; }
.save-feedback.success { color: #067647; background: #ecfdf3; }
</style>
