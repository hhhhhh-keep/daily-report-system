# 正式分析使用 Skill Word 文档设计

## 目标

正式分析、任务记录下载和邮件附件使用同一份由已发布 Skill 模板生成的 Word 文档。

## 决策

1. 正式运行直接使用 `SkillExecution.renderedDocument`；它必须是非空 Word 文档。
2. `analysis_runs` 使用既有二进制报告列保存文档字节，并新增 MIME 类型；文件名和 MIME 类型共同说明该内容为 Word，而不是 PDF。
3. 新增通用下载地址 `/api/admin/runs/{id}/report`，按已保存 MIME 类型返回文件；前端的分析中心和运行记录改用该地址。
4. 邮件附件使用同一份已保存的 Word 字节与文件名，不生成 PDF。
5. Skill 没有返回 Word 时，正式运行失败且不发送邮件；不会降级为 PDF。

## 边界

历史运行仍可通过原 PDF 地址下载。试运行的 Word 下载接口保持不变。

## 验收

- 正式运行的下载响应为 DOCX MIME 类型，文件名以 `.docx` 结尾。
- 邮件网关接收的附件字节、文件名和 MIME 类型与正式运行保存的一致。
- 缺失 `renderedDocument` 的正式运行状态为失败，邮件服务不被调用。
