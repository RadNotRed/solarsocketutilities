@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 

taskkill /f /im "solar tweaks.exe"
rmdir /s /q "%userprofile%\.lunarclient\solartweaks"
rmdir /s /q "%appdata%\solartweaks"
"C:\Program Files\Solar Tweaks\Uninstall Solar Tweaks.exe"
cd "%userprofile%\downloads" &&  powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Solar-Tweaks/Solar-Tweaks/releases/latest/download/Solar.Tweaks.Setup.4.0.2.exe', 'SolarSetup.exe')"
.\SolarSetup.exe
exit