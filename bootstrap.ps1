param(
  [Parameter(Mandatory = $false)] [switch]$choco = $false,
  [Parameter(Mandatory = $false)] [switch]$docker = $false,
  [Parameter(Mandatory = $false)] [switch]$rdp = $false
)

$errorActionPreference='Stop';

if ($choco)
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} ;
if ($docker)
{
    Install-Module -Name DockerMsftProvider -Repository PSGallery -Force ; Install-Package -Name docker -ProviderName DockerMsftProvider
    Write-Host "Docker installed. Reboot will be required; run 'Restart-Computer -Force'"
} ;
if ($rdp)
{
    Cscript C:\Windows\system32\SCRegEdit.wsf /ar 0 ; Write-Host "Enabling RDP"
}