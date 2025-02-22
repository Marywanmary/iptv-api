@echo off
setlocal enabledelayedexpansion
color 0A
cd /d "%~dp0"

:main_menu
cls
echo =============================================
echo                IPTV配置生成工具
echo                            By Aghu
echo =============================================
echo 1 - 深圳移动   2 - 深圳联通   3 - 深圳电信
echo 4 - 湖北移动   5 - 湖北移动精简
echo 0 - 退出程序
echo =============================================

set "input="
set /p "input=请输入运营商编号 (0-5): "
echo %input%|findstr /r "^[0-5]$" >nul || goto input_error

if "%input%"=="0" exit /b

rem 设置目标目录名
if %input% equ 1 set "target_dir=0755cm"
if %input% equ 2 set "target_dir=0755cu"
if %input% equ 3 set "target_dir=0755ct"
if %input% equ 4 set "target_dir=0728cm"
if %input% equ 5 set "target_dir=0728cmlite"

rem 创建主目录
if not exist "%target_dir%" md "%target_dir%"

rem 复制可执行文件
copy "IPTV-API.exe" "%target_dir%\" >nul

rem 创建子目录
if not exist "%target_dir%\config" md "%target_dir%\config"
if not exist "%target_dir%\output" md "%target_dir%\output"

rem 删除旧demo文件
del %target_dir%\config\demo.txt"

rem 复制demo文件
if %input% equ 5 (
    xcopy "config\demolite.txt" "%target_dir%\config\"  /d /y >nul
    ren %target_dir%\config\demolite.txt demo.txt
) else (
    xcopy "config\demofull.txt" "%target_dir%\config\" /d /y >nul
    ren %target_dir%\config\demofull.txt demo.txt
)

rem 复制订阅文件
xcopy "config\subscribe.txt" "%target_dir%\config\" /d /y >nul

rem 运行程序并删除
cd "%target_dir%"
start /wait IPTV-API.exe
del IPTV-API.exe >nul
cd ..

rem 删除上次输出文件
del "%target_dir%\output\%target_dir%.txt"
del "%target_dir%\output\%target_dir%.m3u"

rem 重命名输出文件
if exist "%target_dir%\output\result.txt" (
    ren "%target_dir%\output\result.txt" "%target_dir%.txt"
)
if exist "%target_dir%\output\result.m3u" (
    ren "%target_dir%\output\result.m3u" "%target_dir%.m3u"
)

timeout /t 3 >nul
exit

:input_error
echo 输入错误，请重新选择！
timeout /t 2 >nul
goto main_menu