# AI 软件交付助手插件包

本目录维护一套跨 ChatGPT 与 Claude 的项目级 AI 软件交付助手插件源文件。

## 设计原则

- 一套共享 Skills，两套平台适配入口，避免 ChatGPT 与 Claude 各自维护不同业务规则。
- 以仓库根目录 `AGENTS.md`、`CLAUDE.md` 和 `docs/` 为事实来源；本目录只封装工作流，不复制整套项目规范。
- Skills 负责流程和任务方法；GitHub、文件、终端等工具仍由宿主平台的连接和权限提供。
- 默认只读分析；只有用户明确要求时才修改文件、提交、合并或发布。
- 不将“生成代码”表述为“构建/测试/生产验证通过”。

## 目录结构

```text
integrations/ai-software-delivery-assistant/
├── README.md
├── plugin.json                         # ChatGPT 插件源清单
├── .claude-plugin/plugin.json          # Claude Code 插件清单
├── agents/openai.yaml                  # ChatGPT Agent 指令入口
├── adapters/
│   ├── chatgpt/README.md
│   └── claude/README.md
└── skills/
    ├── workbench-orchestrator/SKILL.md
    ├── requirement-architecture/SKILL.md
    ├── implementation/SKILL.md
    ├── review-testing/SKILL.md
    └── delivery-governance/SKILL.md
```

## Skills

| Skill | 职责 |
|---|---|
| workbench-orchestrator | 意图识别、任务分级、主辅角色编排、阶段控制 |
| requirement-architecture | 需求澄清、验收标准、方案与架构设计 |
| implementation | 读取真实源码、最小差异实现、保持业务语义 |
| review-testing | 独立审查、缺陷分级、测试设计与验证 |
| delivery-governance | Git 交付、变更记录、风险、回滚和最终汇报 |

## 平台使用

- ChatGPT：通过 Plugin Creator 将本目录作为插件源导入/更新；读取 `adapters/chatgpt/README.md`。
- Claude Code：将本目录作为 Claude Code Plugin 安装；读取 `adapters/claude/README.md`。
- Claude 网页端：可将单个 Skill 目录按 Claude Skills 的导入要求打包；每个 Skill ZIP 只包含一个对应的 `SKILL.md`，不要把多个 Skill ZIP 再嵌套进一个 ZIP。

## 版本与事实边界

- 插件源版本：1.0.0。
- 本目录是可维护的源文件，不代表已自动发布到 ChatGPT 或 Claude 账户。
- 模型平台的插件导入、启用和工具授权需要在对应平台完成。
- 执行任务时必须重新读取目标仓库分支的最新源码和文档，不能仅依赖本插件中的说明。
