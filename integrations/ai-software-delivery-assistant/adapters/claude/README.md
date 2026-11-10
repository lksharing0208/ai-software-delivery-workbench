# Claude 适配说明

## Claude Code Plugin

本目录通过上级 `.claude-plugin/plugin.json` 声明插件，并复用上级 `skills/` 下的五个 Skill。

安装时将整个 `ai-software-delivery-assistant` 目录作为 Claude Code Plugin 源目录使用。不要只复制 manifest 而遗漏 `skills/`。

## Claude 网页端 Skills

如需导入 Claude 网页端的独立 Skills：

- 每个 Skill 单独打包一个 ZIP。
- ZIP 内必须只有该 Skill 的顶层目录及其唯一 `SKILL.md`（可包含该 Skill 自己需要的资源）。
- 不要把多个 ZIP 文件嵌套到总 ZIP。
- 不要把 5 个 `SKILL.md` 放在同一个单 Skill ZIP 根目录。

## 项目上下文

使用时同时提供或连接仓库中的 `AGENTS.md`、`CLAUDE.md`、`README.md` 和相关 `docs/`。Claude Code 应先读取 `AGENTS.md`，再应用本插件的流程 Skills。
