param(
  [Parameter(Mandatory = $false)] [switch]$choco = $false,
  [Parameter(Mandatory = $false)] [switch]$docker = $false,
  [Parameter(Mandatory = $false)] [switch]$rdp = $false,
  [Parameter(Mandatory = $false)] [switch]$wsl = $false,
  [Parameter(Mandatory = $false)] [switch]$prepDistro = $false
)

$errorActionPreference='Stop';

function Output-Version {	
    $versions = @("*Server 2019*", "*10 Pro*", "*Home 10*")
    $winVerName = systeminfo | findstr /B /C:"OS Name"
    $compatVersion = ($versions | %{$winVerName -Like $_}) -contains $true
    $compatVersion
}

if ($choco)
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} ;
if ($docker)
{
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module -Name DockerMsftProvider -Repository PSGallery -Force ; Install-Package -Name docker -ProviderName DockerMsftProvider -Force

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
} ;
if ($wsl)
{
    $compatVersion = Output-Version -CheckString $version
    if ($compatVersion -eq "True")
    {
	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
	$WslReb = Read-Host -Prompt 'WSL installed. Reboot may be required. Reboot now? [yes/no]';
	if($WslReb -eq "yes")
	{
		Restart-Computer -Force
	} else {
		Write-Host "Computer will not reboot. Run 'Restart-Computer -Force' when you are ready to complete installation."
	}
    } else {
	$winVerName = systeminfo | findstr /B /C:"OS Name"
	Write-Host "You are running the following version of Windows:"
        Write-Host $winVerName
    }
} ;
if ($prepDistro -And $choco -And $wsl)
{
    $compatVersion = Output-Version
    if ($compatVersion -eq "True")
    {
	$distros = choco search wsl | findstr /B /C:"wsl-" | awk '{print $1}'
	choco feature enable -n=allowGlobalConfirmation
	choco install awk
	For ($i=0; $i -lt $distros.Length; $i++)
	{ 
		Write-Host "Installing WSL distro: " $distros[$i]
		choco install $distros[$i]
	}
    } else {
	$winVerName = systeminfo | findstr /B /C:"OS Name"
        Write-Host "You are running the following version of Windows:"
        Write-Host $winVerName
    }
} else {
    Write-Host "This function requires that choco, wsl, and version (i.e. a partial string like '*Home 10*' or '*Server 2019*' be set, along with prepDistro, in order to complete this phase."
}
