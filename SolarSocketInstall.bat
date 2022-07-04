IF NOT DEFINED MINIMIZED SET MINIMIZED=1 && START "" /MIN "%~dpnx0" %* && EXIT

SET TARGETPATH=%localappdata%\Programs\Python\Python310
IF NOT EXIST "%TARGETPATH%" GOTO :ERROR
%SYSTEMROOT%\EXPLORER /SELECT, "%TARGETPATH%"
GOTO :END

:ERROR
SET msgboxTitle=Python 3.10.X Not installed
SET msgboxBody=Please install python 10 from https://python.org
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"
exit
:END

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
cd %userprofile%\.lunarclient\solartweaks\
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/RadNotRed/solarsocketutilities/blob/main/autosocket.py', 'autosocket.py')"
python %userprofile%\.lunarclient\solartweaks\socketinstall.py
del socketinstall.py
exit