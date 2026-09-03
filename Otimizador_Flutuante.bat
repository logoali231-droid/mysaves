<# :
@echo off
start "" powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (Get-Content '%~f0' -Raw)"
exit /b
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Janela Flutuante Compacta V5.0
$form = New-Object System.Windows.Forms.Form
$form.Text = "Otimizador V5.0"
$form.Size = New-Object System.Drawing.Size(200, 54)
$form.StartPosition = "Manual"
$form.Location = New-Object System.Drawing.Point(80, 80)
$form.FormBorderStyle = "None"
$form.TopMost = $true
$form.ShowInTaskbar = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(15, 15, 15)

# Mover janela
$form.Add_MouseDown({
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        $form.Capture = $false
        $msg = [System.Windows.Forms.Message]::Create($form.Handle, 0xA1, 0x2, 0)
        $form.DefWndProc([ref]$msg)
    }
})

# Botoes
$btnToggle = New-Object System.Windows.Forms.Button
$btnToggle.Size = New-Object System.Drawing.Size(150, 38)
$btnToggle.Location = New-Object System.Drawing.Point(8, 8)
$btnToggle.Text = "OTIMIZADOR: LIGADO"
$btnToggle.FlatStyle = "Flat"
$btnToggle.FlatAppearance.BorderSize = 0
$btnToggle.BackColor = [System.Drawing.Color]::FromArgb(34, 139, 34)
$btnToggle.ForeColor = [System.Drawing.Color]::White
$btnToggle.Font = New-Object System.Drawing.Font("Segoe UI", 8.5, [System.Drawing.FontStyle]::Bold)

$btnClose = New-Object System.Windows.Forms.Button
$btnClose.Size = New-Object System.Drawing.Size(24, 24)
$btnClose.Location = New-Object System.Drawing.Point(167, 6)
$btnClose.Text = "X"
$btnClose.FlatStyle = "Flat"
$btnClose.FlatAppearance.BorderSize = 0
$btnClose.ForeColor = [System.Drawing.Color]::FromArgb(160, 160, 160)
$btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$btnClose.Add_Click({ $form.Close() })

$script:myPID = [System.Diagnostics.Process]::GetCurrentProcess().Id

# Rotina 1: RAM (Leve e Rapida)
$cleanRAM = {
    $processes = [System.Diagnostics.Process]::GetProcesses()
    foreach ($proc in $processes) {
        try {
            if ($proc.Id -ne $script:myPID -and $proc.SessionId -ne 0) {
                $proc.EmptyWorkingSet() | Out-Null
            }
        } catch {}
    }
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    try { [System.Diagnostics.Process]::GetCurrentProcess().EmptyWorkingSet() | Out-Null } catch {}
}

# Rotina 2: Disco/Cache (Lenta, Executada via Thread)
$cleanDisk = {
    $limitTime = (Get-Date).AddHours(-1)
    $cachePaths = @(
        "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*",
        "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache\*",
        "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*",
        "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache\*",
        "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*\cache2\*",
        "$env:TEMP\*",
        "$env:SystemRoot\Temp\*"
    )
    foreach ($path in $cachePaths) {
        try {
            Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue | 
            Where-Object { $_.LastWriteTime -lt $limitTime } | 
            Remove-Item -Force -ErrorAction SilentlyContinue
        } catch {}
    }
}

# Timers Independentes
$timerRAM = New-Object System.Windows.Forms.Timer
$timerRAM.Interval = 45000 # 45 segundos

$timerDisk = New-Object System.Windows.Forms.Timer
$timerDisk.Interval = 1800000 # 30 minutos

$script:isActive = $true

# Primeiro disparo ao abrir
& $cleanRAM
$runspace = [powershell]::Create().AddScript($cleanDisk)
$runspace.BeginInvoke() | Out-Null

# Loops
$timerRAM.Add_Tick({ if ($script:isActive) { & $cleanRAM } })
$timerDisk.Add_Tick({ 
    if ($script:isActive) { 
        $rs = [powershell]::Create().AddScript($cleanDisk)
        $rs.BeginInvoke() | Out-Null
    } 
})

$timerRAM.Start()
$timerDisk.Start()

# Toggle
$btnToggle.Add_Click({
    $script:isActive = -not $script:isActive
    if ($script:isActive) {
        $btnToggle.Text = "OTIMIZADOR: LIGADO"
        $btnToggle.BackColor = [System.Drawing.Color]::FromArgb(34, 139, 34)
        $timerRAM.Start()
        $timerDisk.Start()
        & $cleanRAM
    } else {
        $btnToggle.Text = "OTIMIZADOR: DESLIGADO"
        $btnToggle.BackColor = [System.Drawing.Color]::FromArgb(178, 34, 34)
        $timerRAM.Stop()
        $timerDisk.Stop()
    }
})

$form.Controls.Add($btnToggle)
$form.Controls.Add($btnClose)
[System.Windows.Forms.Application]::Run($form)
