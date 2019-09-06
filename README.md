# Windows Scripts

PowerShell and Batch scripts for Windows Administration

## Server

Scripts intended for Windows Server

### `bootstrap.ps1`

Script for installing chocolatey, docker, and enabling RDP. 

**Note:** _This is interactive, and will not run, as-is, via cloud-init._

### `dl.ps1`

Script to download a resource at `url` to `dest` (defaults to working directory unless destination is overridden with `-dest`).

## Workstation

### `chrome-backup-bookmarks.bat`

A batch script for creating a backup file of Chrome bookmarks.
