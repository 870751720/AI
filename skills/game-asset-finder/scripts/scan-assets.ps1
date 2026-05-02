#Requires -Version 5.1
<#
.SYNOPSIS
    Scan the external art library and find game assets by type/keyword.

.PARAMETER Type
    Asset category filter: character | environment | icon | ui | font | audio | farm | misc

.PARAMETER Keyword
    Filename or path keyword filter (supports wildcards).

.PARAMETER Limit
    Max results to return. Default 50.

.PARAMETER ListCategories
    List top-level directory structure of the art library.

.EXAMPLE
    .\scan-assets.ps1 -Type character -Keyword "Idle"
    .\scan-assets.ps1 -Type audio -Keyword "sword" -Limit 20
    .\scan-assets.ps1 -ListCategories
#>
param(
    [ValidateSet("character", "environment", "icon", "ui", "font", "audio", "sound", "sfx", "farm", "misc", "")]
    [string]$Type = "",

    [string]$Keyword = "",

    [int]$Limit = 50,

    [switch]$ListCategories
)

$basePath = "C:\Users\Gavin\Desktop\美术库"

if (-not (Test-Path $basePath)) {
    Write-Error "Art library path not found: $basePath"
    exit 1
}

# Category -> relative path mapping
$categoryMap = @{
    "character"   = @("character")
    "environment" = @("environment")
    "icon"        = @("icon")
    "ui"          = @("icon")
    "font"        = @("font")
    "audio"       = @("音效库")
    "sound"       = @("音效库")
    "sfx"         = @("音效库")
    "farm"        = @("Unity2DRPG_Farm_Assets-main")
    "misc"        = @("素材")
}

# Extension -> asset type mapping
$extMap = @{
    ".png"  = "image"
    ".jpg"  = "image"
    ".jpeg" = "image"
    ".gif"  = "image"
    ".ai"   = "vector"
    ".eps"  = "vector"
    ".scml" = "animation"
    ".wav"  = "audio"
    ".mp3"  = "audio"
    ".ogg"  = "audio"
    ".ttf"  = "font"
    ".unitypackage" = "unity-package"
}

# List top-level categories
if ($ListCategories) {
    Write-Output "=== Art Library Structure ==="
    Write-Output ""
    Get-ChildItem -Path $basePath -Directory | ForEach-Object {
        $dir = $_
        $fileCount = (Get-ChildItem $dir.FullName -Recurse -File -ErrorAction SilentlyContinue).Count
        $msg = "$($dir.Name)  ($fileCount files)"
        Write-Output $msg
    }
    exit 0
}

# Determine search paths
$searchPaths = @()
if ($Type -and $categoryMap.ContainsKey($Type.ToLower())) {
    foreach ($rel in $categoryMap[$Type.ToLower()]) {
        $full = Join-Path $basePath $rel
        if (Test-Path $full) { $searchPaths += $full }
    }
}
else {
    $searchPaths = @($basePath)
}

if ($searchPaths.Count -eq 0) {
    Write-Output "No matching category found: $Type"
    exit 0
}

# Execute search
$results = [System.Collections.Generic.List[object]]::new()

foreach ($path in $searchPaths) {
    $files = Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue

    if ($Keyword) {
        $pattern = "*$Keyword*"
        $files = $files | Where-Object {
            $_.Name -like $pattern -or
            $_.DirectoryName.Replace($basePath, "") -like $pattern
        }
    }

    foreach ($file in $files) {
        $relPath = $file.FullName.Substring($basePath.Length + 1)
        $ext = [System.IO.Path]::GetExtension($file.Name).ToLower()
        $assetType = if ($extMap.ContainsKey($ext)) { $extMap[$ext] } else { "other" }

        $results.Add([PSCustomObject]@{
            Name      = $file.Name
            RelPath   = $relPath
            SizeKB    = [math]::Round($file.Length / 1KB, 1)
            AssetType = $assetType
        })

        if ($results.Count -ge $Limit) { break }
    }

    if ($results.Count -ge $Limit) { break }
}

# Output
if ($results.Count -eq 0) {
    Write-Output "No matching assets found."
    Write-Output "Search scope: $($searchPaths -join ', ')"
    if ($Keyword) { Write-Output "Keyword: $Keyword" }
}
else {
    $results | Format-Table -AutoSize
    Write-Output ""
    Write-Output "Found $($results.Count) asset(s)"
}
