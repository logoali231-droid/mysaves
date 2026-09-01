@echo off
setlocal enabledelayedexpansion

:: ====================================================
:: CONFIGURAÇÃO DE DIRETÓRIOS (INSIRA SEU LINK DO REPO AQUI)
:: ====================================================
:: IMPORTANTE: Substitua o link abaixo pelo link do seu repositório real do GitHub
set "REPO_URL=https://github.com/logoali231-droid/mysaves"

set "PRISM_INSTANCES=C:\Users\mateo.somavilla.GRUPOMARISTA.000\AppData\Roaming\PrismLauncher\instances"
set "CENTRAL_GIT_DIR=C:\Users\mateo.somavilla.GRUPOMARISTA.000\AppData\Roaming\PrismLauncher\Central_Minecraft_Backup"

echo ====================================================
echo      SISTEMA MONOREPO CENTRALIZADO (FLUXO PULL)   
echo ====================================================
echo.

:: 1. Cria a pasta mestre do repositório local se ela não existir
if not exist "%CENTRAL_GIT_DIR%" mkdir "%CENTRAL_GIT_DIR%"

:: Entra na pasta central do Git
cd /d "%CENTRAL_GIT_DIR%"

:: 2. Inicializa ou atualiza o repositório mestre trazendo tudo do GitHub
if not exist ".git" (
    echo [INFO] Inicializando repositorio mestre local...
    git init
    git remote add origin %REPO_URL%.git
    git branch -M main
    echo [INFO] Baixando toda a arvore de saves da nuvem...
    git pull origin main
) else (
    echo [INFO] Sincronizando repositorio mestre com a nuvem...
    git fetch origin
    git pull origin main --rebase
)

:: 3. Coleta os dados do Modpack e do Mundo específico para restaurar
echo.
set /p "PACK_NAME=1. Digite o nome exato do Modpack (Ex: Cuboid Outpost): "
set /p "WORLD_NAME=2. Digite o nome exato da pasta do MUNDO que quer puxar: "

:: Limpa os nomes substituindo espaços por underlines para bater com a estrutura do Git
set "PACK_NAME_CLEAN=%PACK_NAME: =_%"
set "WORLD_NAME_CLEAN=%WORLD_NAME: =_%"

:: Define as rotas lógicas de destino e origem
set "TARGET_WORLD_DIR=%PRISM_INSTANCES%\%PACK_NAME%\minecraft\saves\%WORLD_NAME%"
set "SOURCE_FOLDER=%CENTRAL_GIT_DIR%\%PACK_NAME_CLEAN%\%WORLD_NAME_CLEAN%"

:: 4. Verifica se a pasta desse mundo realmente existe na nuvem local baixada
if not exist "%SOURCE_FOLDER%" (
    echo.
    echo [ERRO] O mundo "%WORLD_NAME%" nao foi encontrado na nuvem para o pack "%PACK_NAME%"!
    echo Verifique se digitou o nome correto ou se a pasta existe no GitHub.
    pause
    exit /b
)

:: ====================================================
:: PASSO 5: RESTAURAR O MUNDO DA NUVEM DIRETO PARA O PRISM
:: ====================================================
echo.
echo [INFO] Restaurando o save [%WORLD_NAME%] da nuvem para o Prism Launcher...

:: Se a pasta de saves do modpack não existir no Prism (caso seja uma instância zerada), cria ela
if not exist "%TARGET_WORLD_DIR%" mkdir "%TARGET_WORLD_DIR%"

:: Remove arquivos temporarios antigos de trava local se existirem para evitar conflitos
if exist "%TARGET_WORLD_DIR%\session.lock" del /q /f "%TARGET_WORLD_DIR%\session.lock" 2>nul

:: Copia cirurgicamente os arquivos do mundo puxado para dentro da pasta do jogo
xcopy "%SOURCE_FOLDER%\*" "%TARGET_WORLD_DIR%\" /E /H /Y /Q >nul

echo.
echo ====================================================
echo   SUCESSO! O MUNDO [%WORLD_NAME%] FOI ATUALIZADO NO PRISM.
echo   Pode abrir o jogo e carregar seu save agora!
echo ====================================================
timeout /t 5 >nul
exit /b
