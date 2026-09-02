@echo off
setlocal enabledelayedexpansion
title Otimizador de RAM + Prism Launcher Dynamic

:: 1. Limpeza de RAM
echo Limpando RAM dos processos em segundo plano...
powershell -Command "$code = '[DllImport(\"kernel32.dll\")] public static extern bool SetProcessWorkingSetSize(IntPtr h, int min, int max);'; Add-Type -MemberDefinition $code -Name 'Win32' -Namespace 'Mem'; Get-Process | ForEach-Object { try { [Mem.Win32]::SetProcessWorkingSetSize($_.Handle, -1, -1) } catch {} }"

:: 2. Definir caminhos genericos via variaveis do Windows
set "PRISM_EXE=%LOCALAPPDATA%\Programs\PrismLauncher\prismlauncher.exe"
set "INSTANCES_DIR=%APPDATA%\PrismLauncher\instances"

if not exist "%PRISM_EXE%" (
    echo [ERRO] Executavel do Prism Launcher nao encontrado!
    pause
    exit /b
)

:: 3. Escanear pasta de instancias e montar menu automatico
echo.
echo ==========================================
echo       INSTANCIAS ENCONTRADAS NO PRISM
echo ==========================================

set count=0
for /d %%D in ("%INSTANCES_DIR%\*") do (
    set /a count+=1
    set "inst[!count!]=%%~nxD"
    echo  [!count!] %%~nxD
)

if %count%==0 (
    echo Nenhuma instancia encontrada. Abrindo Prism Launcher...
    start "" "%PRISM_EXE%"
    exit /b
)

echo.
echo  [0] Abrir apenas o Launcher (sem iniciar jogo)
echo ==========================================
echo.

set /p choice="Digite o numero do modpack que deseja jogar (ou pressione Enter para 0): "

if "%choice%"=="" set choice=0
if "%choice%"=="0" (
    start "" "%PRISM_EXE%"
    exit /b
)

if defined inst[%choice%] (
    set "SELECTED_INST=!inst[%choice%]!"
    echo.
    echo Iniciar: !SELECTED_INST!...
    start "" "%PRISM_EXE%" --launch "!SELECTED_INST!"
) else (
    echo Opcao invalida! Abrindo apenas o launcher...
    start "" "%PRISM_EXE%"
)