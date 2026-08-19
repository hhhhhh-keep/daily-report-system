import { flushPromises, shallowMount } from '@vue/test-utils'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import AdminEntryView from '@/views/admin/AdminEntryView.vue'

const { api, router, setMarker } = vi.hoisted(() => ({
  api: { session: vi.fn(), login: vi.fn() },
  router: { replace: vi.fn(), push: vi.fn() },
  setMarker: vi.fn(),
}))

vi.mock('@/api/admin', () => ({ adminApi: api }))
vi.mock('vue-router', () => ({
  RouterLink: { template: '<a><slot /></a>' },
  useRoute: () => ({ query: {} }),
  useRouter: () => router,
}))
vi.mock('@/router/guards', () => ({ setAdminSessionMarker: setMarker }))

describe('AdminEntryView', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    localStorage.clear()
  })

  it('restores an existing session instead of asking for the password again', async () => {
    api.session.mockResolvedValue({ data: { username: 'admin', authenticated: true } })
    shallowMount(AdminEntryView, { global: { stubs: { RouterLink: true } } })
    await flushPromises()

    expect(setMarker).toHaveBeenCalledWith(true)
    expect(router.replace).toHaveBeenCalledWith('/admin/dashboard')
  })

  it('shows the login form when no existing session is available', async () => {
    api.session.mockRejectedValue(new Error('not signed in'))
    const wrapper = shallowMount(AdminEntryView, { global: { stubs: { RouterLink: true } } })
    await flushPromises()

    expect(setMarker).toHaveBeenCalledWith(false)
    expect(wrapper.find('form').exists()).toBe(true)
    expect((wrapper.find('input[type="password"]').element as HTMLInputElement).value).toBe('')
  })

  it('uses standard fields so the browser can save and refill the administrator password', async () => {
    api.session.mockRejectedValue(new Error('not signed in'))
    const wrapper = shallowMount(AdminEntryView, { global: { stubs: { RouterLink: true } } })
    await flushPromises()

    expect(wrapper.find('form').attributes('autocomplete')).toBe('on')
    expect(wrapper.find('input[name="username"]').attributes('autocomplete')).toBe('username')
    expect(wrapper.find('input[name="password"]').attributes('autocomplete')).toBe('current-password')
    expect(wrapper.text()).toContain('记住密码并保持登录（30 天）')
  })

  it('refills credentials remembered on this browser', async () => {
    localStorage.setItem('daily-admin-remembered-credentials', JSON.stringify({
      username: 'admin', password: 'saved-password', expiresAt: Date.now() + 1000,
    }))
    api.session.mockRejectedValue(new Error('not signed in'))
    const wrapper = shallowMount(AdminEntryView, { global: { stubs: { RouterLink: true } } })
    await flushPromises()

    expect((wrapper.find('input[name="username"]').element as HTMLInputElement).value).toBe('admin')
    expect((wrapper.find('input[name="password"]').element as HTMLInputElement).value).toBe('saved-password')
    expect((wrapper.find('input[type="checkbox"]').element as HTMLInputElement).checked).toBe(true)
  })

  it('removes expired remembered credentials', async () => {
    localStorage.setItem('daily-admin-remembered-credentials', JSON.stringify({
      username: 'admin', password: 'expired-password', expiresAt: Date.now() - 1,
    }))
    api.session.mockRejectedValue(new Error('not signed in'))
    shallowMount(AdminEntryView, { global: { stubs: { RouterLink: true } } })
    await flushPromises()

    expect(localStorage.getItem('daily-admin-remembered-credentials')).toBeNull()
  })

  it('stores credentials only after a successful remembered login', async () => {
    api.session.mockRejectedValue(new Error('not signed in'))
    api.login.mockResolvedValue({ data: { authenticated: true } })
    const wrapper = shallowMount(AdminEntryView, { global: { stubs: { RouterLink: true } } })
    await flushPromises()

    await wrapper.find('input[name="password"]').setValue('saved-password')
    await wrapper.find('input[type="checkbox"]').setValue(true)
    await wrapper.find('form').trigger('submit')
    await flushPromises()

    expect(JSON.parse(localStorage.getItem('daily-admin-remembered-credentials') ?? '{}')).toMatchObject({
      username: 'admin', password: 'saved-password',
    })
  })
})
