#!/bin/bash

# ================================
# RCC Test Environment Setup
# ================================

RCC_DOWNLOAD_URL="https://github.com/elabit/robotmk/releases/download/v4.0.0-alpha-1"
RCC_PROFILE_NAME="RCCTestProfile"
USE_PROXY="false"
RCC_BINARY="./rcc"

export ROBOCORP_HOME="${TMPDIR:-/tmp}/rcc-test"

function main() {
    set_proxy
    download_rcc
    rcc_cleanup
    disable_telemetry
    run_rccdiag
    create_env rf "Environment 1/2"
    create_env pw "Environment 2/2"
    unset_proxy
    echo "========================================="
    echo "✅ Test environments created successfully"
    echo "========================================="
}

function download_rcc() {
    if [ -f "$RCC_BINARY" ]; then
        echo "👉 RCC already downloaded."
        return
    fi
    echo "👉 Downloading RCC"
    if [ "$(uname)" == "Darwin" ]; then
        curl -L "$RCC_DOWNLOAD_URL/rcc_macos64" -o "$RCC_BINARY"
    else
        curl -L "$RCC_DOWNLOAD_URL/rcc_linux64" -o "$RCC_BINARY"
    fi
    chmod +x "$RCC_BINARY"
}

function rcc_cleanup() {
    echo "👉 Cleaning up RCC"
    "$RCC_BINARY" config cleanup --all
}

function disable_telemetry() {
    echo "👉 Disabling telemetry"
    "$RCC_BINARY" configure identity -t
}

function set_proxy() {
    read -p "Are you behind a proxy? (y/n): " use_proxy
    if [[ "$use_proxy" =~ ^[YyJj] ]]; then
        create_proxy_profile
        import_proxy_profile
        switch_proxy_profile "$RCC_PROFILE_NAME"
        USE_PROXY="true"
    fi
}

function create_proxy_profile() {
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
}

function import_proxy_profile() {
    echo "👉 Importing proxy profile"
    if [ ! -f rcc-proxy-profile.yaml ]; then
        echo "❌ rcc-proxy-profile.yaml does not exist"
        exit 1
    fi
    "$RCC_BINARY" config import -f rcc-proxy-profile.yaml
}

function switch_proxy_profile() {
    PROFILE_NAME="$1"
    echo "👉 Switching proxy profile"
    "$RCC_BINARY" config switch --profile "$PROFILE_NAME"
    "$RCC_BINARY" config switch | grep "Currently active profile is: $PROFILE_NAME" > /dev/null
    if [ $? -ne 0 ]; then
        echo "❌ Failed to switch proxy profile."
        echo "Current profiles:"
        "$RCC_BINARY" config switch
        exit 1
    fi
}

function run_rccdiag() {
    echo "👉 Running rccdiag"
    "$RCC_BINARY" netdiag --checks rccdiag.yaml
}

function create_env() {
    ENV_NAME="$1"
    ENV_DESC="$2"
    echo "👉 Creating $ENV_NAME environment ($ENV_DESC)"
    "$RCC_BINARY" holotree vars --robot "envs/robot-$ENV_NAME.yaml"
    if [ $? -ne 0 ]; then
        echo "❌ Failed to create environment."
        unset_proxy
        exit 1
    fi
}

function unset_proxy() {
    if [ "$USE_PROXY" == "true" ]; then
        echo "👉 Unsetting proxy profile"
        "$RCC_BINARY" config switch --noprofile

        "$RCC_BINARY" config switch | grep "Currently active profile is: default" > /dev/null
        if [ $? -ne 0 ]; then
            echo "❌ Failed to unset proxy profile."
            echo "Current profiles:"
            "$RCC_BINARY" config switch
            exit 1
        fi
    fi
}

main