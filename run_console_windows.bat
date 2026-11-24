@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title CASE ZERO - Windows Console
REM Prefer existing GCC in PATH; MSYS2 UCRT64 GCC is a fallback.
where gcc.exe >nul 2>&1
if errorlevel 1 (
    if exist "C:\msys64\ucrt64\bin\gcc.exe" (
        set "PATH=C:\msys64\ucrt64\bin;%PATH%"
    ) else (
        echo [ERROR] GCC compiler is not available.
        echo Install GCC using MSYS2 UCRT64, or add GCC to PATH.
        echo MSYS2: https://www.msys2.org/
        echo In UCRT64: pacman -S --needed mingw-w64-ucrt-x86_64-gcc
        pause
        exit /b 1
    )
)
REM Use a new EXE name on each launch to avoid locked-file Permission denied errors.
set "GAME_EXE=%TEMP%\case_zero_%RANDOM%_%RANDOM%.exe"
echo Compiling CASE ZERO in C...
gcc -std=c11 -O2 "case_zero.c" -o "%GAME_EXE%"
if errorlevel 1 (
    echo [ERROR] Game compilation failed. See the compiler error above.
    pause
    exit /b 1
)
echo Starting CASE ZERO console game...
echo.
"%GAME_EXE%"
set "GAME_EXIT=%ERRORLEVEL%"
if exist "%GAME_EXE%" del /q "%GAME_EXE%" >nul 2>&1
echo.
echo Game finished. Press any key to close this window.
pause >nul
exit /b %GAME_EXIT%
