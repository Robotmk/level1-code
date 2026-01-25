# ================================
# RCC Test Environment Setup
# ================================

# --- Variables ---
$RCC_DOWNLOAD_URL = "https://github.com/elabit/robotmk/releases/download/v4.0.0-alpha-1/rcc_windows64.exe"
$RCC_PROFILE_NAME = "RCCTestProfile"
$USE_PROXY = $false
$RCC_PATH = Join-Path $PSScriptRoot "rcc.exe"

# Set ROBOCORP_HOME for this session
# Use LOCALAPPDATA to ensure it stays local and never on a server/roaming profile
$env:ROBOCORP_HOME = Join-Path $env:LOCALAPPDATA ".robotmk\rcc-test"

# Error handling - display support message on script failure
$ErrorActionPreference = "Stop"
trap {
    Write-Host ""
    Write-Host "========================================="
    Write-Host "⚠️  ERROR OCCURRED - SUPPORT INFORMATION"
    Write-Host "========================================="
    Write-Host "If you need assistance, please:"
    Write-Host "  1. Copy the complete console output above"
    Write-Host "  2. Send it via email to: mail@robotmk.org"
    Write-Host "  3. Include a brief description of what you were trying to do"
    Write-Host ""
    Write-Host "We'll help you resolve this issue!"
    Write-Host "========================================="
    exit 1
}

# --- Helper Functions ---
function Print-Header {
    param ([string]$Message)
    Write-Host ""
    Write-Host "========================================="
    Write-Host $Message
    Write-Host "========================================="
}

function Print-Section {
    param ([string]$Message)
    Write-Host ""
    Write-Host "-------------------------------------"
    Write-Host ">>> $Message"
    Write-Host "-------------------------------------"
}

# --- Main Execution ---
function Main {
    Print-Header "RCC Test Environment Setup"
    Write-Host "This script sets up an RCC test environment."
    Write-Host "It will perform the following steps:"
    Write-Host "  1. OS and prerequisites check"
    Write-Host "  2. Proxy configuration (optional)"
    Write-Host "  3. RCC download (if required)"
    Write-Host "  4. RCC cleanup"
    Write-Host "  5. Disable telemetry"
    Write-Host "  6. Long paths check"
    Write-Host "  7. Network diagnostics"
    Write-Host "  8. Create test environments"
    Write-Host ""
    Write-Host "ROBOCORP_HOME: $env:ROBOCORP_HOME"
    Write-Host "RCC Path: $RCC_PATH"
    Write-Host ""
    
    CheckOS
    VCDLLCheck
    SetProxy
    DownloadRCC
    Verify-RCC
    RCCCleanup
    DisableTelemetry
    CheckLongPaths
    RunRCCDiag
    CreateEnv -EnvName "rf" -EnvDesc "Environment 1/2"
    CreateEnv -EnvName "pw" -EnvDesc "Environment 2/2"
    UnsetProxy
    
    Print-Header "✅ Test environments created successfully"
}

# --- Functions ---
function CheckOS {
    Print-Section "OS Check"
    $os = Get-CimInstance Win32_OperatingSystem
    $version = [version]$os.Version
    $caption = $os.Caption
    $minSupportedVersion = [version]"10.0.17763"

    if ($version -ge $minSupportedVersion) {
        Write-Host "✅ Supported OS detected: $caption ($version)"
    } else {
        Write-Host "❌ Unsupported OS: $caption ($version) - Windows 10 / Server 2019 or higher required!"
        exit 1
    }
}

function VCDLLCheck {
    Print-Section "Visual C++ Runtime Check"
    $dllsToCheck = @("vcruntime140.dll", "vcruntime140_1.dll")
    $foldersToSearch = @("$env:SystemRoot\System32", "$env:SystemRoot\SysWOW64")
    $found = @()

    foreach ($dll in $dllsToCheck) {
        foreach ($folder in $foldersToSearch) {
            $fullPath = Join-Path $folder $dll
            if (Test-Path $fullPath) {
                $found += $fullPath
            }
        }
    }

    if ($found.Count -gt 0) {
        Write-Host "✅ Visual C++ runtime DLLs found"
    } else {
        Write-Host "❌ Required Visual C++ DLLs not found."
        Write-Host "Please install: https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist"
        exit 1
    }
}

