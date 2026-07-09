param(
    [Parameter(Mandatory=$true)][string]$InputPath,
    [Parameter(Mandatory=$true)][string]$OutputPath
)

$text = Get-Content -Raw -Path $InputPath
$text = $text -replace '\b10\.\d{1,3}\.\d{1,3}\.\d{1,3}\b','<PRIVATE_IP>'
$text = $text -replace '\b192\.168\.\d{1,3}\.\d{1,3}\b','<PRIVATE_IP>'
$text = $text -replace '\b172\.(1[6-9]|2[0-9]|3[0-1])\.\d{1,3}\.\d{1,3}\b','<PRIVATE_IP>'
$text = $text -replace 'C:\\Users\\[^\\\s]+','C:\Users\<WINDOWS_USER>'
$text = $text -replace 'C:\\[^\r\n\t ]+','<LOCAL_PATH>'
$text = $text -replace '\\[A-Za-z0-9_.-]+\\[A-Za-z0-9_$.-]+','\\<HOSTNAME>\\<SHARE>'
$text = $text -replace '([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}','<MAC_ADDRESS>'
$text | Out-File -FilePath $OutputPath -Encoding UTF8
Write-Host "Sanitized file written to $OutputPath"
