# Define the command to start the process
$command = "brave.exe"

# Start the process
$process = Start-Process -FilePath $command -PassThru

# Get the process ID
$processId = $process.Id

# Output the process ID
Write-Host "Process ID: $processId"

# Wait for a duration (e.g., 10 seconds) to collect CPU usage data
Start-Sleep -Seconds 10

# Collect CPU usage data
$typeperfCmd = "typeperf `\Process($($process.Id))\% Processor Time` -si 1 -sc 10"
Invoke-Expression $typeperfCmd | Out-File -FilePath "cpu_usage.csv"

Write-Host "CPU usage data has been saved to cpu_usage.csv"