function Verify-RCC {
    Print-Section "RCC Verification"
    
    if (-Not (Test-Path $RCC_PATH)) {
        Write-Host "❌ RCC binary not found at: $RCC_PATH"
        exit 1
    }
    
    Write-Host "Verifying RCC executable and version..."
    try {
        $versionOutput = & $RCC_PATH version 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ RCC execution failed"
            exit 1
        }

        if ($versionOutput -match "v17\.29\.1") {
            Write-Host "✅ RCC binary found and functional (version v17.29.1)"
        } else {
            Write-Host "⚠️  Unexpected RCC version: $versionOutput"
            Write-Host "✅ RCC binary found and functional"
        }
    } catch {
        Write-Host "❌ Error verifying RCC: $_"
        exit 1
    }
}

function DownloadRCC {
    Print-Section "RCC Download"
    
    # Skip download if proxy is used (RCC must already exist)
    if ($Global:USE_PROXY -eq $true) {
        Write-Host "⏭️  Skipping download (proxy is configured, RCC already present)"
        return
    }
    
    if (Test-Path $RCC_PATH) {
        Write-Host "✅ RCC already present: $RCC_PATH"
        return
    }
    
    Write-Host "Downloading RCC..."
    Write-Host "Detected system: Windows"
    try {
        Invoke-WebRequest -Uri $RCC_DOWNLOAD_URL -OutFile $RCC_PATH -ErrorAction Stop
        Write-Host "✅ RCC successfully downloaded"
    } catch {
        Write-Host "❌ Error downloading RCC: $_"
        exit 1
    }
}

function RCCCleanup {
    Print-Section "RCC Cleanup"
    Write-Host "Running RCC cleanup..."
    & $RCC_PATH config cleanup --all
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ RCC cleanup failed"
        exit 1
    }
    & $RCC_PATH ht ls
    Write-Host "✅ RCC cleanup successful"
}

function DisableTelemetry {
    Print-Section "Disable Telemetry"
    Write-Host "Disabling telemetry..."
    & $RCC_PATH configure identity -t
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Error disabling telemetry"
        exit 1
    }
    Write-Host "✅ Telemetry disabled"
}

function CheckLongPaths {
    Print-Section "Long Paths Support"
    Write-Host "Checking long paths support..."
    & $RCC_PATH configure longpaths
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to enable long path support"
        Write-Host "See: https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry"
        exit 1
    } else {
        Write-Host "✅ Long Path Support enabled"
    }
}

function SetProxy {
    Print-Section "Proxy Configuration"
    $useProxy = Read-Host "Are you behind a proxy? (y/n)"
    if ($useProxy -match "^[YyJj]") {
        Write-Host ""
        Write-Host "⚠️  Proxy usage detected!"
        
        # Check if RCC binary exists
        if (-Not (Test-Path $RCC_PATH)) {
            Write-Host ""
            Write-Host "❌ RCC binary not found!"
            Write-Host ""
            Write-Host "When using a proxy, you must download RCC manually first."
            Write-Host ""
            Write-Host "Instructions:"
            Write-Host "  1. Download RCC from:"
            Write-Host "     $RCC_DOWNLOAD_URL"
            Write-Host ""
            Write-Host "  2. Save the file here: $RCC_PATH"
            Write-Host "     (make sure to rename it to 'rcc.exe')"
            Write-Host ""
            Write-Host "  3. Run this script again."
            Write-Host ""
            exit 1
        }
        
        Write-Host "✅ RCC binary found, proceeding with proxy configuration..."
        CreateProxyProfile
        Import-ProxyProfile
        Switch-ProxyProfile -ProfileName $RCC_PROFILE_NAME
        $Global:USE_PROXY = $true
    } else {
        Write-Host "✅ No proxy will be used"
    }
}

