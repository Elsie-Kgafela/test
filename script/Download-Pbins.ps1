param (
  [Parameter(Mandatory)]
  [string]$Destination,

  [Parameter(Mandatory)]
  [string]$StorageAccountName,

  [Parameter(Mandatory)]
  [string]$StorageAccountKey,

  [Parameter(Mandatory)]
  [string[]]$Pbins
)

Import-Module Az.Storage

if (-Not (Test-Path -Path $Destination -PathType Container)) {
  New-Item -Path $Destination -ItemType Directory
}
$context = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
foreach ($pbin in $Pbins) {
  if (-Not (Test-Path -Path "$Destination/$pbin" -PathType Leaf)) {
    Write-Host -NoNewline "Downloading $pbin... "
    Get-AzStorageFileContent -ShareName shared-pbins -Path "$pbin" -Context $context -Destination $Destination
    Write-Host "done"
  } else {
    Write-Host "Skipping $pbin (cached)"
  }
}
