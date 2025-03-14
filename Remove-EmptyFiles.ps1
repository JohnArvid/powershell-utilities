function Remove-EmptyFiles {
    param (
        [string]$folderPath,
        [string]$name
    )
    # Prompt for folder path if none given
    if (-not $folderPath) {
        $folderPath = Read-Host "Indicate path to folder: "
    }
    
    # Default to "empty" as string to search for
    if (-not $name) {
        $name = "empty"
    }
    if (-not (Test-Path $folderPath -PathType Container)) {
        Write-Host "Error: Folder '$folderPath' doesn't exist" -ForegroundColor Red
        return
    }
    Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.Name -match $name } | ForEach-Object {
        Remove-Item $_.FullName -Force
        Write-Host "Deleted: $($_.FullName)"
    }
    Write-Host "Cleaning done!"
}
