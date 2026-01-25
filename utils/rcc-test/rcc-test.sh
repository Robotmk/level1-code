#!/bin/bash

# ================================
# RCC Test Environment Setup
# ================================

RCC_DOWNLOAD_URL="https://github.com/elabit/robotmk/releases/download/v4.0.0-alpha-1"
RCC_PROFILE_NAME="RCCTestProfile"
USE_PROXY="false"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RCC_BINARY="$SCRIPT_DIR/rcc"

export ROBOCORP_HOME="${TMPDIR:-/tmp}/rcc-test"

# Error handling - display support message on script failure
trap 'on_error' ERR
trap 'on_exit' EXIT

SCRIPT_ERROR=0

function on_error() {
    SCRIPT_ERROR=1
}

function on_exit() {
    if [ $SCRIPT_ERROR -eq 1 ]; then
        echo ""
        echo "========================================="
        echo "⚠️  ERROR OCCURRED - SUPPORT INFORMATION"
        echo "========================================="
        echo "If you need assistance, please:"
        echo "  1. Copy the complete console output above"
        echo "  2. Send it via email to: mail@robotmk.org"
        echo "  3. Include a brief description of what you were trying to do"
        echo ""
        echo "We'll help you resolve this issue!"
        echo "========================================="
    fi
}

function print_header() {
    echo ""
    echo "========================================="
    echo "$1"
    echo "========================================="
}

function print_section() {
    echo ""
    echo "-------------------------------------"
    echo ">>> $1"
    echo "-------------------------------------"
}

function verify_rcc() {
    if [ ! -f "$RCC_BINARY" ]; then
        echo "❌ RCC binary not found at: $RCC_BINARY"
        exit 1
    fi
    
    if [ ! -x "$RCC_BINARY" ]; then
        echo "❌ RCC binary is not executable: $RCC_BINARY"
        exit 1
    fi
    
    # Test if RCC can be executed
    if ! "$RCC_BINARY" version &>/dev/null; then
        echo "❌ RCC could not be executed."
        echo "There might be a conflict with the QT tool 'rcc'."
        echo "Make sure the RCC binary is correct: $RCC_BINARY"
        exit 1
    fi
    
    echo "✅ RCC binary found and functional: $RCC_BINARY"
}

function main() {
    print_header "RCC Test Environment Setup"
    echo "This script sets up an RCC test environment."
    echo "It will perform the following steps:"
    echo "  1. Proxy configuration (optional)"
    echo "  2. RCC download (if required)"
    echo "  3. RCC cleanup"
    echo "  4. Disable telemetry"
    echo "  5. Network diagnostics"
    echo "  6. Create test environments"
    echo ""
    echo "ROBOCORP_HOME: $ROBOCORP_HOME"
    echo "RCC Binary: $RCC_BINARY"
    
    set_proxy
    download_rcc
    verify_rcc
    rcc_cleanup
    disable_telemetry
    run_rccdiag
    create_env rf "Environment 1/2"
    create_env pw "Environment 2/2"
    unset_proxy
    
    print_header "✅ Test environments created successfully"
}

function set_proxy() {
    print_section "Proxy Configuration"
    read -p "Are you behind a proxy? (y/n): " use_proxy
    if [[ "$use_proxy" =~ ^[YyJj] ]]; then
        echo ""
        echo "⚠️  Proxy usage detected!"
        
        # Check if RCC binary exists
        if [ ! -f "$RCC_BINARY" ]; then
            echo ""
            echo "❌ RCC binary not found!"
            echo ""
            echo "When using a proxy, you must download RCC manually first."
            echo ""
            echo "Instructions:"
            echo "  1. Download RCC from:"
            echo "     macOS: $RCC_DOWNLOAD_URL/rcc_macos64"
            echo "     Linux: $RCC_DOWNLOAD_URL/rcc_linux64"
            echo ""
            echo "  2. Save the file here: $RCC_BINARY"
            echo "     (make sure to rename it to 'rcc')"
            echo ""
            echo "  3. Make the file executable:"
            echo "     chmod +x $RCC_BINARY"
            echo ""
            echo "  4. Run this script again."
            echo ""
            exit 1
        fi
        
        echo "✅ RCC binary found, proceeding with proxy configuration..."
        create_proxy_profile
        import_proxy_profile
        switch_proxy_profile "$RCC_PROFILE_NAME"
        USE_PROXY="true"
    else
        echo "✅ No proxy will be used."
    fi
}

