<# :
@echo off
start "" powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (Get-Content '%~f0' -Raw)"
exit /b
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Janela Flutuante Compacta V3.0
$form = New-Object System.Windows.Forms.Form
$form.Text = "Otimizador RAM 3.0"
$form.Size = New-Object System.Drawing.Size(185, 54)
$form.StartPosition = "Manual"
$form.Location = New-Object System.Drawing.Point(80, 80)
$form.FormBorderStyle = "None"
$form.TopMost = $true
$form.ShowInTaskbar = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(20, 20, 20)

# Mover janela clicando e arrastando o fundo
$form.Add_MouseDown({
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        $form.Capture = $false
        $msg = [System.Windows.Forms.Message]::Create($form.Handle, 0xA1, 0x2, 0)
        $form.DefWndProc([ref]$msg)
    }
})

# Botao Toggle ON / OFF
$btnToggle = New-Object System.Windows.Forms.Button
$btnToggle.Size = New-Object System.Drawing.Size(135, 38)
$btnToggle.Location = New-Object System.Drawing.Point(8, 8)
$btnToggle.Text = "RAM 3.0: LIGADO"
$btnToggle.FlatStyle = "Flat"
$btnToggle.FlatAppearance.BorderSize = 0
$btnToggle.BackColor = [System.Drawing.Color]::FromArgb(34, 139, 34)
$btnToggle.ForeColor = [System.Drawing.Color]::White
$btnToggle.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)

# Botao Fechar (X)
$btnClose = New-Object System.Windows.Forms.Button
$btnClose.Size = New-Object System.Drawing.Size(24, 24)
$btnClose.Location = New-Object System.Drawing.Point(152, 6)
$btnClose.Text = "X"
$btnClose.FlatStyle = "Flat"
$btnClose.FlatAppearance.BorderSize = 0
$btnClose.ForeColor = [System.Drawing.Color]::FromArgb(160, 160, 160)
$btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$btnClose.Add_Click({ $form.Close() })

# Otimizacao Direct-System (.NET puro para 0% lag)
$script:myPID = [System.Diagnostics.Process]::GetCurrentProcess().Id
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

# Timer em segundo plano (Ciclos de 45s)
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 45000
$script:isActive = $true

& $cleanRAM

$timer.Add_Tick({
    if ($script:isActive) {
        & $cleanRAM
    }
})
$timer.Start()

# Clique no Alternador
$btnToggle.Add_Click({
    $script:isActive = -not $script:isActive
    if ($script:isActive) {
        $btnToggle.Text = "RAM 3.0: LIGADO"
        $btnToggle.BackColor = [System.Drawing.Color]::FromArgb(34, 139, 34)
        $timer.Start()
        & $cleanRAM
    } else {
        $btnToggle.Text = "RAM 3.0: DESLIGADO"
        $btnToggle.BackColor = [System.Drawing.Color]::FromArgb(178, 34, 34)
        $timer.Stop()
    }
})

$form.Controls.Add($btnToggle)
$form.Controls.Add($btnClose)
[System.Windows.Forms.Application]::Run($form)