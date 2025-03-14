# powershell-utilities

Utility functions in PowerShell to make life easier.

## Remove-EmptyFiles

Removes all files containing "empty" or other string passed as -name in a folder (recursively).
Takes two parameters:

- -folderPath: Path to folder with files to delete
- -name: A string to searh for in filenames to indicate if they are empty. Defaults to "empty"

## Remove-EmptyFolders

Removes all empty folders in a folder (recursively).

Takes one parameter:

- -folderPath: Path to folder with empty folders in it to delete. Defaults to current folder.

## Remove-SmallFiles

Removes all files below 300 kB, or size in kB passed as -size, in a folder (recursively).

Takes two parameters:

- -folderPath: Path to folder to remove files in.
- -size: Upper limit on files to remove. Defaults to 300 kB.

## Convert-PptToPdf

Converts all PowerPoint-files in a folder and subfolders to pdf.

Takes one optional parameter:

- -folderPath: Path to folder with PowerPoint-files to convert. Defaults to current folder.
