# ChatGPT 适配说明

## 文件组成

- 上级目录 `plugin.json`：跨平台插件源清单。
- 上级目录 `agents/openai.yaml`：ChatGPT Agent 指令与默认策略。
- 上级目录 `skills/*/SKILL.md`：共享技能定义。

## 导入方式

1. 从仓库下载 `integrations/ai-software-delivery-assistant/` 目录。
2. 按当前 ChatGPT Plugin Creator 支持的插件 ZIP 结构打包；保留 `plugin.json`、`agents/` 和 `skills/`。
3. 在 Plugin Creator 中创建或更新插件，并检查每个 Skill 的描述和触发条件。
4. 在 ChatGPT 对话中启用插件后，确认 GitHub、文件等工具连接已经授权。
5. 用只读任务验证项目规范读取，再用无副作用的测试任务验证 Skills 路由。

## 运行边界

插件包不包含 GitHub Token，也不会自行获得仓库访问权限。ChatGPT 能否读取或修改仓库，取决于当前会话中已连接的 GitHub 工具及其授权范围。写操作仍需用户明确指令。
