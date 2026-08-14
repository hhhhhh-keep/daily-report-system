import type { Router } from 'vue-router'
import { adminApi } from '@/api/admin'

const ADMIN_SESSION_KEY = 'daily-admin-authenticated'

export function installRouteGuards(router: Router): void {
  router.beforeEach(async (to) => {
    if (!to.meta.requiresAdmin) {
      return true
    }

    const authenticated =
      typeof sessionStorage !== 'undefined' && sessionStorage.getItem(ADMIN_SESSION_KEY) === 'true'

    if (authenticated) return true
    try {
      await adminApi.session()
      setAdminSessionMarker(true)
      return true
    } catch {
      return { name: 'admin', query: { redirect: to.fullPath } }
    }
  })
}

export function setAdminSessionMarker(authenticated: boolean): void {
  if (authenticated) {
    sessionStorage.setItem(ADMIN_SESSION_KEY, 'true')
  } else {
    sessionStorage.removeItem(ADMIN_SESSION_KEY)
  }
}
