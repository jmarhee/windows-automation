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
    $DockerReb = Read-Host -Prompt 'Docker installed. Reboot will be required. Reboot now? [yes/no]';
    if($DockerReb = "yes")
    {
	Restart-Computer -Force
    } else {
        Write-Host "Computer will not reboot. Run 'Restart-Computer -Force' when you are ready to complete installation."
    }
} ;
if ($rdp)
{
    Cscript C:\Windows\system32\SCRegEdit.wsf /ar 0 ; Write-Host "Enabling RDP"
}