param(
    [int]$ProcessId,
    [int]$Duration
)

if (-not $ProcessId -or -not $Duration) {
    Write-Host "Usage: .\Get-CPUUsage.ps1 -ProcessId <process_id> -Duration <duration_in_seconds>"
    exit
}

# Start monitoring the CPU usage
$typeperfCmd = "typeperf `\Process($ProcessId)\% Processor Time` -si 1 -sc $Duration"
Invoke-Expression $typeperfCmd | Out-File -FilePath "cpu_usage.csv"

Write-Host "CPU usage data has been saved to cpu_usage.csv"
