@echo off & setlocal EnableDelayedExpansion
title �鿴����wifi������
for /f "usebackq delims=:  tokens=1-2" %%a in (`netsh wlan show profiles ^| findstr "�û������ļ�"`) do (
    for /f "usebackq delims=:  tokens=1-2" %%m in (`netsh wlan show profile name^=%%b key^=clear`) do (
        echo "%%m" | findstr "�ؼ�����" >nul && echo �˺�:��%%b������:��%%n��
    )
)

pause