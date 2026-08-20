import { mount } from '@vue/test-utils'
import { describe, expect, it } from 'vitest'
import SearchCandidateInput from '@/components/common/SearchCandidateInput.vue'

const candidates = [
  { key: '1', value: '林晨 · 行业解决方案', title: '林晨', detail: '行业解决方案' },
  { key: '2', value: '王林 · 售中交付', title: '王林', detail: '售中交付' },
]

describe('SearchCandidateInput', () => {
  it('only displays matched candidates after input and selects with pointer or keyboard', async () => {
    const wrapper = mount(SearchCandidateInput, {
      props: { modelValue: '', candidates, placeholder: '输入姓名关键字后选择' },
    })
    const input = wrapper.find('input')

    await input.trigger('focus')
    await input.setValue('林')
    await wrapper.setProps({ modelValue: '林' })
    const options = wrapper.findAll('[role="option"]')
    expect(options).toHaveLength(2)

    await options[0]!.trigger('pointerdown')
    const updatedValues = wrapper.emitted('update:modelValue') ?? []
    expect(updatedValues[updatedValues.length - 1]).toEqual(['林晨 · 行业解决方案'])

    await wrapper.setProps({ modelValue: '林' })
    await input.trigger('focus')
    await input.trigger('keydown', { key: 'ArrowDown' })
    await input.trigger('keydown', { key: 'Enter' })
    const selections = wrapper.emitted('select') ?? []
    expect(selections[selections.length - 1]).toEqual([candidates[0]])
  })
})
