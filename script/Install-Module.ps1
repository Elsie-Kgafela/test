param (
  [Parameter(Mandatory)]
  [string]$Name,

  [Parameter(Mandatory)]
  [string]$Module
)

$available = Get-Module -ListAvailable -Name $Module
if (-Not $available) {
  Write-Output "Installing $Name..."
  Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
  Install-Module -Name $Module -Scope CurrentUser -Repository PSGallery -AcceptLicense -Force
}
$version = (Get-Module -ListAvailable -Name $Module).Version
Write-Output "$Name $version installed"
