<script setup lang="ts">
import { computed, ref } from 'vue'

export type SearchCandidate = {
  key: string
  value: string
  title: string
  detail?: string
}

const props = withDefaults(defineProps<{
  modelValue: string
  candidates: SearchCandidate[]
  placeholder: string
  required?: boolean
  disabled?: boolean
  emptyMessage?: string
}>(), {
  required: false,
  disabled: false,
  emptyMessage: '未找到匹配项',
})
const emit = defineEmits<{
  'update:modelValue': [value: string]
  select: [candidate: SearchCandidate]
}>()

const focused = ref(false)
const activeIndex = ref(-1)
const keyword = computed(() => props.modelValue.trim().toLocaleLowerCase('zh-CN'))
const visibleCandidates = computed(() => keyword.value
  ? props.candidates.filter((candidate) => `${candidate.title} ${candidate.detail ?? ''}`.toLocaleLowerCase('zh-CN').includes(keyword.value)).slice(0, 20)
  : [])
const expanded = computed(() => focused.value && keyword.value.length > 0)

function update(value: string): void {
  activeIndex.value = -1
  emit('update:modelValue', value)
}

function choose(candidate: SearchCandidate): void {
  emit('update:modelValue', candidate.value)
  emit('select', candidate)
  focused.value = false
  activeIndex.value = -1
}

function moveActive(step: number): void {
  if (!visibleCandidates.value.length) return
  activeIndex.value = (activeIndex.value + step + visibleCandidates.value.length) % visibleCandidates.value.length
}

function handleKeydown(event: KeyboardEvent): void {
  if (event.key === 'ArrowDown') {
    event.preventDefault()
    focused.value = true
    moveActive(1)
  } else if (event.key === 'ArrowUp') {
    event.preventDefault()
    focused.value = true
    moveActive(-1)
  } else if (event.key === 'Enter' && activeIndex.value >= 0) {
    event.preventDefault()
    const candidate = visibleCandidates.value[activeIndex.value]
    if (candidate) choose(candidate)
  } else if (event.key === 'Escape') {
    focused.value = false
    activeIndex.value = -1
  }
}
</script>

<template>
  <div class="search-candidate">
    <input
      :value="modelValue"
      :required="required"
      :disabled="disabled"
      :placeholder="placeholder"
      autocomplete="off"
      role="combobox"
      aria-autocomplete="list"
      :aria-expanded="expanded"
      @input="update(($event.target as HTMLInputElement).value)"
      @focus="focused = true"
      @blur="focused = false"
      @keydown="handleKeydown"
    />
    <ul v-if="expanded" class="search-candidate-list" role="listbox">
      <li v-if="!visibleCandidates.length" class="search-candidate-empty">{{ emptyMessage }}</li>
      <li
        v-for="(candidate, candidateIndex) in visibleCandidates"
        :key="candidate.key"
        class="search-candidate-option"
        :class="{ active: candidateIndex === activeIndex }"
        role="option"
        :aria-selected="candidateIndex === activeIndex"
        @pointerdown.prevent="choose(candidate)"
      >
        <strong>{{ candidate.title }}</strong>
        <small v-if="candidate.detail">{{ candidate.detail }}</small>
      </li>
    </ul>
  </div>
</template>
