
@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

:: ===================================================
:: BACKUP DINAMICO DE MUNDOS - MYSAVES
:: Exporta somente o mundo selecionado.
:: Estrutura compativel com o pullGeral.bat.
:: ===================================================

set "REPO_DIR=%USERPROFILE%\mysaves"
set "REPO_URL=https://github.com/logoali231-droid/mysaves.git"

if not exist "%REPO_DIR%" mkdir "%REPO_DIR%"
cd /d "%REPO_DIR%" || goto :ERROR_REPO

:: Detectar a pasta de instancias do Prism Launcher
set "PRISM_DIR="

if exist "%APPDATA%\PrismLauncher\instances" (
    set "PRISM_DIR=%APPDATA%\PrismLauncher\instances"
)
if not defined PRISM_DIR if exist "%LOCALAPPDATA%\Programs\PrismLauncher\instances" (
    set "PRISM_DIR=%LOCALAPPDATA%\Programs\PrismLauncher\instances"
)
if not defined PRISM_DIR if exist "%LOCALAPPDATA%\PrismLauncher\instances" (
    set "PRISM_DIR=%LOCALAPPDATA%\PrismLauncher\instances"
)

echo ===================================================
echo       BACKUP DINAMICO DE MUNDOS - MYSAVES
echo ===================================================
echo.

if not defined PRISM_DIR (
    echo [ERRO] Pasta de instancias do Prism nao encontrada.
    goto :ERROR
)

echo [INFO] Prism: "%PRISM_DIR%"
echo [INFO] Repositorio: "%REPO_DIR%"
echo.

:: Selecionar instancia do Prism
set "count=0"
echo Selecione a INSTANCIA do Prism Launcher:
echo ---------------------------------------------------

for /f "delims=" %%D in ('dir "%PRISM_DIR%" /b /ad') do (
    set /a count+=1
    set "inst[!count!]=%%D"
    echo   !count! - %%D
)

echo ---------------------------------------------------

if !count! EQU 0 (
    echo [ERRO] Nenhuma instancia encontrada.
    goto :ERROR
)

set "choice="
set /p "choice=Numero da instancia: "
set "SELECTED_INST="

for /l %%N in (1,1,!count!) do (
    if "!choice!"=="%%N" set "SELECTED_INST=!inst[%%N]!"
)

if not defined SELECTED_INST (
    echo [ERRO] Opcao invalida.
    goto :ERROR
)

:: Localizar os mundos da instancia escolhida
set "SAVES_DIR=%PRISM_DIR%\%SELECTED_INST%\minecraft\saves"

if not exist "%SAVES_DIR%" (
    echo [ERRO] Pasta de mundos nao encontrada:
    echo "%SAVES_DIR%"
    goto :ERROR
)

set "wcount=0"
echo.
echo Mundos disponiveis em "%SELECTED_INST%":
echo ---------------------------------------------------

for /f "delims=" %%W in ('dir "%SAVES_DIR%" /b /ad') do (
    set /a wcount+=1
    set "world[!wcount!]=%%W"
    echo   !wcount! - %%W
)

echo ---------------------------------------------------

if !wcount! EQU 0 (
    echo [ERRO] Nenhum mundo encontrado.
    goto :ERROR
)

set "wchoice="
set /p "wchoice=Numero do mundo: "
set "SELECTED_WORLD="

for /l %%N in (1,1,!wcount!) do (
    if "!wchoice!"=="%%N" set "SELECTED_WORLD=!world[%%N]!"
)

if not defined SELECTED_WORLD (
    echo [ERRO] Opcao invalida.
    goto :ERROR
)

:: IMPORTANTE:
:: O mundo fica diretamente dentro da pasta da instancia
:: no repositorio, exatamente como o pullGeral espera.
set "WORLD_SOURCE=%SAVES_DIR%\%SELECTED_WORLD%"
set "DEST_DIR=%REPO_DIR%\%SELECTED_INST%\%SELECTED_WORLD%"

echo.
echo [INFO] Origem:
echo "%WORLD_SOURCE%"
echo.
echo [INFO] Destino:
echo "%DEST_DIR%"
echo.

:: Verificar a origem
if not exist "%WORLD_SOURCE%\level.dat" (
    echo [AVISO] level.dat nao encontrado na raiz do mundo.
    echo Confira se selecionou uma pasta de mundo valida.
    goto :ERROR
)

:: Sincronizar o repositorio antes da copia
if not exist "%REPO_DIR%\.git" (
    echo [ERRO] A pasta mysaves ainda nao e um repositorio Git.
    echo Clone o repositorio do GitHub para esse caminho primeiro:
    echo %REPO_URL%
    goto :ERROR
)

echo [INFO] Atualizando a base local com o GitHub...
git pull --rebase origin main

if errorlevel 1 (
    echo.
    echo [ERRO] Nao foi possivel sincronizar com o GitHub.
    echo Resolva o conflito Git antes de executar o backup novamente.
    goto :ERROR
)

:: Copiar SOMENTE o mundo selecionado
echo.
echo [INFO] Copiando somente o mundo selecionado...

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

robocopy "%WORLD_SOURCE%" "%DEST_DIR%" /E /MIR /FFT /R:2 /W:2 /XJ /XD "DIM-1\session.lock" /NDL /NFL /NJH /NJS

if errorlevel 8 (
    echo [ERRO] Falha durante a copia do mundo.
    goto :ERROR
)

:: Adicionar ao Git somente o caminho deste mundo.
:: Nao adiciona mods, config, options.txt ou outros saves.
git add -A -- "%SELECTED_INST%/%SELECTED_WORLD%"

if errorlevel 1 (
    echo [ERRO] Falha ao preparar os arquivos para o Git.
    goto :ERROR
)

:: Criar commit se houver mudancas preparadas
git diff --cached --quiet

if errorlevel 1 (
    git commit -m "Backup mundo: %SELECTED_INST% - %SELECTED_WORLD%"
    if errorlevel 1 goto :ERROR
) else (
    echo [INFO] Nenhuma alteracao nova neste mundo.
)

:: Enviar o backup para o GitHub
echo.
echo [INFO] Enviando backup para o GitHub...

git push origin main

if errorlevel 1 (
    echo [ERRO] O envio falhou. O commit local foi preservado.
    goto :ERROR
)

echo.
echo ===================================================
echo  BACKUP CONCLUIDO!
echo  Instancia: %SELECTED_INST%
echo  Mundo: %SELECTED_WORLD%
echo  Nenhum mod ou config foi exportado.
echo ===================================================
goto :END

:ERROR_REPO
echo [ERRO] Nao foi possivel acessar a pasta do repositorio.
goto :ERROR

:ERROR
echo.
pause
exit /b 1

:END
echo.
pause
exit /b 0