function CreateProxyProfile {
    Write-Host ""
    $httpProxyAddress = Read-Host "Enter the HTTP proxy address (example: http://myproxy.local:3128)"
    $httpsProxyAddress = Read-Host "Enter the HTTPS proxy address (example: http://myproxy.local:3128)"

    $config = @"
name: $RCC_PROFILE_NAME
description: RCC proxy profile
settings:
  certificates:
    verify-ssl: true
  network:
    no-proxy: 'localhost,127.0.0.1'
    https-proxy: '$httpsProxyAddress'
    http-proxy: '$httpProxyAddress'
  meta:
    name: $RCC_PROFILE_NAME
    description: RCC proxy profile
    source: Robotmk
"@

    $config | Out-File -FilePath "rcc-proxy-profile.yaml" -Encoding utf8
    $env:HTTP_PROXY = $httpProxyAddress
    $env:HTTPS_PROXY = $httpsProxyAddress
    Write-Host "✅ Proxy profile created"
}

function Import-ProxyProfile {
    Write-Host "Importing proxy profile..."
    if (-Not (Test-Path "rcc-proxy-profile.yaml")) {
        Write-Host "❌ rcc-proxy-profile.yaml does not exist"
        exit 1
    }
    & $RCC_PATH config import -f rcc-proxy-profile.yaml
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to import proxy profile"
        exit 1
    }
    Write-Host "✅ Proxy profile imported"
}

function Switch-ProxyProfile {
    param (
        [string]$ProfileName
    )
    Write-Host "Switching to proxy profile: $ProfileName"
    & $RCC_PATH config switch --profile $ProfileName
    $output = & $RCC_PATH config switch
    if (-Not ($output -match "Currently active profile is: $ProfileName")) {
        Write-Host "❌ Failed to switch proxy profile"
        Write-Host "Current profiles:"
        Write-Host $output
        exit 1
    } else {
        Write-Host "✅ Switched to proxy profile: $ProfileName"
    }
}

function RunRCCDiag {
    Print-Section "Network Diagnostics"
    Write-Host "Running RCC network diagnostics (this can take a few moments)..."
    Write-Host "--- RCC NETDIAG OUTPUT START ---"
    & $RCC_PATH netdiag --checks rccdiag.yaml
    $exitCode = $LASTEXITCODE
    Write-Host "--- RCC NETDIAG OUTPUT END ---"
    if ($exitCode -ne 0) {
        Write-Host "❌ Network diagnostics failed"
        exit 1
    }
    Write-Host "✅ Network diagnostics successful"
}

function CreateEnv {
    param (
        [string]$EnvName,
        [string]$EnvDesc
    )
    Print-Section "Creating environment: $EnvName ($EnvDesc)"
    Write-Host "Creating environment with robot-$EnvName.yaml..."
    Write-Host "--- RCC HOLOTREE OUTPUT START ---"
    & $RCC_PATH holotree vars --robot "envs/robot-$EnvName.yaml"
    $exitCode = $LASTEXITCODE
    Write-Host "--- RCC HOLOTREE OUTPUT END ---"
    if ($exitCode -ne 0) {
        Write-Host "❌ Error creating environment: $EnvName"
        UnsetProxy
        exit 1
    } else {
        Write-Host "✅ Environment $EnvName created successfully"
    }
}

function UnsetProxy {
    if ($USE_PROXY) {
        Print-Section "Restoring Default Profile"
        Write-Host "Switching back to default profile..."
        & $RCC_PATH config switch --noprofile
        $output = & $RCC_PATH config switch
        if (-Not ($output -match "Currently active profile is: default")) {
            Write-Host "⚠️  Warning: Failed to switch back to default profile"
            Write-Host "Current profiles:"
            Write-Host $output
        } else {
            Write-Host "✅ Restored default profile"
        }        
    }
}

# --- Start ---
Main