param(
    [string]$ZosIp = "<ZOS_IP>",
    [string]$OutputPath = ".\windows_network_readonly_sanitized.txt"
)

# Read-only collector. It avoids writing raw private values by sanitizing before saving.

function Redact-Text {
    param([string]$Text)
    $Text = $Text -replace '\b10\.\d{1,3}\.\d{1,3}\.\d{1,3}\b','<PRIVATE_IP>'
    $Text = $Text -replace '\b192\.168\.\d{1,3}\.\d{1,3}\b','<PRIVATE_IP>'
    $Text = $Text -replace '\b172\.(1[6-9]|2[0-9]|3[0-1])\.\d{1,3}\.\d{1,3}\b','<PRIVATE_IP>'
    $Text = $Text -replace 'C:\\Users\\[^\\\s]+','C:\Users\<WINDOWS_USER>'
    $Text = $Text -replace '\\[A-Za-z0-9_.-]+\\[A-Za-z0-9_$.-]+','\\<HOSTNAME>\\<SHARE>'
    $Text = $Text -replace '([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}','<MAC_ADDRESS>'
    return $Text
}

$raw = @()
$raw += "==== Windows read-only network diagnostics ===="
$raw += "Date: $(Get-Date)"
$raw += ""
$raw += "==== ipconfig /all ===="
$raw += (ipconfig /all | Out-String)
$raw += "==== route print ===="
$raw += (route print | Out-String)
$raw += "==== arp -a ===="
$raw += (arp -a | Out-String)
$raw += "==== Test-NetConnection TN3270 ===="
$raw += (Test-NetConnection $ZosIp -Port 23 | Out-String)
$raw += "==== Test-NetConnection SSH ===="
$raw += (Test-NetConnection $ZosIp -Port 22 | Out-String)
$raw += "==== Test-NetConnection FTP ===="
$raw += (Test-NetConnection $ZosIp -Port 21 | Out-String)

$sanitized = Redact-Text ($raw -join "`r`n")
$sanitized | Out-File -FilePath $OutputPath -Encoding UTF8
Write-Host "Sanitized report written to $OutputPath"
