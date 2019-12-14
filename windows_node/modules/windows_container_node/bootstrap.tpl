#ps1_sysnative
<powershell>
if ( $choco = "yes" )
{
	Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
if ( $docker = "yes" )
{
	Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
	Install-Module -Name DockerMsftProvider -Repository PSGallery -Force ; Install-Package -Name docker -ProviderName DockerMsftProvider -Force
	if ( $docker_restart = "yes")
	{
		Restart-Computer -Force
	}
}
</powershell>
