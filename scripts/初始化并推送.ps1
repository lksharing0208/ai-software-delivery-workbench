param(
    [Parameter(Mandatory = $true, HelpMessage = "请输入刚创建的空 GitHub 仓库地址")]
    [string]$远程仓库地址
)

$ErrorActionPreference = "Stop"

# 在新建的空 GitHub 仓库中初始化本地 Git 并推送 main 分支。
# 使用方法：powershell -ExecutionPolicy Bypass -File .\scripts\初始化并推送.ps1 -远程仓库地址 "https://github.com/<用户名>/ai-software-delivery-workbench.git"

$项目根目录 = Split-Path -Parent $PSScriptRoot
Set-Location $项目根目录

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "未找到 Git，请先安装 Git 并完成身份认证。"
}

if (-not (Test-Path ".git")) {
    git init
    if ($LASTEXITCODE -ne 0) { throw "初始化 Git 仓库失败。" }
}

$现有地址 = git remote get-url origin 2>$null
$读取地址退出码 = $LASTEXITCODE
if ($读取地址退出码 -eq 0 -and $现有地址) {
    if ($现有地址.Trim() -ne $远程仓库地址.Trim()) {
        throw "origin 已指向其他地址：$现有地址。为避免误推送，本脚本不会自动覆盖。"
    }
} else {
    git remote add origin $远程仓库地址
    if ($LASTEXITCODE -ne 0) { throw "设置远程仓库地址失败。" }
}

git add -A
if ($LASTEXITCODE -ne 0) { throw "暂存文件失败。" }
git diff --cached --quiet
$存在暂存差异 = ($LASTEXITCODE -ne 0)
if ($存在暂存差异) {
    git commit -m "chore: 初始化中文 AI 开发工作流工作台"
    if ($LASTEXITCODE -ne 0) { throw "创建初始提交失败。" }
} else {
    git rev-parse --verify HEAD *> $null
    if ($LASTEXITCODE -ne 0) { throw "当前没有可提交的文件。" }
    Write-Host "没有新的暂存变更，将推送现有提交。"
}

git branch -M main
if ($LASTEXITCODE -ne 0) { throw "切换默认分支名称失败。" }
git push -u origin main
if ($LASTEXITCODE -ne 0) { throw "推送失败。请检查远程仓库是否为空、网络连接和 Git 身份认证。" }

Write-Host "初始化和推送完成。请在 GitHub 的 Actions 页面确认“质量门禁”通过。"
