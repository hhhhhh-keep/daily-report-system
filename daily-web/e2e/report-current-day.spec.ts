import { expect, test } from '@playwright/test'

const employeeName = process.env.E2E_EMPLOYEE_NAME || '端到端员工'
const projectName = process.env.E2E_PROJECT_NAME || '端到端项目'

test('creates a multi-task report and reopens it for full replacement', async ({ page }) => {
  await page.goto('/report')
  const employeeValue = await page.getByLabel('姓名').locator('option').filter({ hasText: employeeName })
    .getAttribute('value')
  expect(employeeValue).toBeTruthy()
  await page.getByLabel('姓名').selectOption(employeeValue!)
  await page.getByLabel('项目 / 专项').selectOption({ label: projectName })
  await page.getByLabel('工作进展与产出').fill('完成核心日报接口与数据库流程')

  await page.getByRole('button', { name: '+ 新增工作任务' }).click()
  const secondTask = page.getByRole('group', { name: '工作任务 2' })
  await secondTask.getByLabel('时段').selectOption('afternoon')
  await secondTask.getByLabel('项目 / 专项').selectOption({ label: projectName })
  await secondTask.getByLabel('工作进展与产出').fill('完成前后端联调')
  await page.getByRole('button', { name: '提交今日日报' }).click()
  await expect(page.getByRole('status')).toContainText('日报已保存')

  await page.goto('/my-report')
  await page.getByLabel('姓名').selectOption(employeeValue!)
  await page.getByRole('button', { name: '读取今日日报' }).click()
  await expect(page.getByRole('group', { name: '工作任务 2' })).toBeVisible()
  await page.getByRole('group', { name: '工作任务 1' }).getByLabel('工作进展与产出')
    .fill('完成核心日报接口、数据库流程和修改验证')
  await page.getByRole('group', { name: '工作任务 2' }).getByRole('button', { name: '删除任务' }).click()
  await page.getByRole('button', { name: '保存修改' }).click()
  await expect(page.getByRole('status')).toContainText('日报已保存')
  await expect(page.getByText('1 项任务')).toBeVisible()
})
