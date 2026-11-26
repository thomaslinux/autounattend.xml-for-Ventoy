@echo off
setlocal
set /p "MODEL=Enter model name: "

if not defined MODEL (
    echo No model entered.
    pause
    exit /b 1
)

set "DRIVERS=%~dp0..\drivers"
set "DEST=%DRIVERS%\%MODEL%"
echo "%DEST%"

if not exist "%DEST%" mkdir "%DEST%"

dism /online /export-driver /destination:"%DEST%"
if errorlevel 1 (
    echo Driver export failed.
    pause
    exit /b 1
)

>"%DRIVERS%\install-drivers-%MODEL%.bat" echo pnputil /add-driver "%%~dp0%MODEL%\*.inf" /subdirs /install

explorer "%DRIVERS%"
pause
