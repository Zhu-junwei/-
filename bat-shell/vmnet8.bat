@echo off
::��ȡ����ԱȨ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit cd /d "%~dp0"

:start
mode con cols=55 lines=10
title VMnet8��������
echo ************************************************
echo  1.����    2.����    3.����  4.�˳�
echo ************************************************
echo.
set /p option=���������ѡ��:
echo.
if "%option%"=="1" (
netsh interface set interface name="VMware Network Adapter VMnet8" admin=DISABLED
netsh interface set interface name="VMware Network Adapter VMnet8" admin=ENABLED
) 
if "%option%"=="2" netsh interface set interface name="VMware Network Adapter VMnet8" admin=DISABLED
if "%option%"=="3" netsh interface set interface name="VMware Network Adapter VMnet8" admin=ENABLED
if "%option%"=="4" goto byebye
:: �ȴ�3S�ص��˵�
timeout /t 3
cls
set option=null
goto start

:byebye
echo See you.
ping -n 2 127.0.0.1>nul
exit
pause