# 01｜创建并初始化 GitHub 仓库

## A. 先创建一个新的空仓库

1. 登录 GitHub，打开 <https://github.com/new>。
2. 仓库名称建议使用 `ai-software-delivery-workbench`。
3. 描述填写：`中文 AI 软件开发工作流：从需求、编码、独立 Review、测试到发布与回滚`。
4. 初始阶段建议选 **Private（私有）**，确认不含秘密信息后再决定是否公开。
5. 不要勾选初始化 README、`.gitignore` 或许可证，因为本交付包已经包含这些文件。
6. 创建后暂时不要添加其他文件，保留空仓库。

> 如果你已有明确的组织与仓库命名规则，按自己的命名规则调整；不要将这套模板直接推入一个存在业务代码的仓库。

## B. 将本地交付目录推送到新仓库

下载并解压本工作台 ZIP，进入解压后的 `ai-software-delivery-workbench` 目录。先确认当前目录中存在 `README.md`、`AGENTS.md` 和 `.github/workflows/质量门禁.yml`。

### macOS / Linux / Git Bash

```bash
git init
git add .
git commit -m "chore: 初始化中文 AI 开发工作流工作台"
git branch -M main
git remote add origin https://github.com/<你的GitHub用户名>/ai-software-delivery-workbench.git
git push -u origin main
```

### Windows PowerShell

```powershell
Set-Location .\ai-software-delivery-workbench
git init
git add .
git commit -m "chore: 初始化中文 AI 开发工作流工作台"
git branch -M main
git remote add origin https://github.com/<你的GitHub用户名>/ai-software-delivery-workbench.git
git push -u origin main
```

请将 `<你的GitHub用户名>` 替换成真实用户名或组织名。按 GitHub 提示完成身份认证；不要把访问令牌写进远程地址、脚本或仓库文件。若使用 SSH，请将 `origin` 地址改为你自己的 SSH 仓库地址。

### 使用初始化脚本（可选，减少手工步骤）

macOS / Linux / Git Bash：

```bash
bash scripts/初始化并推送.sh https://github.com/<你的GitHub用户名>/ai-software-delivery-workbench.git
```

Windows PowerShell：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\初始化并推送.ps1 -远程仓库地址 "https://github.com/<你的GitHub用户名>/ai-software-delivery-workbench.git"
```

脚本会检查 Git 是否可用、避免自动覆盖指向其他仓库的 `origin`、提交当前目录并推送 `main`。脚本不会替你创建 GitHub 远程仓库；请先在网页中创建空仓库。若远程仓库不是空的，推送被拒绝时应先人工检查历史，不要强推覆盖。

## C. 验证初始化

推送后在 GitHub 仓库主页确认：

- 默认分支为 `main`。
- `AGENTS.md`、`CLAUDE.md`、`docs/`、`prompts/`、`templates/` 和 `.github/` 均已出现。
- 打开 `Actions`，确认“质量门禁”工作流已运行并通过。
- 如果工作流失败，先查看失败步骤和日志，不要直接关闭门禁。

## D. 设置主分支保护

工作流首次通过以后，再去仓库 `Settings` 中配置分支规则或规则集，匹配 `main`：

- 要求通过 Pull Request 才能合并。
- 要求状态检查通过，选择工作流中的检查项 **配置自检**。
- 要求解决所有 PR 讨论后才能合并。
- 禁止强制推送和删除 `main`。
- 建议启用合并后自动删除功能分支。
- 团队项目建议至少 1 个审批；个人仓库不要强制要求自己批准自己的 PR，否则可能造成无法合并。

如果规则页面暂时找不到“配置自检”，先确认该工作流至少运行成功一次；然后重新打开规则配置选择状态检查。

## E. 配置 GitHub 访问权限

- 为 ChatGPT、Claude 或 Gemini 连接仓库时，只授权需要分析的仓库。
- 不要将组织所有仓库都开放给不需要它们的工具。
- 网页端的仓库读取、文件写入、提交与部署权限是不同能力；连接成功后仍需逐项确认实际可用功能。
- 本地 Codex + DeepSeek 使用本机工作区时，先确认本地 Git 远程地址是正确仓库。

## F. 创建第一个 Issue

1. 选择 `Issues` → `New issue` → `功能需求`。
2. 填写目标、现状、边界和验收条件。
3. 给任务编号或保留 Issue 编号，例如 `#12`。
4. 使用 `templates/AI执行任务单.md` 将 Issue 转成编码任务。
5. 建立 `feature/12-简短描述` 分支。

## G. 本地同步常用命令

```bash
# 查看当前分支和工作区
git status --short --branch

# 拉取主分支最新变更
git fetch origin
git switch main
git pull --ff-only origin main

# 基于最新主分支创建功能分支
git switch -c feature/12-short-description

# 修改后检查
git diff --check
git diff --stat
git diff
```

不要在还存在未提交用户改动时执行会覆盖工作区的清理命令。不要对 `main` 强推。
