# 中文 AI 软件开发工作流工作台

> 目标：从零搭建一条可执行、可审查、可测试、可发布、可回滚的 AI 辅助软件交付流程。
>
> 适用组合：ChatGPT、Claude、Gemini、Grok 网页端；Codex 桌面端 + DeepSeek；GitHub 统一管理源码、任务、审查和交付。
>
> 当前版本：`1.0.0` · 文档维护日期：2026-10-19

## 1. 这是什么项目

本仓库不是某个业务系统的源代码，而是一套可复制到业务仓库中的工作流模板。它将需求分析、任务拆分、AI 编码、独立 Review、测试、重构、发布、回滚、额度管理和复盘固化为明确的操作规程与配置文件。

**重要边界：** 网页模型通过 GitHub 连接读取仓库，不代表它们都能直接修改、提交或部署代码。网页端以分析和独立审查为主；本地代码变更由 Codex + DeepSeek 主执行。实际可用权限以每个平台当前账户和连接授权为准。

## 2. 开箱后能得到什么

- `AGENTS.md`：Codex 等代码代理使用的项目级统一开发规范。
- `CLAUDE.md`：Claude Code 的补充执行规范。
- `config/模型路由.yml`：模型职责、免费额度优先级和任务分配建议；这是人工路由策略，不会自动调用模型或扣减额度。
- `prompts/`：需求设计、桌面端执行、独立 Review、重构和故障排查的可复制中文提示词。
- `templates/`：需求单、AI 执行任务单、Review 记录和发布检查单。
- `.github/`：中文 Issue 表单、PR 模板与可运行的配置自检工作流。
- `scripts/初始化并推送.sh` / `scripts/初始化并推送.ps1`：确认新建空仓库地址后，一次执行本地初始化、提交和推送。
- `docs/`：从创建 GitHub 仓库到保护主分支、配置测试、发布与回滚的逐步手册。

## 3. 五条不可妥协的生产规则

1. **GitHub 是唯一正式代码源。** 本地开发使用功能分支，不在 `main` 上直接开发。
2. **一个工作区只允许一个主修改者。** 同一个工作目录内不让多个代码代理并行改同一批文件。
3. **先审查差异，再决定是否修复。** Review 模型必须指出文件、行号、触发条件、影响和验证方式；不能仅凭模型说“有问题”就重构。
4. **自动化验证先于合并与发布。** 至少执行编译/构建、自动化测试、静态检查和差异复核；关键业务还要有人工验收。
5. **生产操作默认需要人类批准。** AI 不得擅自删除数据、修改生产密钥、跳过门禁、强推主分支或直接发布。

## 4. 建议的模型分工

| 模型/工具 | 主职责 | 默认是否改业务代码 |
|---|---|---|
| Codex + DeepSeek 桌面端 | 本地编码、测试、修复、重构、构建和部署准备 | 是，唯一主执行者 |
| ChatGPT 网页端 | 需求澄清、架构方案、复杂故障分析、业务逻辑复核 | 否，输出建议和审查意见 |
| Claude 网页端 | 独立代码 Review、跨模块副作用、重构风险 | 否，输出审查意见 |
| Gemini 网页端 | 大范围代码理解、遗漏场景、测试补充 | 否，输出补充意见 |
| Grok 网页端 | 最新技术资料、依赖版本和外部信息核查 | 否，输出有来源的结论 |

具体流程和额度策略见 `docs/02-模型分工与额度.md`。

## 5. 从零开始（推荐顺序）

1. 阅读 `docs/00-落地总览.md`，理解流程和责任边界。
2. 按 `docs/01-创建并初始化GitHub仓库.md` 创建一个**新的私有空仓库**，运行对应系统的初始化脚本推送本目录。
3. 按 `docs/02-模型分工与额度.md` 配置模型职责，不必先购买新的 Claude 付费订阅。
4. 把 `AGENTS.md`、`CLAUDE.md` 和 `prompts/` 中对应内容放入业务仓库或需要时复制使用。
5. 按 `docs/03-标准开发闭环.md` 处理第一个小功能。
6. 按 `docs/05-独立代码审查.md` 完成第一次独立审查。
7. 按 `docs/06-测试与质量门禁.md` 和 `docs/07-发布与回滚.md` 配置业务项目的 CI 与上线门禁。
8. 按 `docs/11-网页端连接GitHub实操.md` 配置网页端连接，并验证真实读取权限。
9. 每周按 `docs/09-度量与复盘.md` 记录返工、缺陷和额度消耗，基于数据调整模型分工。

## 6. 仓库结构

```text
.
├── AGENTS.md
├── CLAUDE.md
├── CONTRIBUTING.md
├── SECURITY.md
├── config/模型路由.yml
├── docs/
├── prompts/
├── templates/
├── scripts/验证工作台.py
└── .github/
    ├── ISSUE_TEMPLATE/
    ├── pull_request_template.md
    └── workflows/质量门禁.yml
```

## 7. 质量门禁的适用范围

本仓库自带的 GitHub Actions 只验证**工作流模板本身**是否缺失关键文件、是否存在空文档等问题；它不会自动测试你的业务代码，也不会执行生产部署。将模板复制到 Java、Python、Node.js 或其他项目后，必须在 `.github/workflows/` 中按实际技术栈增加编译、测试、静态分析和制品构建步骤。参考 `docs/06-测试与质量门禁.md`。

## 8. 安全提醒

不要把 API 密钥、数据库密码、生产环境配置、真实用户数据、私钥或未经脱敏的日志提交到 GitHub 或发送给网页模型。生产凭据只存储在受控密钥管理设施或 GitHub Actions Secrets / Environments 中，并遵循最小权限原则。

## 9. 官方文档入口

- GitHub 创建仓库：<https://docs.github.com/en/get-started/start-your-journey/creating-a-repository-for-your-project-on-github>
- GitHub 分支保护：<https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches>
- GitHub Actions：<https://docs.github.com/en/actions>
- Codex 文档：<https://developers.openai.com/codex/>
- Claude Code 文档：<https://docs.anthropic.com/en/docs/claude-code/overview>

---

**交付原则：先让一条小功能完整通过闭环，再推广到整个仓库。** 不要一开始就把所有自动化、模型和部署权限全部打开。
