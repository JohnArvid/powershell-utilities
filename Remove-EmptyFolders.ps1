function Remove-EmptyFolders {
    param (
        [string]$folderPath = (Get-Location)  # Default: current folder
    )
    
    $folders = Get-ChildItem -Path $folderPath -Directory

    foreach ($folder in $folders) {
        $childItems = Get-ChildItem -Path $folder.FullName -File -Recurse

        if ($childItems.Count -eq 0) {
            Remove-Item -Path $folder.FullName -Force -Recurse
            Write-Host "Deleted empty folder: $($folder.FullName)"
        }
        else {
            Remove-EmptyFolders -Path $folder.FullName
        }
    }
    Write-Host "Cleaning done!"
}