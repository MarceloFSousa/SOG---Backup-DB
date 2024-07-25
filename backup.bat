@echo off
setlocal enabledelayedexpansion

set caminho_backup=C:\mongobackup
set caminho_mongo_tool=C:\Program Files\MongoDB\Tools\100\bin
set nome_arquivo=backup-%date:/=-%
set deletar_backups_antigos=false

if not exist "%caminho_backup%" (
    mkdir "%caminho_backup%"
)

cd /d "%caminho_backup%"

"%caminho_mongo_tool%\mongodump" --gzip --archive=%nome_arquivo%.archive

if %errorlevel% neq 0 (
    echo MongoDB backup falhou. abortando script.
    pause
    exit /b 1
)

if "%deletar_backups_antigos%" == "true" (
   set substring=%nome_arquivo%

    for /f "delims=" %%f in ('dir /b /a-d') do (
        if "%%~nf" neq "!substring!" (
            echo deletando arquivo: %%f
            del "%%f"
        )
    )
)

endlocal
