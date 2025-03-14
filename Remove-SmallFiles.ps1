# Delete all files in -folderPath below -size
# -size is optional else 300 kB
function Remove-SmallFiles {
    param (
        [string]$folderPath,
        [int]$size = 300 # Defaults to 300
    )

    # If no folderPath, prompt for it
    if (-not $folderPath) {
        $folderPath = Read-Host "Indicate path to folder: "
    }

    # Check if folderPath exists
    if (-not (Test-Path $folderPath -PathType Container)) {
        Write-Host "Error: Folder '$folderPath' doesn't exist" -ForegroundColor Red
        return
    }

    # Get all files recursively and filter out below $size kB ($size * 1024 byte)
    Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.Length -lt ($size * 1024) } | ForEach-Object {
        Remove-Item $_.FullName -Force
        Write-Host "Deleted: $($_.FullName)"
    }

    Write-Host "Cleaning done!"
}

