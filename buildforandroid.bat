@echo off
setlocal enabledelayedexpansion

:: CONFIGURATION
set SRC_DIR=cspice\source
set INC_DIR=cspice\include
set BUILD_DIR=build\android_arm64
set OUT_DIR=output
set OUTPUT=%OUT_DIR%\libcspice_android_arm64.so

:: Set this to your Android NDK root path if not set globally
set "NDK=%ANDROID_NDK_ROOT%"
if "%NDK%"=="" (
    echo ERROR: ANDROID_NDK_ROOT is not set.
    exit /b 1
)

set COMPILER=%NDK%\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android21-clang

if not exist "%COMPILER%" (
    echo ERROR: NDK clang compiler not found at:
    echo %COMPILER%
    exit /b 1
)

echo Creating build folders...
mkdir "%BUILD_DIR%" 2>nul
mkdir "%OUT_DIR%" 2>nul

echo Compiling CSPICE source files...

for %%F in (%SRC_DIR%\*.c) do (
    set "FILENAME=%%~nxF"
    set "BASENAME=%%~nF"

    :: Skip files with main() or named close.c
    findstr /R /C:"^[ ]*\(int\|void\)[ ]*main[ ]*(" "%%F" >nul
    if !errorlevel! equ 0 (
        echo Skipping !FILENAME! (contains main())
        goto :continue
    )

    if /I "!FILENAME!"=="close.c" (
        echo Skipping !FILENAME! (platform-incompatible)
        goto :continue
    )

    echo Compiling !FILENAME!
    "%COMPILER%" -I%INC_DIR% -fPIC -c "%%F" -o "%BUILD_DIR%\!BASENAME!.o"

    :continue
)

echo Linking object files into shared library...
"%COMPILER%" -shared -o "%OUTPUT%" %BUILD_DIR%\*.o

echo.
echo ✅ DONE. Shared library created at: %OUTPUT%
pause
