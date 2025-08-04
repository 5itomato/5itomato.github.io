# 简单一键部署脚本
$env:BUN_LINK_PKG = "true"
bun run build
cd dist
git init
git add .
git commit -m "Deploy $(Get-Date -Format 'yyyy-MM-dd')"
git branch -M gh-pages
git remote add origin https://github.com/5itomato/5itomato.github.io.git
git push -f origin gh-pages
cd ..
