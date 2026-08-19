# dev-start.ps1
# One-click local dev: SSH tunnel + Spring Boot + Vite, each in its own window.
# Run from repo root:
#   powershell -ExecutionPolicy Bypass -File .\dev-start.ps1
# Or, if execution policy allows it locally:
#   .\dev-start.ps1
#
# Stop everything: Ctrl+C in each spawned window. The SSH tunnel survives
# until the machine reboots or you kill it via:
#   Get-Process ssh | Where-Object { $_.CommandLine -like '*-L 5432:*' } | Stop-Process

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "=== Daily Report System — local dev starter ===" -ForegroundColor Cyan
Write-Host "Repo root: $repoRoot"
Write-Host ""

# --- 0. SSH tunnel to cloud PostgreSQL (local 5432 -> server 5432) ---
$cloudHost = '36.213.175.224'
$pgPort    = 5432
Write-Host "[0/3] Checking SSH tunnel to $cloudHost for PostgreSQL..." -ForegroundColor Yellow
$alreadyBound = Get-NetTCPConnection -LocalPort $pgPort -State Listen -ErrorAction SilentlyContinue
if ($alreadyBound) {
    Write-Host "  port $pgPort already bound — tunnel appears active." -ForegroundColor DarkGray
} else {
    Write-Host "  starting ssh -N -L ${pgPort}:127.0.0.1:${pgPort} $cloudHost via Start-Process ..."
    # Use Start-Process instead of `ssh -f -N` — the -f flag is unreliable on
    # Windows Git Bash (the foreground ssh often never returns even though the
    # tunnel is up). -WindowStyle Hidden keeps the ssh window out of the way.
    $errLog = Join-Path $env:TEMP ("ssh-tunnel-" + $pgPort + ".err")
    $outLog = Join-Path $env:TEMP ("ssh-tunnel-" + $pgPort + ".out")
    $sshArgs = @(
        '-N',
        '-o', 'BatchMode=yes',
        '-o', 'ConnectTimeout=10',
        '-o', 'ServerAliveInterval=30',
        '-o', 'ServerAliveCountMax=3',
        '-o', 'ExitOnForwardFailure=yes',
        '-L', "${pgPort}:127.0.0.1:${pgPort}",
        "root@$cloudHost"
    )
    $proc = Start-Process -FilePath 'ssh.exe' -ArgumentList $sshArgs `
        -WindowStyle Hidden -PassThru `
        -RedirectStandardOutput $outLog -RedirectStandardError $errLog
    # Wait up to 8s for the listener to bind (SSH auth + port allocation)
    $bound = $false
    for ($i = 0; $i -lt 16; $i++) {
        Start-Sleep -Milliseconds 500
        if (Get-NetTCPConnection -LocalPort $pgPort -State Listen -ErrorAction SilentlyContinue) {
            $bound = $true; break
        }
    }
    if ($bound) {
        $pidList = (Get-NetTCPConnection -LocalPort $pgPort -State Listen).OwningProcess | Sort-Object -Unique
        Write-Host "  tunnel up (ssh PID $($pidList -join ', '))" -ForegroundColor Green
    } else {
        Write-Host "  ERROR: tunnel did not bind within 8s. Check $errLog" -ForegroundColor Red
        if (Test-Path $errLog) { Get-Content $errLog -Tail 5 }
    }
}

# --- 1. backend (Spring Boot) ---
Write-Host "[1/3] Starting Spring Boot (daily-api) on :8080..." -ForegroundColor Yellow
# Force JAVA_HOME to JDK 21 — AnalysisRunStore uses List.getFirst() which is
# Java 21-only (SequencedCollection). JDK 17 cannot compile this project.
$jdk21 = 'D:\Program Files\Java\jdk-21'
$javaHomeClause = if (Test-Path $jdk21) { "`$env:JAVA_HOME='$jdk21'; `$env:PATH='$jdk21\bin;' + `$env:PATH; " } else { '' }
$localLogDirectory = Join-Path $repoRoot 'daily-api\logs'
New-Item -ItemType Directory -Path $localLogDirectory -Force | Out-Null
$backendCmd = "${javaHomeClause}`$env:SPRING_PROFILES_ACTIVE='local'; `$env:DAILY_LOG_DIRECTORY='$localLogDirectory'; Set-Location '$repoRoot\daily-api'; .\mvnw spring-boot:run"
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    $backendCmd
) | Out-Null

# --- 3. frontend (Vite) ---
Write-Host "[2/3] Starting Vite (daily-web) on :5180..." -ForegroundColor Yellow
$frontendCmd = "Set-Location '$repoRoot\daily-web'; npm run dev"
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    $frontendCmd
) | Out-Null

Write-Host ""
Write-Host "Three windows have been spawned." -ForegroundColor Green
Write-Host "  Backend window : mvn spring-boot:run  -> http://localhost:8080/actuator/health"
Write-Host "  Frontend window: npm run dev          -> http://localhost:5180"
Write-Host "  (PG tunnel    : ssh -L 5432 ...        -> localhost:5432)"
Write-Host ""
Write-Host "Wait until both report 'ready', then open the frontend URL." -ForegroundColor Cyan
Write-Host "Stop the windows with Ctrl+C. The SSH tunnel survives until reboot." -ForegroundColor DarkGray
