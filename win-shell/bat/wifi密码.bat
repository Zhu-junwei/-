@echo off & setlocal EnableDelayedExpansion
title 查看所有wifi和密码
for /f "usebackq delims=:  tokens=1-2" %%a in (`netsh wlan show profiles ^| findstr "用户配置文件"`) do (
    for /f "usebackq delims=:  tokens=1-2" %%m in (`netsh wlan show profile name^=%%b key^=clear`) do (
        echo "%%m" | findstr "关键内容" >nul && echo 账号:【%%b】密码:【%%n】
    )
)

pause