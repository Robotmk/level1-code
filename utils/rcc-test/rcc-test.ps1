
# Set variables
$RCC_DOWNLOAD_URL = "https://github.com/elabit/robotmk/releases/download/v4.0.0-alpha-1/rcc_windows64.exe"
$RCC_PROFILE_NAME = "RCCTestProfile"
$USE_PROXY = $false

# set ROBOCORP_HOME for the runtime of this script
$env:ROBOCORP_HOME = $env:TEMP + "\rcc-test"

function Main {
    CheckOS
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
    Write-Host "Test environments created successfully!"
    Write-Host "#######################################"
}

function CheckOS {
    $os = Get-CimInstance Win32_OperatingSystem
    $version = [version]$os.Version
    $caption = $os.Caption
    
    # Windows 10 or Server 2019: Minimum Version is 10.0.17763
    $minSupportedVersion = [version]"10.0.17763"
    
    if ($version -ge $minSupportedVersion) {
        Write-Host "Supported OS detected: $caption ($version)"
    } else {
        Write-Host "❌ Unsupported OS: $caption ($version) - Windows 2019 Server / Windows 10 or higher required!"
    }
}

function DownloadRCC {
    # Check if RCC already exists
    if (Test-Path "rcc.exe") {
        return
    }
    Write-Host "Downloading RCC"   
    Invoke-WebRequest -Uri $RCC_DOWNLOAD_URL -OutFile "rcc.exe"
}

function RCCCleanup {
    Write-Host "Cleaning up RCC"
    rcc.exe config cleanup --all
    rcc.exe ht ls
}

function DisableTelemetry {
    Write-Host "Disabling telemetry"
    rcc.exe configure identity -t
}

function CheckLongPaths {
    Write-Host "Checking long paths"
    rcc.exe configure longpaths
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to enable long path support for Windows."
        Write-Host "See https://learn.microsoft.com/de-de/windows/win32/fileio/maximum-file-path-limitation?tabs=registry"
        exit 1
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
    # set this proxy server for the current session
    $env:HTTP_PROXY = $httpProxyAddress
    $env:HTTPS_PROXY = $httpsProxyAddress
}

function Import-ProxyProfile {
    Write-Host "Importing proxy profile"
    if (-Not (Test-Path "rcc-proxy-profile.yaml")) {
        Write-Host "❌ rcc-proxy-profile.yaml does not exist"
        exit 1
    }
    rcc.exe config import -f rcc-proxy-profile.yaml
}

function Switch-ProxyProfile {
    param (
        [string]$ProfileName
    )
    Write-Host "Switching proxy profile"
    rcc.exe config switch --profile $ProfileName
    $output = rcc.exe config switch
    if (-Not ($output -match "Currently active profile is: $ProfileName")) {
        Write-Host "❌ Failed to switch proxy profile."
        Write-Host "Current profiles:"
        Write-Host $output
        exit 1
    }
}

function RunRCCDiag {
    Write-Host "Running rccdiag"
    rcc.exe netdiag --checks rccdiag.yaml
}

function CreateEnv {
    param (
        [string]$EnvName,
        [string]$EnvDesc
    )
    Write-Host "Creating $EnvName environment ($EnvDesc)"
    rcc.exe holotree vars --robot "envs/robot-$EnvName.yaml"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to create environment."
        UnsetProxy
        exit 1
    }
}

function UnsetProxy {
    if ($USE_PROXY) {
        Write-Host "Unsetting proxy profile"
        rcc.exe config switch --noprofile
    }
    $output = rcc.exe config switch
    if (-Not ($output -match "Currently active profile is: default")) {
        Write-Host "❌ Failed to unset proxy profile."
        Write-Host "Current profiles:"
        Write-Host $output
        exit 1
    }
}

Main