# Define the duration to monitor CPU usage (in seconds)
$duration = 600  # Example: 10 minutes

# Define the output file
$outputFile = "normal_cpu_usage.csv"

# Write the header to the CSV file
"Timestamp,CPU_Usage" | Out-File -FilePath $outputFile -Append

# Monitor CPU usage every second
for ($i = 0; $i -lt $duration; $i++) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $cpuUsage = (Get-WmiObject -Query "SELECT LoadPercentage FROM Win32_Processor" | Measure-Object -Property LoadPercentage -Average).Average
    "$timestamp,$cpuUsage" | Out-File -FilePath $outputFile -Append
    Start-Sleep -Seconds 1
}

Write-Host "CPU usage data has been saved to $outputFile"
