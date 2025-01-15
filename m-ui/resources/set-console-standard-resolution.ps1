function Reset-GraphicsResolution {
    # Define the registry path
    $basePath = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Configuration"

    # Function to recursively find resolution entries
    function Get-ResolutionEntries($path) {
        $entries = @()

        # Get the current level keys
        $subKeys = Get-ChildItem -Path $path -ErrorAction SilentlyContinue

        foreach ($subKey in $subKeys) {
            $keyPath = $subKey.PSPath

            # Check for PrimSurfSize.cx and PrimSurfSize.cy
            $cx = Get-ItemProperty -Path $keyPath -Name "PrimSurfSize.cx" -ErrorAction SilentlyContinue
            $cy = Get-ItemProperty -Path $keyPath -Name "PrimSurfSize.cy" -ErrorAction SilentlyContinue

            if ($cx -ne $null -and $cy -ne $null) {
                $entries += [PSCustomObject]@{
                    Path        = ($keyPath -replace "^.*\\Configuration\\", "")
                    Resolution  = if ($cx -and $cy) { "${($cx."PrimSurfSize.cx")} x ${($cy."PrimSurfSize.cy")}" } else { "Unknown" }
                }
            }

            # Recursively check subkeys
            $entries += Get-ResolutionEntries -Path $keyPath
        }

        return $entries
    }

    # Start recursive search
    $resolutions = Get-ResolutionEntries -Path $basePath

    if ($resolutions.Count -eq 0) {
        Write-Host "No resolution entries found." -ForegroundColor Yellow
        return
    }

    # Display all found resolutions
    Write-Host "Found resolutions:" -ForegroundColor Green
    $resolutions | Format-Table -Property Path, Resolution -AutoSize

    # Ask for confirmation to reset
    $confirm = Read-Host "Do you want to reset all resolutions to 1920x1080? (y/n)"

    if ($confirm -eq 'y') {
        foreach ($resolution in $resolutions) {
            try {
                Set-ItemProperty -Path "$basePath\$($resolution.Path)" -Name "PrimSurfSize.cx" -Value 1920
                Set-ItemProperty -Path "$basePath\$($resolution.Path)" -Name "PrimSurfSize.cy" -Value 1080
                Write-Host "Reset resolution at $($resolution.Path) to 1920x1080." -ForegroundColor Cyan
            } catch {
                Write-Host "Failed to reset resolution at $($resolution.Path): $_" -ForegroundColor Red
            }
        }
        Write-Host "All resolutions have been reset to 1920x1080." -ForegroundColor Green
    } else {
        Write-Host "No changes were made." -ForegroundColor Yellow
    }
}

# Run the function
Reset-GraphicsResolution
