. "$PSScriptRoot/config.ps1"

if (!(Test-Path $LogDirectory)) {
    New-Item -ItemType Directory -Path $LogDirectory | Out-Null
}

$LogFile = Join-Path $LogDirectory ("log_" + (Get-Date -Format "yyyyMMdd_HHmmss") + ".csv")
"Timestamp,CPU,Memory" | Out-File -FilePath $LogFile -Encoding utf8

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue
    $ram = (
        (Get-CimInstance -ClassName Win32_OperatingSystem).TotalVisibleMemorySize -
        (Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory
    ) / (Get-CimInstance -ClassName Win32_OperatingSystem).TotalVisibleMemorySize * 100

    $cpuRounded = [math]::Round($cpu, 0)
    $ramRounded = [math]::Round($ram, 0)

    "$timestamp,$cpuRounded,$ramRounded" | Out-File -Append -FilePath $LogFile -Encoding utf8

    if ($cpuRounded -ge $CPUThreshold) {
        [System.Windows.Forms.MessageBox]::Show("High CPU usage: $cpuRounded%", "Alert", 'OK', 'Warning')
    }

    if ($ramRounded -ge $RAMThreshold) {
        [System.Windows.Forms.MessageBox]::Show("High RAM usage: $ramRounded%", "Alert", 'OK', 'Warning')
    }

    Start-Sleep -Seconds $LogIntervalSeconds
}
