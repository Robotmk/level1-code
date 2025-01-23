param(
    [Parameter(Mandatory=$true)]
    [string]$Browser
)

$URL = "http://puter.robotmk.org"

switch ($Browser.ToLower()) {
    "chrome" {
        # Try to start Chrome from PATH, if not found, use the installation path
        if (Get-Command "chrome.exe" -ErrorAction SilentlyContinue) {
            # Start-Process "chrome.exe" "--incognito --start-maximized $URL"
            Start-Process "chrome.exe" "--start-maximized $URL"
        } else {
            $chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
            if (Test-Path $chromePath) {
                # Start-Process $chromePath "--incognito --start-maximized $URL"
                Start-Process $chromePath "--start-maximized $URL"
            } else {
                Write-Host "Chrome not found in PATH or default installation path."
            }
        }
    }
    "firefox" {
        # Try to start Firefox from PATH, if not found, use the installation path
        if (Get-Command "firefox.exe" -ErrorAction SilentlyContinue) {
            # Start-Process "firefox.exe" "-private $URL"
            Start-Process "firefox.exe" "$URL"
        } else {
            $firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
            if (Test-Path $firefoxPath) {
                # Start-Process $firefoxPath "-private $URL"
                Start-Process $firefoxPath "$URL"
            } else {
                Write-Host "Firefox not found in PATH or default installation path."
            }
        }
    }
    default {
        Write-Host "Unsupported browser: $Browser"
        Write-Host "Supported browsers: chrome, firefox"
    }
}