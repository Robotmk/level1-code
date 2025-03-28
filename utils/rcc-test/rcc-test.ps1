# ================================
# RCC Test Environment Setup
# ================================

# --- Variables ---
$RCC_DOWNLOAD_URL = "https://github.com/elabit/robotmk/releases/download/v4.0.0-alpha-1/rcc_windows64.exe"
$RCC_PROFILE_NAME = "RCCTestProfile"
$USE_PROXY = $false
$RCC_PATH = Join-Path $PSScriptRoot "rcc.exe"

# Set ROBOCORP_HOME for this session
$env:ROBOCORP_HOME = Join-Path $env:TEMP "rcc-test"

# --- Main Execution ---
function Main {
    CheckOS
    VCDLLCheck
    SetProxy
    DownloadRCC
    RCCCleanup
    DisableTelemetry
    CheckLongPaths
    RunRCCDiag
    CreateEnv -EnvName "rf" -EnvDesc "Environment 1/2"
    CreateEnv -EnvName "pw" -EnvDesc "Environment 2/2"
    UnsetProxy
    Write-Host "#######################################"
    Write-Host "RCC test finished successfully!"
    Write-Host "#######################################"
}

# --- Functions ---
function CheckOS {
    Write-Host "+ Checking the OS"
    $os = Get-CimInstance Win32_OperatingSystem
    $version = [version]$os.Version
    $caption = $os.Caption
    $minSupportedVersion = [version]"10.0.17763"

    if ($version -ge $minSupportedVersion) {
        Write-Host "OK: Supported OS detected: $caption ($version)"
    } else {
        Write-Host "!! Unsupported OS: $caption ($version) - Windows 10 / Server 2019 or higher required!"
        exit 1
    }
}

function VCDLLCheck {
    Write-Host "+ Checking for vcruntime140.dll"
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
        Write-Host "OK: vcruntime140.dll found."
    } else {
        Write-Host "!! Required Visual C++ DLLs not found."
        Write-Host "Please install: https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist"
        exit 1
    }
}

function DownloadRCC {
    if (Test-Path $RCC_PATH) {
        Write-Host "+ RCC already downloaded."
        return
    }
    Write-Host "+ Downloading RCC"
    try {
        Invoke-WebRequest -Uri $RCC_DOWNLOAD_URL -OutFile $RCC_PATH -ErrorAction Stop
        Write-Host "OK: RCC downloaded."
    } catch {
        Write-Host "!! RCC download failed: $_"
        exit 1
    }
}

function RCCCleanup {
    Write-Host "+ Cleaning up RCC"
    & $RCC_PATH config cleanup --all
    & $RCC_PATH ht ls
}

function DisableTelemetry {
    Write-Host "+ Disabling telemetry"
    & $RCC_PATH configure identity -t
}

function CheckLongPaths {
    Write-Host "+ Checking long paths"
    & $RCC_PATH configure longpaths
    if ($LASTEXITCODE -ne 0) {
        Write-Host "!! Failed to enable long path support."
        Write-Host "See: https://learn.microsoft.com/de-de/windows/win32/fileio/maximum-file-path-limitation?tabs=registry"
        exit 1
    } else {
        Write-Host "OK: Long Path Support enabled."
    }
}

function SetProxy {
    $useProxy = Read-Host "Are you behind a proxy? (y/n)"
    if ($useProxy -match "^[YyJj]") {
        CreateProxyProfile
        Import-ProxyProfile
        Switch-ProxyProfile -ProfileName $RCC_PROFILE_NAME
        $Global:USE_PROXY = $true
    }
}

function CreateProxyProfile {
    $httpProxyAddress = Read-Host "Enter the HTTP proxy address (e.g. http://myproxy.local:3128)"
    $httpsProxyAddress = Read-Host "Enter the HTTPS proxy address (e.g. http://myproxy.local:3128)"

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
}

function Import-ProxyProfile {
    Write-Host "+ Importing proxy profile"
    if (-Not (Test-Path "rcc-proxy-profile.yaml")) {
        Write-Host "!! Proxy profile file not found."
        exit 1
    }
    & $RCC_PATH config import -f rcc-proxy-profile.yaml
}

function Switch-ProxyProfile {
    param (
        [string]$ProfileName
    )
    Write-Host "+ Switching proxy profile"
    & $RCC_PATH config switch --profile $ProfileName
    $output = & $RCC_PATH config switch
    if (-Not ($output -match "Currently active profile is: $ProfileName")) {
        Write-Host "!! Failed to switch proxy profile."
        Write-Host "Current profiles:"
        Write-Host $output
        exit 1
    } else {
        Write-Host "OK: Proxy profile $ProfileName active."
    }
}

function RunRCCDiag {
    Write-Host "+ Running rccdiag"
    & $RCC_PATH netdiag --checks rccdiag.yaml
}

function CreateEnv {
    param (
        [string]$EnvName,
        [string]$EnvDesc
    )
    Write-Host "+ Creating $EnvName environment ($EnvDesc)"
    & $RCC_PATH holotree vars --robot "envs/robot-$EnvName.yaml"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "!! Failed to create environment."
        UnsetProxy
        exit 1
    } else {
        Write-Host "OK: $EnvName environment created."
    }
}

function UnsetProxy {
    if ($USE_PROXY) {
        Write-Host "+ Unsetting proxy profile"
        & $RCC_PATH config switch --noprofile
        $output = & $RCC_PATH config switch
        if (-Not ($output -match "Currently active profile is: default")) {
            Write-Host "!! Failed to unset proxy profile."
            Write-Host "Current profiles:"
            Write-Host $output
            exit 1
        } else {
            Write-Host "OK: Proxy profile unset."
        }        
    }

}

# --- Start ---
Main