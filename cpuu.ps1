$logFile = "worm_cpu_usage_log.csv"
$interval = 5  # Interval in seconds
$totalDuration = 240  # Total duration in seconds (4 minutes)
$wormExecutablePath = "C:\Users\lazy\Downloads\collect27\Mantas.exe"  # Replace this with the actual path to your worm executable
$wormProcessName = "Mantas"  # Replace this with the name of the worm process, without extension

# Start the worm process
Start-Process -FilePath $wormExecutablePath

# Initialize log file with headers
"Timestamp,ProcessName,CPUUsage" | Out-File -FilePath $logFile

# Initialize timer
$endTime = (Get-Date).AddSeconds($totalDuration)

while ((Get-Date) -lt $endTime) {
    # Get the worm process
    $process = Get-Process -Name $wormProcessName -ErrorAction SilentlyContinue
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Log CPU usage if the process is running
    if ($process) {
        "$timestamp,$($process.ProcessName),$($process.CPU)" | Out-File -FilePath $logFile -Append
    } else {
        "[$timestamp] Worm process not found. It might have terminated." | Out-File -FilePath $logFile -Append
    }

    Start-Sleep -Seconds $interval
}
