@echo off
setlocal enabledelayedexpansion

set caminho_backup=C:\mongobackup
set caminho_mongo_tool=C:\Program Files\MongoDB\Tools\100\bin
set nome_arquivo=backup-25-07-2024

if not exist "%caminho_backup%" (
    mkdir "%caminho_backup%"
)

cd /d "%caminho_backup%"

"%caminho_mongo_tool%\mongorestore" --gzip --archive=%nome_arquivo%.archive

if %errorlevel% neq 0 (
    echo MongoDB backup falhou. abortando script.
    pause
    exit /b 1
)

endlocal
