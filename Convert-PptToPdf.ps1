function Convert-PptToPdf {
  param (
    [string]$folderPath = (Get-Location)  # Default: current folder
  )

  # Check if folderPath exists
  if (-not (Test-Path $folderPath -PathType Container)) {
    Write-Host "Error: Folder '$folderPath' doesn't exist." -ForegroundColor Red
    return
  }

  Write-Host "Searching for PowerPoint-files in $folderPath ..." -ForegroundColor Cyan

  # Get all PowerPoint-files recursively
  $pptFiles = Get-ChildItem -Path $folderPath -Recurse -Filter *.ppt?

  if ($pptFiles.Count -eq 0) {
    Write-Host "No PowerPoint-files found. Aborting." -ForegroundColor Yellow
    return
  }

  # Try to create PowerPoint COM-objektet
  try {
    $ppt_app = New-Object -ComObject PowerPoint.Application
    $ppt_app.Visible = [Microsoft.Office.Core.MsoTriState]::msoTrue
  }
  catch {
    Write-Host "Failed to start PowerPoint. Check if installed. Or repair installation." -ForegroundColor Red
    return
  }

  try {
    # Process every PowerPoint-file
    foreach ($file in $pptFiles) {
      Write-Host "Processing: $($file.FullName) ..." -ForegroundColor Green

      try {
        # Try to open PowerPoint-file
        $document = $ppt_app.Presentations.Open($file.FullName)

        if ($null -eq $document) {
          Write-Host "Could not open: $($file.FullName)" -ForegroundColor Yellow
          continue
        }

        # Create PDF-filename
        $pdf_filename = "$($file.DirectoryName)\$($file.BaseName).pdf"

        # Save as PDF (format 32 = PDF)
        $document.SaveAs($pdf_filename, 32)
        $document.Close()

        Write-Host "Converted: $pdf_filename" -ForegroundColor Magenta
      }
      catch {
        Write-Host "Failed to convert: $($file.FullName). Fel: $_" -ForegroundColor Red
      }
    }
  }
  finally {
    # Close PowerPoint
    if ($null -ne $ppt_app) {
      $ppt_app.Quit()
      [System.Runtime.Interopservices.Marshal]::ReleaseComObject($ppt_app) | Out-Null
    }
    Write-Host "PowerPoint-process closed." -ForegroundColor Cyan
  }

  Write-Host "Conversion done!" -ForegroundColor Cyan
}
