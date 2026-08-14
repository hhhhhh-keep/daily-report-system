import { describe, expect, it } from 'vitest'
import { router } from '@/router'

describe('application routes', () => {
  it('exposes employee report and administrator entry routes', () => {
    const paths = router.getRoutes().map((route) => route.path)
    expect(paths).toContain('/report')
    expect(paths).toContain('/my-report')
    expect(paths).toContain('/admin')
    expect(paths).toContain('/admin/workday-calendar')
    expect(paths).toContain('/admin/run-schedule')
    expect(paths).toContain('/admin/skills')
  })

  it('marks administrator child routes as protected', () => {
    const routes = router.getRoutes()
    const protectedRoutes = routes.filter((route) => route.path.startsWith('/admin/'))
    expect(protectedRoutes.length).toBeGreaterThanOrEqual(6)
    expect(protectedRoutes.every((route) => route.meta.requiresAdmin === true)).toBe(true)
    expect(routes.find((route) => route.path === '/admin')?.meta.requiresAdmin).toBeUndefined()
  })
})
