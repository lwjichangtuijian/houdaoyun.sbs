# ==============================================================================
# 厚道云 (Houdaoyun) IndexNow 自动化提交脚本 (PowerShell 原生版)
# 针对 Windows 环境免 Python 依赖设计，调用系统自带 PowerShell 发送 API 请求
# ==============================================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$hostName = "houdaoyun.sbs"
$apiKey = "e8c7b6a5d4f3e2b1c0a9f8e7d6c5b4a3"
$keyLocation = "https://$hostName/$apiKey.txt"
$endpoint = "https://api.indexnow.org/indexnow"

# 全站 15 个核心收录 URL 列表
$urlList = @(
    "https://$hostName/",
    "https://$hostName/knowledge.html",
    "https://$hostName/article-1.html",
    "https://$hostName/article-2.html",
    "https://$hostName/article-3.html",
    "https://$hostName/article-4.html",
    "https://$hostName/article-5.html",
    "https://$hostName/article-6.html",
    "https://$hostName/article-7.html",
    "https://$hostName/article-8.html",
    "https://$hostName/article-9.html",
    "https://$hostName/about.html",
    "https://$hostName/terms.html",
    "https://$hostName/privacy.html",
    "https://$hostName/sitemap.html"
)

$payloadObj = @{
    host = $hostName
    key = $apiKey
    keyLocation = $keyLocation
    urlList = $urlList
}

$payloadJson = $payloadObj | ConvertTo-Json -Depth 4

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " 厚道云 (Houdaoyun) IndexNow URL 自动化推送工具" -ForegroundColor Cyan
Write-Host " 目标站点: $hostName" -ForegroundColor Yellow
Write-Host " 提交数量: $($urlList.Count) 个 URL" -ForegroundColor Yellow
Write-Host " API 密钥: $apiKey" -ForegroundColor Gray
Write-Host "==========================================================" -ForegroundColor Cyan

try {
    Write-Host "[*] 正在向 IndexNow API 发送推送请求..." -ForegroundColor White
    $response = Invoke-RestMethod -Uri $endpoint -Method Post -Body $payloadJson -ContentType "application/json; charset=utf-8" -ErrorAction Stop
    Write-Host "[SUCCESS] 推送请求发送成功！HTTP 状态码 200 (OK)" -ForegroundColor Green
    Write-Host "[+] 搜索引擎 (Bing / Yandex 等) 已接收 URL 索引队列。" -ForegroundColor Green
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -eq 200 -or $statusCode -eq 202) {
        Write-Host "[SUCCESS] 提交成功！HTTP 响应代码: $statusCode" -ForegroundColor Green
    } else {
        Write-Host "[NOTE] 请求返回状态: $statusCode ($($_.Exception.Message))" -ForegroundColor Yellow
        Write-Host "提示：若当前域名解析或网站尚未正式上线绑定，IndexNow 将在域名上线并可校验 keyLocation 后正式完成索引。" -ForegroundColor Gray
    }
}

Write-Host "==========================================================" -ForegroundColor Cyan
