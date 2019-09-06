param(
  [string]$url,
  [Parameter(Mandatory = $false )]
  [string]$dest
)

Write-Host "Starting " $url "..."

$client = new-object System.Net.WebClient

if (!$dest)
{
    $dest = (Get-Item -Path ".\" -Verbose).FullName + "\Downloads\" + [System.IO.Path]::GetFileNameWithoutExtension($url) + [System.IO.Path]::GetExtension($url)
    Write-Host $dest
} else {
    Write-Host $dest
}

$default = (Get-Item -Path ".\" -Verbose).FullName + "\Downloads\" + $url

function DownloadPath($url, $dest = $default) {	

	Write-Host "Downloading to " $dest

	$client.DownloadFile($url,$dest)
}

DownloadPath $url $dest