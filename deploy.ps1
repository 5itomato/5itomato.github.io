# GitHub Pages 手动部署脚本
param(
    [switch]$Force
)

Write-Host "🚀 开始部署到 GitHub Pages..." -ForegroundColor Green

# 设置环境变量
$env:BUN_LINK_PKG = "true"

try {
    # 构建项目
    Write-Host "📦 正在构建项目..." -ForegroundColor Yellow
    $buildResult = & bun run build 2>&1
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ 构建失败!" -ForegroundColor Red
        Write-Host $buildResult
        exit 1
    }
    
    Write-Host "✅ 构建成功!" -ForegroundColor Green

    # 检查 dist 目录
    if (-not (Test-Path "dist")) {
        Write-Host "❌ dist 目录不存在!" -ForegroundColor Red
        exit 1
    }

    # 进入 dist 目录
    Push-Location "dist"
    
    # 初始化 git 并部署
    Write-Host "📤 正在部署到 gh-pages 分支..." -ForegroundColor Yellow
    
    git init
    git add -A
    git commit -m "Deploy to GitHub Pages - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git branch -M gh-pages
    
    # 添加远程仓库
    git remote add origin https://github.com/5itomato/5itomato.github.io.git 2>$null
    
    # 强制推送
    if ($Force) {
        git push -f origin gh-pages
    } else {
        git push origin gh-pages
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 部署成功!" -ForegroundColor Green
        Write-Host "🌐 访问地址: https://5itomato.github.io" -ForegroundColor Cyan
        Write-Host "⏰ 可能需要几分钟时间生效" -ForegroundColor Yellow
    } else {
        Write-Host "❌ 部署失败!" -ForegroundColor Red
    }
    
} catch {
    Write-Host "❌ 发生错误: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # 返回原目录
    Pop-Location
}

Write-Host "`n使用说明:" -ForegroundColor Cyan
Write-Host "  普通部署: .\deploy.ps1" -ForegroundColor White
Write-Host "  强制部署: .\deploy.ps1 -Force" -ForegroundColor White
