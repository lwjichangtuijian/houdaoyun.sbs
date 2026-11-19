@echo off
chcp 65001 >nul
title 厚道云 IndexNow URL 提交工具

echo ==========================================================
echo 正在启动厚道云 IndexNow 提交脚本 (Windows 原生 PowerShell)...
echo ==========================================================

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0indexnow_submit.ps1"

echo.
echo 执行完成。按任意键退出...
pause >nul
