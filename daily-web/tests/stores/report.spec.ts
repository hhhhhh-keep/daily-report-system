import { beforeEach, describe, expect, it, vi } from 'vitest'
import { createPinia, setActivePinia } from 'pinia'
import { reportApi } from '@/api/report'
import { useReportStore } from '@/stores/report'

vi.mock('@/api/report', () => ({
  reportApi: {
    options: vi.fn(),
    saveCurrent: vi.fn(),
    current: vi.fn(),
  },
}))

describe('report store', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
    vi.clearAllMocks()
  })

  it('starts with one task and submits the complete dynamic task collection', async () => {
    vi.mocked(reportApi.saveCurrent).mockResolvedValue({ id: 9, tasks: [] } as never)
    const store = useReportStore()

    expect(store.form.tasks).toHaveLength(1)
    store.form.employeeId = 3
    store.form.attendance = 'present'
    store.form.tasks[0]!.projectId = 7
    store.form.tasks[0]!.progressResult = '完成核心流程'
    store.addTask()
    store.form.tasks[1]!.projectId = 8
    store.form.tasks[1]!.progressResult = '完成联调'

    await store.save()

    expect(reportApi.saveCurrent).toHaveBeenCalledWith(
      expect.objectContaining({ employeeId: 3, tasks: expect.arrayContaining([
        expect.objectContaining({ projectId: 7 }),
        expect.objectContaining({ projectId: 8 }),
      ]) }),
    )
  })

  it('clears the work stage when a task becomes special work', async () => {
    const store = useReportStore()
    Object.assign(store.form.tasks[0]!, {
      workType: 'special-work',
      workStage: 'implementation',
    } as never)

    store.clearStageForSpecialWork(store.form.tasks[0]!)

    expect(store.form.tasks[0]).toMatchObject({ workType: 'special-work', workStage: '' })
  })

  it('submits no work tasks when attendance is leave', async () => {
    vi.mocked(reportApi.saveCurrent).mockResolvedValue({ id: 9, tasks: [] } as never)
    const store = useReportStore()
    store.form.employeeId = 3
    store.form.attendance = 'leave'

    await store.save()

    expect(reportApi.saveCurrent).toHaveBeenCalledWith(expect.objectContaining({ tasks: [] }))
  })

  it('only submits afternoon tasks when attendance is morning leave', async () => {
    vi.mocked(reportApi.saveCurrent).mockResolvedValue({ id: 9, tasks: [] } as never)
    const store = useReportStore()
    store.form.employeeId = 3
    store.form.attendance = 'leave-morning'
    store.form.tasks[0]!.timePeriod = 'morning'

    await store.save()

    expect(reportApi.saveCurrent).toHaveBeenCalledWith(expect.objectContaining({
      tasks: [expect.objectContaining({ timePeriod: 'afternoon' })],
    }))
  })

  it('adds afternoon tasks when attendance is morning leave', () => {
    const store = useReportStore()
    store.form.attendance = 'leave-morning'

    store.addTask()

    expect(store.form.tasks.every((task) => task.timePeriod === 'afternoon')).toBe(true)
  })
})
