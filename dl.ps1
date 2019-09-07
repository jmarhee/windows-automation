param(
  [string]$url,
  [Parameter(Mandatory = $false)] [string]$dest = ""
)

function DestPath($url, $dest) {
    if ($dest -eq "")
    {
        $dest_target = (Get-Item -Path ".\").FullName + "\" `
        + [System.IO.Path]::GetFileNameWithoutExtension($url) `
        + [System.IO.Path]::GetExtension($url)
    } else {
        $dest_target = $dest
    }
    return $dest_target
}

function DownloadPath($url, $dest_out) { 
    Write-Host "Starting " $url "..."
    Write-Host "Downloading to " $dest_out

    $client = new-object System.Net.WebClient
    $client.DownloadFile($url,$dest_out)
}

$output = DestPath $url $dest

DownloadPath $url $output