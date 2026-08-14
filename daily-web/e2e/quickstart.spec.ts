import { expect, test } from '@playwright/test'

const adminPassword = process.env.E2E_ADMIN_PASSWORD || 'phase2-admin-password'

test('runs the documented daily report analysis and report quickstart', async ({ page }) => {
  const suffix = Date.now().toString()
  const employeeName = `快速开始员工-${suffix}`
  const optionName = `快速开始专项-${suffix}`

  await page.goto('/admin')
  await page.getByLabel('用户名').fill('admin')
  await page.getByLabel('密码').fill(adminPassword)
  await page.getByRole('button', { name: '登录管理后台' }).click()

  await page.getByRole('link', { name: '人员' }).click()
  await page.getByLabel('姓名').fill(employeeName)
  await page.getByLabel('团队').fill('快速开始组')
  await page.getByLabel('岗位类型').fill('顾问')
  await page.getByRole('button', { name: '新增人员' }).click()
  await expect(page.getByRole('cell', { name: employeeName })).toBeVisible()

  await page.getByRole('link', { name: '项目 / 专项' }).click()
  await page.getByLabel('名称').fill(optionName)
  await page.getByLabel('正式项目').uncheck()
  await page.getByLabel('系统标识').fill(`quickstart-${suffix}`)
  await page.getByRole('button', { name: '新增项目 / 专项' }).click()
  await expect(page.getByRole('cell', { name: optionName })).toBeVisible()

  await page.goto('/report')
  const employeeValue = await page.getByLabel('姓名').locator('option')
    .filter({ hasText: employeeName }).getAttribute('value')
  expect(employeeValue).toBeTruthy()
  await page.getByLabel('姓名').selectOption(employeeValue!)
  await page.getByLabel('项目 / 专项').selectOption({ label: optionName })
  await page.getByLabel('工作进展与产出').fill('完成快速开始上午任务')
  await page.getByRole('button', { name: '+ 新增工作任务' }).click()
  const secondTask = page.getByRole('group', { name: '工作任务 2' })
  await secondTask.getByLabel('时段').selectOption('afternoon')
  await secondTask.getByLabel('项目 / 专项').selectOption({ label: optionName })
  await secondTask.getByLabel('工作进展与产出').fill('完成快速开始下午任务')
  await page.getByRole('button', { name: '提交今日日报' }).click()
  await expect(page.getByRole('status')).toContainText('日报已保存')

  await page.goto('/my-report')
  await page.getByLabel('姓名').selectOption(employeeValue!)
  await page.getByRole('button', { name: '读取今日日报' }).click()
  await expect(page.getByRole('group', { name: '工作任务 2' })).toBeVisible()
  await page.getByRole('group', { name: '工作任务 1' }).getByLabel('工作进展与产出')
    .fill('完成快速开始上午任务并复核')
  await page.getByRole('button', { name: '保存修改' }).click()
  await expect(page.getByRole('status')).toContainText('日报已保存')

  await page.goto('/admin/reports')
  const row = page.getByRole('row').filter({ hasText: employeeName })
  await expect(row).toContainText('2')
  await row.getByRole('button', { name: '查看任务' }).click()
  await expect(page.getByText('完成快速开始上午任务并复核')).toBeVisible()

  await page.getByRole('link', { name: '分析中心' }).click()
  await page.getByRole('button', { name: '立即运行今日分析' }).click()
  await expect(page.getByRole('status')).toContainText('succeeded')
  await page.getByRole('link', { name: '任务记录' }).click()
  await expect(page.getByRole('link', { name: 'PDF' }).first()).toBeVisible()
})
