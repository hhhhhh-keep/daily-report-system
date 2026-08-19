<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import type { DictionaryOption, ReportTaskInput } from '@/api/report'

const props = defineProps<{
  index: number
  projectChoices: Array<{ id: number; label: string; type: 'project' | 'special' }>
  dictionaries: Record<string, DictionaryOption[]>
  allowedTimePeriods: string[]
  removable: boolean
}>()
const emit = defineEmits<{ remove: [] }>()
const task = defineModel<ReportTaskInput>({ required: true })
const isSpecialWork = computed(() => task.value.workType === 'special-work')
const choices = computed(() => props.projectChoices.filter((item) =>
  item.type === (isSpecialWork.value ? 'special' : 'project')))
const needsIssueDetails = computed(() => task.value.currentStatus === 'blocked')
const projectSearch = ref('')
const matchingChoices = computed(() => {
  const keyword = projectSearch.value.trim().toLocaleLowerCase()
  return keyword ? choices.value.filter((item) => item.label.toLocaleLowerCase().includes(keyword)).slice(0, 20) : []
})
const stageGroups = computed(() => [
  { label: '售前', codes: ['presales-requirements-analysis', 'presales-solution-design', 'presales-bid-quotation', 'presales-technical-presentation'] },
  { label: '售中/交付', codes: ['delivery-implementation', 'delivery-testing-deployment', 'delivery-training-acceptance', 'after-sales-operations-support', 'after-sales-incident-handling', 'after-sales-optimization-upgrade', 'after-sales-customer-support'] },
].map((group) => ({ ...group, options: (props.dictionaries.work_stage ?? []).filter((item) => group.codes.includes(item.code)) })))
const stageCategory = ref('')
const visibleStages = computed(() => stageGroups.value.find((group) => group.label === stageCategory.value)?.options ?? [])

function onStageCategoryChanged(): void {
  task.value.workStage = ''
}

function onWorkTypeChanged(): void {
  if (isSpecialWork.value) {
    task.value.workStage = ''
    task.value.projectId = null
  }
}

function selectProject(): void {
  const selected = choices.value.find((item) => item.label === projectSearch.value)
  task.value.projectId = selected?.id ?? null
  task.value.projectName = selected ? undefined : projectSearch.value.trim()
}
watch(choices, () => { projectSearch.value = choices.value.find((item) => item.id === task.value.projectId)?.label ?? '' }, { immediate: true })
</script>

<template>
  <fieldset class="task-card" :aria-label="`工作任务 ${index + 1}`">
    <div class="task-heading">
      <legend>工作任务 {{ index + 1 }}</legend>
      <button v-if="removable" type="button" class="button-link danger" @click="emit('remove')">删除任务</button>
    </div>
    <div class="form-grid">
      <label>时段<select v-model="task.timePeriod" required><option v-if="allowedTimePeriods.includes('morning')" value="morning">上午</option><option v-if="allowedTimePeriods.includes('afternoon')" value="afternoon">下午</option><option v-if="allowedTimePeriods.includes('full-day')" value="full-day">全天</option></select></label>
      <label>工作任务类型<select v-model="task.workType" required @change="onWorkTypeChanged"><option v-for="item in dictionaries.work_type ?? []" :key="item.id" :value="item.code">{{ item.label }}</option></select></label>
      <label>{{ isSpecialWork ? '专项名称' : '项目名称' }}<input v-model="projectSearch" :list="projectSearch.trim() ? `project-options-${index}` : undefined" required autocomplete="off" :placeholder="isSpecialWork ? '输入关键字选择，或直接输入新专项' : '输入关键字选择，或直接输入新项目'" @input="selectProject" @change="selectProject" /><datalist :id="`project-options-${index}`"><option v-for="item in matchingChoices" :key="item.id" :value="item.label" /></datalist><small class="field-hint">未找到时直接填写名称，提交后自动新增。</small></label>
      <label v-if="!isSpecialWork">阶段分类<select v-model="stageCategory" required @change="onStageCategoryChanged"><option value="" disabled>请选择阶段分类</option><option v-for="group in stageGroups" :key="group.label" :value="group.label">{{ group.label }}</option></select></label>
      <label v-if="!isSpecialWork">工作阶段<select v-model="task.workStage" required :disabled="!stageCategory"><option value="" disabled>请选择工作阶段</option><option v-for="item in visibleStages" :key="item.id" :value="item.code">{{ item.label }}</option></select></label>
      <label>参与角色<select v-model="task.participationRole" required><option v-for="item in dictionaries.participation_role ?? []" :key="item.id" :value="item.code">{{ item.label }}</option></select></label>
      <label class="field-wide">工作内容与产出<textarea v-model.trim="task.progressResult" required maxlength="4000" rows="4" placeholder="请写清具体工作内容和已完成产物。" /></label>
      <label>当前状态<select v-model="task.currentStatus" required><option v-for="item in dictionaries.current_status ?? []" :key="item.id" :value="item.code">{{ item.label }}</option></select></label>
    </div>
    <div v-if="needsIssueDetails" class="issue-fields" data-testid="issue-fields">
      <label>问题类型<select v-model="task.issueType" required><option value="" disabled>请选择问题类型</option><option v-for="item in dictionaries.risk_type ?? []" :key="item.id" :value="item.code">{{ item.label }}</option></select></label>
      <label>需要协同角色<select v-model="task.collaborationRole" required><option value="" disabled>请选择协同角色</option><option v-for="item in dictionaries.collaboration_role ?? []" :key="item.id" :value="item.code">{{ item.label }}</option></select></label>
      <label class="field-wide">风险及协同需求<textarea v-model.trim="task.collaborationRequirement" required maxlength="2000" rows="3" /></label>
    </div>
  </fieldset>
</template>
