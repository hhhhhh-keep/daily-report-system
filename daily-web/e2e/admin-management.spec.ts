import { expect, test } from '@playwright/test'

const adminPassword = process.env.E2E_ADMIN_PASSWORD || 'phase2-admin-password'

test('administrator maintains options and reads real report metrics', async ({ page }) => {
  const suffix = Date.now().toString()
  const employeeName = `管理端员工-${suffix}`
  const projectName = `管理端项目-${suffix}`

  await page.goto('/admin')
  await page.getByLabel('用户名').fill('admin')
  await page.getByLabel('密码').fill(adminPassword)
  await page.getByRole('button', { name: '登录管理后台' }).click()
  await expect(page).toHaveURL(/\/admin\/dashboard/)
  await expect(page.getByRole('heading', { name: '管理驾驶舱' })).toBeVisible()

  await page.getByRole('link', { name: '人员' }).click()
  await page.getByLabel('姓名').fill(employeeName)
  await page.getByLabel('团队').fill('端到端验证组')
  await page.getByLabel('岗位类型').fill('测试顾问')
  await page.getByRole('button', { name: '新增人员' }).click()
  await expect(page.getByRole('cell', { name: employeeName })).toBeVisible()

  await page.getByRole('link', { name: '项目 / 专项' }).click()
  await page.getByLabel('名称').fill(projectName)
  await page.getByLabel('项目编号').fill(`E2E-${suffix}`)
  await page.getByRole('button', { name: '新增项目 / 专项' }).click()
  await expect(page.getByRole('cell', { name: projectName })).toBeVisible()

  await page.goto('/report')
  const employeeValue = await page.getByLabel('姓名').locator('option')
    .filter({ hasText: employeeName }).getAttribute('value')
  expect(employeeValue).toBeTruthy()
  await page.getByLabel('姓名').selectOption(employeeValue!)
  await page.getByLabel('项目 / 专项').selectOption({ label: projectName })
  await page.getByLabel('工作进展与产出').fill('完成管理端真实闭环验证')
  await page.getByRole('button', { name: '提交今日日报' }).click()
  await expect(page.getByRole('status')).toContainText('日报已保存')

  await page.goto('/admin/reports')
  const reportRow = page.getByRole('row').filter({ hasText: employeeName })
  await expect(reportRow).toBeVisible()
  await reportRow.getByRole('button', { name: '查看任务' }).click()
  await expect(page.getByText('完成管理端真实闭环验证')).toBeVisible()

  await page.getByRole('link', { name: '驾驶舱' }).click()
  await expect(page.getByText('已提交日报')).toBeVisible()
  await expect(page.locator('.metric-grid article').filter({ hasText: '工作任务' }).locator('strong'))
    .not.toHaveText('0')

  await page.getByRole('link', { name: '分析配置' }).click()
  await expect(page.getByRole('heading', { name: '分析与分发配置' })).toBeVisible()
  await page.getByRole('button', { name: '保存全部业务配置' }).click()
  await expect(page.getByRole('status')).toContainText('已保存并重新调度')

  await page.getByRole('link', { name: '分析中心' }).click()
  await page.getByRole('button', { name: '立即运行今日分析' }).click()
  await expect(page.getByRole('status')).toContainText('succeeded')
  await expect(page.locator('.analysis-grid article').first()).toBeVisible()

  await page.getByRole('link', { name: '任务记录' }).click()
  await expect(page.getByRole('cell', { name: 'manual' }).first()).toBeVisible()
  await expect(page.getByRole('link', { name: 'PDF' }).first()).toBeVisible()
})
