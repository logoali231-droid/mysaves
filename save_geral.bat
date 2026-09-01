@echo off
chcp 65001 > nul
cls

echo ===================================================
echo   SISTEMA MONOREPO CENTRALIZADO (MUNDOS FILTRADOS)
echo ===================================================
echo.

:: Caminho absoluto fixado no perfil local de mateo.somavilla
set "PRISM_PATH=C:\Users\mateo.somavilla\AppData\Roaming\PrismLauncher"
set "REPO_URL=https://github.com/logoali231-droid/mysaves"

echo [INFO] Atualizando repositorio local a partir do GitHub...
git pull origin main --rebase 2>nul || git pull
echo.

set /p PACK="1. Digite o nome exato do Modpack (Ex: Cuboid Outpost): "
set /p WORLD="2. Digite o nome exato da pasta do SEU MUNDO: "

echo.

set "WORLD_SOURCE=%PRISM_PATH%\instances\%PACK%\minecraft\saves\%WORLD%"
set "REPO_DEST=%~dp0%PACK%\%WORLD%"

:: Verifica se a pasta do mundo existe no Prism Launcher
if not exist "%WORLD_SOURCE%" (
    echo [ERRO] O mundo "%WORLD%" não foi encontrado no Prism Launcher!
    echo Caminho procurado: "%WORLD_SOURCE%"
    echo.
    pause
    exit /b
)

echo [SUCESSO] Mundo localizado em: "%WORLD_SOURCE%"
echo [INFO] Sincronizando arquivos para a estrutura: "%PACK%\%WORLD%"...
echo.

:: Cria a pasta no repositório se não existir
if not exist "%REPO_DEST%" mkdir "%REPO_DEST%"

:: Copia os arquivos da pasta do save para a pasta do repositório
robocopy "%WORLD_SOURCE%" "%REPO_DEST%" /E /MIR /FFT /R:2 /W:2 /XJ /NDL /NFL

echo.
echo [INFO] Adicionando e enviando dados para o GitHub...
git add .
git commit -m "Backup save: %PACK% - %WORLD% (%date% %time:~0,5%)"
git push origin main 2>nul || git push

echo.
echo ===================================================
echo   Sincronização concluída com sucesso no repositório!
echo ===================================================
pause