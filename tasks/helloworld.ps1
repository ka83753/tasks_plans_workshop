Param($name)

if (!($name)) {
  Write-Output "Hello World!"
} else {
  Write-Output "Hello ${name}"
}
