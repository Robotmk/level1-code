# This script removes temp directories in the RCC home directory that are older than 1 day.

# Specify the parent folder
$ParentFolder = "C:\rcc\rc_home\temp"

# Get the current date and time
$CurrentDate = Get-Date

# Iterate through all folders inside the specified parent folder
Get-ChildItem -Path $ParentFolder -Directory | ForEach-Object {
    # Check the creation time of each folder
    $FolderCreationTime = $_.CreationTime

    # Calculate the age of the folder
    $FolderAge = ($CurrentDate - $FolderCreationTime).Days

    # If the folder is older than 1 day, delete it
    if ($FolderAge -gt 1) {
        Write-Output "Deleting folder: $($_.FullName)"
        Remove-Item -Path $_.FullName -Recurse -Force
    }
}