function download_rcc() {
    print_section "RCC Download"
    
    # Skip download if proxy is used (RCC must already exist)
    if [ "$USE_PROXY" == "true" ]; then
        echo "⏭️  Skipping download (proxy is configured, RCC already present)"
        return
    fi
    
    if [ -f "$RCC_BINARY" ]; then
        echo "✅ RCC already present: $RCC_BINARY"
        return
    fi
    
    echo "Downloading RCC..."
    if [ "$(uname)" == "Darwin" ]; then
        echo "Detected system: macOS"
        curl -L "$RCC_DOWNLOAD_URL/rcc_macos64" -o "$RCC_BINARY"
    else
        echo "Detected system: Linux"
        curl -L "$RCC_DOWNLOAD_URL/rcc_linux64" -o "$RCC_BINARY"
    fi
    
    if [ $? -ne 0 ]; then
        echo "❌ Error downloading RCC"
        exit 1
    fi
    
    chmod +x "$RCC_BINARY"
    echo "✅ RCC successfully downloaded and made executable"
}

function rcc_cleanup() {
    print_section "RCC Cleanup"
    echo "Running RCC cleanup..."
    "$RCC_BINARY" config cleanup --all
    if [ $? -ne 0 ]; then
        echo "❌ RCC cleanup failed"
        exit 1
    fi
    echo "✅ RCC cleanup successful"
}

function disable_telemetry() {
    print_section "Disable Telemetry"
    echo "Disabling telemetry..."
    "$RCC_BINARY" configure identity -t
    if [ $? -ne 0 ]; then
        echo "❌ Error disabling telemetry"
        exit 1
    fi
    echo "✅ Telemetry disabled"
}

function create_proxy_profile() {
    echo ""
    read -p "Enter the HTTP proxy address (example: http://myproxy.local:3128): " http_proxy_address
    read -p "Enter the HTTPS proxy address (example: http://myproxy.local:3128): " https_proxy_address

    cat > rcc-proxy-profile.yaml <<EOF
name: $RCC_PROFILE_NAME
description: RCC proxy profile
settings:
  certificates:
    verify-ssl: true
  network:
    no-proxy: 'localhost,127.0.0.1'
    https-proxy: '$https_proxy_address'
    http-proxy: '$http_proxy_address'
  meta:
    name: $RCC_PROFILE_NAME
    description: RCC proxy profile
    source: Robotmk
EOF

    export http_proxy="$http_proxy_address"
    export https_proxy="$https_proxy_address"
    echo "✅ Proxy profile created"
}

function import_proxy_profile() {
    echo "Importing proxy profile..."
    if [ ! -f rcc-proxy-profile.yaml ]; then
        echo "❌ rcc-proxy-profile.yaml does not exist"
        exit 1
    fi
    "$RCC_BINARY" config import -f rcc-proxy-profile.yaml
    if [ $? -ne 0 ]; then
        echo "❌ Failed to import proxy profile"
        exit 1
    fi
    echo "✅ Proxy profile imported"
}

function switch_proxy_profile() {
    PROFILE_NAME="$1"
    echo "Switching to proxy profile: $PROFILE_NAME"
    "$RCC_BINARY" config switch --profile "$PROFILE_NAME"
    "$RCC_BINARY" config switch | grep "Currently active profile is: $PROFILE_NAME" > /dev/null
    if [ $? -ne 0 ]; then
        echo "❌ Failed to switch proxy profile."
        echo "Current profiles:"
        "$RCC_BINARY" config switch
        exit 1
    fi
    echo "✅ Switched to proxy profile: $PROFILE_NAME"
}

function run_rccdiag() {
    print_section "Network Diagnostics"
    echo "Running RCC network diagnostics (this can take a few moments)..."
    echo "--- RCC NETDIAG OUTPUT START ---"
    "$RCC_BINARY" netdiag --checks rccdiag.yaml
    local exit_code=$?
    echo "--- RCC NETDIAG OUTPUT END ---"
    if [ $exit_code -ne 0 ]; then
        echo "❌ Network diagnostics failed"
        exit 1
    fi
    echo "✅ Network diagnostics successful"
}

function create_env() {
    ENV_NAME="$1"
    ENV_DESC="$2"
    print_section "Creating environment: $ENV_NAME ($ENV_DESC)"
    echo "Creating environment with robot-$ENV_NAME.yaml..."
    echo "--- RCC HOLOTREE OUTPUT START ---"
    "$RCC_BINARY" holotree vars --robot "envs/robot-$ENV_NAME.yaml"
    local exit_code=$?
    echo "--- RCC HOLOTREE OUTPUT END ---"
    if [ $exit_code -ne 0 ]; then
        echo "❌ Error creating environment: $ENV_NAME"
        unset_proxy
        exit 1
    fi
    echo "✅ Environment $ENV_NAME created successfully"
}

function unset_proxy() {
    if [ "$USE_PROXY" == "true" ]; then
        print_section "Restoring Default Profile"
        echo "Switching back to default profile..."
        "$RCC_BINARY" config switch --noprofile

        "$RCC_BINARY" config switch | grep "Currently active profile is: default" > /dev/null
        if [ $? -ne 0 ]; then
            echo "⚠️  Warning: Failed to switch back to default profile."
            echo "Current profiles:"
            "$RCC_BINARY" config switch
        else
            echo "✅ Restored default profile"
        fi
    fi
}

main