@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

set MF=MANIFEST
set PATH=%SYSTEMROOT%\system32

for /F "tokens=2* usebackq" %%i in (`findstr.exe /l /c:"%%BUILDOZER_RLOCATIONPATH%% " "%MF%"`) do (
  set BUILDOZER=%%i
  set BUILDOZER=!BUILDOZER:/=\!
)
if "!BUILDOZER!" equ "" (
  echo>&2 ERROR: %%BUILDOZER_RLOCATIONPATH%% not found in runfiles.
  exit /b 1
)

cd %BUILD_WORKSPACE_DIRECTORY%
!BUILDOZER! %*
if %ERRORLEVEL% neq 0 (
  exit /b %ERRORLEVEL%
)
