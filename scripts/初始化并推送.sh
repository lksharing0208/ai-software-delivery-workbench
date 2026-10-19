#!/usr/bin/env bash
set -euo pipefail

# 在新建的空 GitHub 仓库中初始化本地 Git 并推送 main 分支。
# 使用方法：bash scripts/初始化并推送.sh https://github.com/<用户名>/ai-software-delivery-workbench.git

远程地址="${1:-}"
if [[ -z "$远程地址" ]]; then
  echo "用法：bash scripts/初始化并推送.sh <空的 GitHub 仓库地址>"
  echo "请先在 GitHub 创建空仓库，不要初始化 README、许可证或 .gitignore。"
  exit 2
fi

项目根目录="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$项目根目录"

if ! command -v git >/dev/null 2>&1; then
  echo "错误：未找到 Git，请先安装 Git 并完成身份认证。" >&2
  exit 1
fi

if [[ ! -d .git ]]; then
  git init
fi

if 当前地址="$(git remote get-url origin 2>/dev/null)"; then
  if [[ "$当前地址" != "$远程地址" ]]; then
    echo "错误：origin 已指向其他地址：$当前地址" >&2
    echo "为避免误推送，本脚本不会自动覆盖 origin。请先确认仓库地址。" >&2
    exit 1
  fi
else
  git remote add origin "$远程地址"
fi

git add -A
if ! git diff --cached --quiet; then
  git commit -m "chore: 初始化中文 AI 开发工作流工作台"
else
  if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
    echo "错误：当前没有可提交的文件。" >&2
    exit 1
  fi
  echo "没有新的暂存变更，将推送现有提交。"
fi

git branch -M main
git push -u origin main

echo "初始化和推送完成。请在 GitHub 的 Actions 页面确认“质量门禁”通过。"
