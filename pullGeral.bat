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
echo     RESTAURAÇÃO DINÂMICA DE MUNDOS - MYSAVES
echo ===================================================
echo.

if not defined PRISM_DIR (
    echo [ERRO] Pasta de instâncias do Prism Launcher não encontrada!
    pause
    exit /b
)

if not exist "%REPO_DIR%\.git" (
    echo [INFO] Baixando repositório do GitHub em %REPO_DIR%...
    git init
    git branch -m main
    git remote add origin %REPO_URL%
    git fetch origin main
    git reset --hard origin/main
) else (
    echo [INFO] Atualizando dados do GitHub...
    git fetch origin main
    git reset --hard origin/main
)

echo.
set icount=0
echo Selecione a PASTA DA INSTÂNCIA salva no repositório:
echo ---------------------------------------------------
for /f "delims=" %%D in ('dir "%REPO_DIR%" /b /ad') do (
    if /i not "%%D"==".git" (
        set /a icount+=1
        set "repo_inst[!icount!]=%%D"
        echo  !icount! - %%D
    )
)
echo ---------------------------------------------------

if !icount!==0 (
    echo [ERRO] Nenhuma pasta de instância encontrada no repositório.
    pause
    exit /b
)

set /p ichoice="Digite o número da instância no repositório: "
set "SELECTED_REPO_INST=!repo_inst[%ichoice%]!"

if "%SELECTED_REPO_INST%"=="" (
    echo [ERRO] Opção inválida.
    pause
    exit /b
)

set wcount=0
echo.
echo Selecione o MUNDO que deseja restaurar:
echo ---------------------------------------------------
for /f "delims=" %%W in ('dir "%REPO_DIR%\%SELECTED_REPO_INST%" /b /ad') do (
    set /a wcount+=1
    set "repo_world[!wcount!]=%%W"
    echo  !wcount! - %%W
)
echo ---------------------------------------------------

if !wcount!==0 (
    echo [ERRO] Nenhum mundo encontrado nesta pasta do repositório.
    pause
    exit /b
)

set /p wchoice="Digite o número do mundo: "
set "SELECTED_WORLD=!repo_world[%wchoice%]!"

if "%SELECTED_WORLD%"=="" (
    echo [ERRO] Opção inválida.
    pause
    exit /b
)

echo.
set pcount=0
echo Selecione a INSTÂNCIA DESTINO no Prism Launcher:
echo ---------------------------------------------------
for /f "delims=" %%P in ('dir "%PRISM_DIR%" /b /ad') do (
    set /a pcount+=1
    set "prism_inst[!pcount!]=%%P"
    echo  !pcount! - %%P
)
echo ---------------------------------------------------

if !pcount!==0 (
    echo [ERRO] Nenhuma instância encontrada no Prism Launcher.
    pause
    exit /b
)

set /p pchoice="Digite o número da instância destino: "
set "TARGET_PRISM_INST=!prism_inst[%pchoice%]!"

if "%TARGET_PRISM_INST%"=="" (
    echo [ERRO] Opção inválida.
    pause
    exit /b
)

set "SOURCE_DIR=%REPO_DIR%\%SELECTED_REPO_INST%\%SELECTED_WORLD%"
set "TARGET_DIR=%PRISM_DIR%\%TARGET_PRISM_INST%\minecraft\saves\%SELECTED_WORLD%"

echo.
echo [INFO] Origem (Git):     "%SOURCE_DIR%"
echo [INFO] Destino (Prism): "%TARGET_DIR%"
echo.

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

echo [INFO] Restaurando mundo no Prism Launcher...
robocopy "%SOURCE_DIR%" "%TARGET_DIR%" /E /MIR /FFT /R:2 /W:2 /XJ /NDL /NFL /NJH /NJS

echo.
echo ===================================================
echo   Mundo "%SELECTED_WORLD%" restaurado em "%TARGET_PRISM_INST%"!
echo ===================================================
pause
