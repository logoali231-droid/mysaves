@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: Definir pasta isolada do repositório (evita poluir a pasta Documentos)
set "REPO_DIR=%USERPROFILE%\mysaves"
set "REPO_URL=https://github.com/logoali231-droid/mysaves.git"

if not exist "%REPO_DIR%" mkdir "%REPO_DIR%"
cd /d "%REPO_DIR%"

:: Detecção automática do caminho do Prism Launcher
set "PRISM_DIR="
if exist "%APPDATA%\PrismLauncher\instances" set "PRISM_DIR=%APPDATA%\PrismLauncher\instances"
if not defined PRISM_DIR if exist "%LOCALAPPDATA%\Programs\PrismLauncher\instances" set "PRISM_DIR=%LOCALAPPDATA%\Programs\PrismLauncher\instances"
if not defined PRISM_DIR if exist "%LOCALAPPDATA%\PrismLauncher\instances" set "PRISM_DIR=%LOCALAPPDATA%\PrismLauncher\instances"

echo ===================================================
echo     BACKUP DINÂMICO DE MUNDOS - MYSAVES
echo ===================================================
echo.

if not defined PRISM_DIR (
    echo [ERRO] Pasta de instâncias do Prism Launcher não encontrada!
    pause
    exit /b
)

echo [INFO] Pasta do Prism: "%PRISM_DIR%"
echo [INFO] Pasta Repositório: "%REPO_DIR%"
echo.

set count=0
echo Selecione a INSTÂNCIA no Prism Launcher:
echo ---------------------------------------------------
for /f "delims=" %%D in ('dir "%PRISM_DIR%" /b /ad') do (
    set /a count+=1
    set "inst[!count!]=%%D"
    echo  !count! - %%D
)
echo ---------------------------------------------------

if !count!==0 (
    echo [ERRO] Nenhuma instância encontrada no Prism Launcher.
    pause
    exit /b
)

set /p choice="Digite o número da instância: "
set "SELECTED_INST=!inst[%choice%]!"

if "%SELECTED_INST%"=="" (
    echo [ERRO] Opção inválida.
    pause
    exit /b
)

set "SAVES_DIR=%PRISM_DIR%\%SELECTED_INST%\minecraft\saves"

if not exist "%SAVES_DIR%" (
    echo [ERRO] A pasta 'saves' ainda não existe em:
    echo %SAVES_DIR%
    echo Abra o mundo no jogo ao menos uma vez para criar a pasta.
    pause
    exit /b
)

set wcount=0
echo.
echo Selecione o MUNDO que deseja salvar:
echo ---------------------------------------------------
for /f "delims=" %%W in ('dir "%SAVES_DIR%" /b /ad') do (
    set /a wcount+=1
    set "world[!wcount!]=%%W"
    echo  !wcount! - %%W
)
echo ---------------------------------------------------

if !wcount!==0 (
    echo [ERRO] Nenhum mundo encontrado dentro da pasta 'saves'.
    pause
    exit /b
)

set /p wchoice="Digite o número do mundo: "
set "SELECTED_WORLD=!world[%wchoice%]!"

if "%SELECTED_WORLD%"=="" (
    echo [ERRO] Opção inválida.
    pause
    exit /b
)

set "WORLD_SOURCE=%SAVES_DIR%\%SELECTED_WORLD%"
set "DEST_DIR=%REPO_DIR%\%SELECTED_INST%\%SELECTED_WORLD%"

echo.
echo [INFO] Origem (Mundo): "%WORLD_SOURCE%"
echo [INFO] Destino (Git):   "%DEST_DIR%"
echo.

if not exist "%REPO_DIR%\.git" (
    echo [INFO] Inicializando repositório Git local...
    git init
    git branch -m main
    git remote add origin %REPO_URL%
    git fetch origin main
    git pull origin main --allow-unrelated-histories
) else (
    echo [INFO] Sincronizando com o GitHub...
    git pull origin main
)

echo.
echo [INFO] Copiando arquivos do mundo para a estrutura do repositório...
robocopy "%WORLD_SOURCE%" "%DEST_DIR%" /E /MIR /FFT /R:2 /W:2 /XJ /NDL /NFL /NJH /NJS

echo.
echo [INFO] Enviando alterações para o GitHub...
git add -A
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set MYDATE=%%c-%%b-%%a
for /f "tokens=1-2 delims=: " %%a in ("%time%") do set MYTIME=%%a:%%b
git commit -m "Backup save: %SELECTED_INST% - %SELECTED_WORLD% (%MYDATE% %MYTIME%)" || echo [INFO] Nenhuma alteração nova detectada.
git push origin main

echo.
echo ===================================================
echo   Backup do mundo "%SELECTED_WORLD%" concluído!
echo ===================================================
pause
