@echo off
setlocal enabledelayedexpansion
color 0A
cd /d "%~dp0"

:main_menu
cls
echo =============================================
echo                IPTV�������ɹ���
echo                            By Aghu
echo =============================================
echo 1 - �����ƶ�   2 - ������ͨ   3 - ���ڵ���
echo 4 - �����ƶ�   5 - �����ƶ�����
echo 0 - �˳�����
echo =============================================

set "input="
set /p "input=��������Ӫ�̱�� (0-5): "
echo %input%|findstr /r "^[0-5]$" >nul || goto input_error

if "%input%"=="0" exit /b

rem ����Ŀ��Ŀ¼��
if %input% equ 1 set "target_dir=0755cm"
if %input% equ 2 set "target_dir=0755cu"
if %input% equ 3 set "target_dir=0755ct"
if %input% equ 4 set "target_dir=0728cm"
if %input% equ 5 set "target_dir=0728cmlite"

rem ������Ŀ¼
if not exist "%target_dir%" md "%target_dir%"

rem ���ƿ�ִ���ļ�
copy "IPTV-API.exe" "%target_dir%\" >nul

rem ������Ŀ¼
if not exist "%target_dir%\config" md "%target_dir%\config"
if not exist "%target_dir%\output" md "%target_dir%\output"

rem ɾ����demo�ļ�
del %target_dir%\config\demo.txt"

rem ����demo�ļ�
if %input% equ 5 (
    xcopy "config\demolite.txt" "%target_dir%\config\"  /d /y >nul
    ren %target_dir%\config\demolite.txt demo.txt
) else (
    xcopy "config\demofull.txt" "%target_dir%\config\" /d /y >nul
    ren %target_dir%\config\demofull.txt demo.txt
)

rem ���ƶ����ļ�
xcopy "config\subscribe.txt" "%target_dir%\config\" /d /y >nul

rem ���г���ɾ��
cd "%target_dir%"
start /wait IPTV-API.exe
del IPTV-API.exe >nul
cd ..

rem ɾ���ϴ�����ļ�
del "%target_dir%\output\%target_dir%.txt"
del "%target_dir%\output\%target_dir%.m3u"

rem ����������ļ�
if exist "%target_dir%\output\result.txt" (
    ren "%target_dir%\output\result.txt" "%target_dir%.txt"
)
if exist "%target_dir%\output\result.m3u" (
    ren "%target_dir%\output\result.m3u" "%target_dir%.m3u"
)

timeout /t 3 >nul
exit

:input_error
echo �������������ѡ��
timeout /t 2 >nul
goto main_menu