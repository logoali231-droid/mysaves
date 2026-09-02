@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
cls

echo ===================================================
echo   SISTEMA MONOREPO CENTRALIZADO (PULL / RESTAURAR)
echo ===================================================
echo.

set "PRISM_PATH=C:\Users\mateo.somavilla\AppData\Roaming\PrismLauncher"
set "REPO_URL=https://github.com/logoali231-droid/mysaves"

:: Sincroniza o Git local com o remoto
echo [INFO] Atualizando repositorio local a partir do GitHub...
git pull origin main --rebase 2>nul || git pull origin main 2>nul || git pull
echo.

:: 1. Listar Modpacks do Repositório
echo Selecione o Modpack cadastrado no repositório:
echo.

set count=0
for /d %%D in ("%~dp0*") do (
    set "FOLDER_NAME=%%~nxD"
    if /i not "!FOLDER_NAME!"==".git" if not "!FOLDER_NAME:~0,1!"=="." (
        set /a count+=1
        set "pack[!count!]=!FOLDER_NAME!"
        echo   !count!. !FOLDER_NAME!
    )
)

if %count%==0 (
    echo [ERRO] Nenhum modpack encontrado na pasta do repositorio!
    pause
    exit /b
)

echo.
set /p PACK_CHOICE="Digite o NUMERO do Modpack: "
set "PACK=!pack[%PACK_CHOICE%]!"

if "!PACK!"=="" (
    echo [ERRO] Opção inválida!
    pause
    exit /b
)

:: 2. Listar Mundos do Modpack Selecionado
cls
echo Modpack selecionado: !PACK!
echo ---------------------------------------------------
echo Selecione o Mundo para restaurar:
echo.

set w_count=0
for /d %%W in ("%~dp0!PACK!\*") do (
    set "WORLD_NAME=%%~nxW"
    set /a w_count+=1
    set "world[!w_count!]=!WORLD_NAME!"
    echo   !w_count!. !WORLD_NAME!
)

if %w_count%==0 (
    echo [ERRO] Nenhum mundo encontrado dentro do modpack !PACK!!
    pause
    exit /b
)

echo.
set /p WORLD_CHOICE="Digite o NUMERO do Mundo: "
set "WORLD=!world[%WORLD_CHOICE%]!"

if "!WORLD!"=="" (
    echo [ERRO] Opção inválida!
    pause
    exit /b
)

:: 3. Executar Cópia para o Prism Launcher
cls
set "REPO_SOURCE=%~dp0!PACK!\!WORLD!"
set "WORLD_TARGET=%PRISM_PATH%\instances\!PACK!\minecraft\saves\!WORLD!"

echo [INFO] Copiando "!PACK! -> !WORLD!" para o Prism Launcher...
if not exist "!WORLD_TARGET!" mkdir "!WORLD_TARGET!"

robocopy "!REPO_SOURCE!" "!WORLD_TARGET!" /E /MIR /FFT /R:2 /W:2 /XJ /NDL /NFL

echo.
echo ===================================================
echo   Restauração concluída com sucesso!
echo ===================================================
pause