@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
cls

echo ===================================================
echo   SISTEMA MONOREPO CENTRALIZADO (SAVE / BACKUP)
echo ===================================================
echo.

set "PRISM_PATH=C:\Users\mateo.somavilla\AppData\Roaming\PrismLauncher"
set "REPO_URL=https://github.com/logoali231-droid/mysaves"

echo [INFO] Baixando alteracoes da nuvem antes de salvar...
git pull origin main --rebase 2>nul || git pull
echo.

:: 1. Listar Modpacks do Prism Launcher
echo Selecione a instancia do Prism Launcher:
echo.

set count=0
for /d %%D in ("%PRISM_PATH%\instances\*") do (
    set "FOLDER_NAME=%%~nxD"
    set /a count+=1
    set "pack[!count!]=!FOLDER_NAME!"
    echo   !count!. !FOLDER_NAME!
)

if %count%==0 (
    echo [ERRO] Nenhuma instancia encontrada em %PRISM_PATH%\instances!
    pause
    exit /b
)

echo.
set /p PACK_CHOICE="Digite o NUMERO da Instancia: "
set "PACK=!pack[%PACK_CHOICE%]!"

if "!PACK!"=="" (
    echo [ERRO] Opção inválida!
    pause
    exit /b
)

:: 2. Listar Mundos da Instância
cls
echo Instancia selecionada: !PACK!
echo ---------------------------------------------------
echo Selecione o Mundo para fazer backup:
echo.

set w_count=0
for /d %%W in ("%PRISM_PATH%\instances\!PACK!\minecraft\saves\*") do (
    set "WORLD_NAME=%%~nxW"
    set /a w_count+=1
    set "world[!w_count!]=!WORLD_NAME!"
    echo   !w_count!. !WORLD_NAME!
)

if %w_count%==0 (
    echo [ERRO] Nenhum mundo encontrado nos saves da instancia !PACK!!
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

:: 3. Executar Cópia e Git Push
cls
set "WORLD_SOURCE=%PRISM_PATH%\instances\!PACK!\minecraft\saves\!WORLD!"
set "REPO_DEST=%~dp0!PACK!\!WORLD!"

echo [INFO] Sincronizando "!PACK! -> !WORLD!" no repositorio local...
if not exist "!REPO_DEST!" mkdir "!REPO_DEST!"

robocopy "!WORLD_SOURCE!" "!REPO_DEST!" /E /MIR /FFT /R:2 /W:2 /XJ /NDL /NFL

echo.
echo [INFO] Enviando dados para o GitHub (%REPO_URL%)...
git add .
git commit -m "Backup save: !PACK! - !WORLD! (%date% %time:~0,5%)"
git push origin main 2>nul || git push

echo.
echo ===================================================
echo   Backup concluído e enviado para o GitHub!
echo ===================================================
pause