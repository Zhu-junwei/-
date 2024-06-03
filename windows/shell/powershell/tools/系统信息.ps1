# Get system information and display it
$os = Get-WmiObject -Class Win32_OperatingSystem
$computer = Get-WmiObject -Class Win32_ComputerSystem

Write-Host "Operating System: " $os.Caption
Write-Host "OS Version: " $os.Version
Write-Host "Computer Name: " $computer.Name
Write-Host "Total Physical Memory: " ([math]::round($computer.TotalPhysicalMemory / 1GB, 2)) "GB"
Write-Host "Free Physical Memory: " ([math]::round($os.FreePhysicalMemory / 1MB, 2)) "MB"
Write-Host "User Name: " $os.RegisteredUser
Read-Host "Press Enter to exit"