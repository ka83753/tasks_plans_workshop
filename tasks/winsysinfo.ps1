Param($myparam1)
$systeminfo = systeminfo
Write-Output "System Info:" $systeminfo
Write-Output "Your custom parameter was: ${myparam1}"
