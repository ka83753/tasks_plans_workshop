[CmdletBinding()]
param (
  # Name or list of service names to stop
  [Parameter(Mandatory=$true)]
  [string[]]
  $service,
  # Restart the service immediately
  [Parameter(Mandatory=$false)]
  [switch]
  $norestart
)

foreach ($name in $service) {
  try{
    $serviceObject = Get-service -Name $name
    Write-output "Found Service: $name"

    if(-not $serviceObject){
      Write-Output "Service not found: $name"
      continue
    }

    Stop-Service -InputObject $serviceObject -ErrorAction Stop

    Write-Output "Stopped service: $name"

    if($norestart){continue}

    Start-Service -InputObject $serviceObject

    Write-Output "Started service: $name"

  } catch {
    Write-Output "Cannot stop service: $name"
    Write-Output "Dependent services: $($serviceObject.dependentservices)"

    exit 1
  }
}
