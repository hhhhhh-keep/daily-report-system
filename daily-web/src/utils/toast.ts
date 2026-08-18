import { ref } from 'vue'

export interface Toast { id: number; type: 'success' | 'error'; text: string }

export const toasts = ref<Toast[]>([])
let nextId = 1

export function notify(text: string, type: Toast['type'] = 'success') {
  const id = nextId++
  toasts.value.push({ id, type, text })
  window.setTimeout(() => dismissToast(id), 4_000)
}

export function dismissToast(id: number) {
  toasts.value = toasts.value.filter((toast) => toast.id !== id)
}
