#!/usr/bin/env python3
"""检查中文 AI 开发工作流工作台的必要文件与文本完整性。"""

from __future__ import annotations

import sys
from pathlib import Path

根目录 = Path(__file__).resolve().parents[1]
必要文件 = [
    Path("README.md"),
    Path("AGENTS.md"),
    Path("CLAUDE.md"),
    Path("CONTRIBUTING.md"),
    Path("SECURITY.md"),
    Path("config/模型路由.yml"),
    Path("docs/00-落地总览.md"),
    Path("docs/01-创建并初始化GitHub仓库.md"),
    Path("docs/02-模型分工与额度.md"),
    Path("docs/03-标准开发闭环.md"),
    Path("docs/05-独立代码审查.md"),
    Path("docs/06-测试与质量门禁.md"),
    Path("docs/07-发布与回滚.md"),
    Path("prompts/02-Codex执行任务.md"),
    Path("prompts/03-ChatGPT独立审查.md"),
    Path("prompts/04-Claude独立审查.md"),
    Path("templates/需求单.md"),
    Path("templates/AI执行任务单.md"),
    Path("templates/Review记录.md"),
    Path("templates/发布检查单.md"),
    Path(".github/pull_request_template.md"),
    Path(".github/ISSUE_TEMPLATE/功能需求.yml"),
    Path(".github/ISSUE_TEMPLATE/缺陷报告.yml"),
    Path(".github/workflows/质量门禁.yml"),
]


def 主程序() -> int:
    问题: list[str] = []
    for 相对路径 in 必要文件:
        文件路径 = 根目录 / 相对路径
        if not 文件路径.is_file():
            问题.append(f"缺少必要文件：{相对路径.as_posix()}")
            continue
        try:
            内容 = 文件路径.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            问题.append(f"文件不是有效的 UTF-8 文本：{相对路径.as_posix()}")
            continue
        if not 内容.strip():
            问题.append(f"文件内容为空：{相对路径.as_posix()}")
        if 内容 and not 内容.endswith("\n"):
            问题.append(f"文件末尾缺少换行符：{相对路径.as_posix()}")

    说明目录 = [根目录 / "docs", 根目录 / "prompts", 根目录 / "templates"]
    for 目录 in 说明目录:
        if not 目录.is_dir():
            问题.append(f"缺少目录：{目录.relative_to(根目录).as_posix()}")
            continue
        markdown文件 = list(目录.rglob("*.md"))
        if not markdown文件:
            问题.append(f"目录中没有 Markdown 文档：{目录.relative_to(根目录).as_posix()}")

    if 问题:
        print("工作台自检失败：")
        for 项目 in 问题:
            print(f"- {项目}")
        return 1

    print(f"工作台自检通过：已检查 {len(必要文件)} 个必要文件及 3 个文档目录。")
    print("注意：本脚本只检查工作台结构与文本完整性，不代表业务代码已编译或测试通过。")
    return 0


if __name__ == "__main__":
    sys.exit(主程序())
