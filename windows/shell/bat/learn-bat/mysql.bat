@echo off
::��ȡ����ԱȨ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit cd /d "%~dp0"

:start
mode con cols=55 lines=20
title mysqlС����
echo ************************************************
echo  1.����mysql    2.�ر�mysql    3.��¼    4.�˳�  
echo ************************************************
echo.
set /p option=���������ѡ��:
echo.
if "%option%"=="1" net start mysql
if "%option%"=="2" net stop mysql
if "%option%"=="3" (
mode con cols=80 lines=30
title mysql commond
mysql -uroot -p --prompt="\u@\h \d>"
)
if "%option%"=="4" goto byebye
:: �ȴ�5S�ص��˵�
timeout /t 5
cls
set option=null
goto start

:byebye
echo See you.
ping -n 2 127.0.0.1>nul
exit
pause