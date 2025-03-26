#!/bin/bash

RCC_DOWNLOAD_URL="https://github.com/elabit/robotmk/releases/download/v4.0.0-alpha-1"
RCC_PROFILE_NAME="RCCTestProfile"
USE_PROXY="false"

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
    # check if rcc already exists
    if [ -f rcc ]; then
        return
    fi
    echo "👉 Downloading RCC"
    # detect if linux or mac
    if [ "$(uname)" == "Darwin" ]; then
        curl -L $RCC_DOWNLOAD_URL/rcc_macos64 -o rcc 2>/dev/null
    else
        curl -L $RCC_DOWNLOAD_URL/rcc_linux64 -o rcc 2>/dev/null
    fi
    chmod +x rcc
}

function rcc_cleanup() {
    echo "👉 Cleaning up RCC"
    rcc config cleanup --all
}

function disable_telemetry() {
    echo "👉 Disabling telemetry"
    rcc configure identity -t
}

function set_proxy() {

    # Nutzer fragen, ob ein Proxy verwendet werden soll
    read -p "Are you behind a proxy? (y/n): " use_proxy

    if [[ "$use_proxy" =~ ^[YyJj] ]]; then
        create_proxy_profile
        # Write to rcc config
        import_proxy_profile
        switch_proxy_profile $RCC_PROFILE_NAME
        USE_PROXY="true"
    fi
}

function create_proxy_profile() {
    read -r -d '' config <<EOF
name: RCC_PROFILE_NAME
description: RCC proxy profile
settings:
  certificates:
    verify-ssl: true
  network:
    no-proxy: 'localhost,127.0.0.1'
    https-proxy: 'HTTPS_PROXY'
    http-proxy: 'HTTP_PROXY'
  meta:
    name: RCC_PROFILE_NAME
    description: RCC proxy profile
    source: Robotmk
EOF
    echo $config
    read -p "Enter the HTTP proxy address (example: http://myproxy.local:3128): " http_proxy_address
    read -p "Enter the HTTPS proxy address (example: http://myproxy.local:3128): " https_proxy_address

    # Replace placeholders in config
    config="${config//HTTPS_PROXY/$https_proxy_address}"
    config="${config//HTTP_PROXY/$http_proxy_address}"
    config="${config//RCC_PROFILE_NAME/$RCC_PROFILE_NAME}"

    echo "$config" > "rcc-proxy-profile.yaml"
    export http_proxy=$http_proxy_address
    export https_proxy=$https_proxy_address
}

function switch_proxy_profile() {
    rcc configure switch --profile rcc-proxy-profile.yaml
}

function import_proxy_profile() {
    echo "👉 Importing proxy profile"
    if [ ! -f rcc-proxy-profile.yaml ]; then
        echo "❌ rcc-proxy-profile.yaml does not exist"
        exit 1
    fi
    rcc config import -f rcc-proxy-profile.yaml
}

function switch_proxy_profile() {
    echo "👉 Switching proxy profile"
    PROFILE_NAME="$1"
    rcc config switch --profile $PROFILE_NAME
    rcc config switch | grep "Currently active profile is: $PROFILE_NAME" > /dev/null
    if [ $? -ne 0 ]; then
        echo "❌ Failed to switch proxy profile."
        echo "Current profiles:"
        rcc config switch
        exit 1
    fi
}

function run_rccdiag() {
    echo "👉 Running rccdiag"
    rcc netdiag --checks rccdiag.yaml
}

function create_env() {
    ENV_NAME="$1"
    ENV_DESC="$2"
    echo "👉 Creating $ENV_NAME environment ($ENV_DESC)"
    rcc holotree vars --robot envs/robot-$ENV_NAME.yaml
    if [ $? -ne 0 ]; then
        echo "❌ Failed to create environment."
        unset_proxy
        exit 1
    fi
}

function unset_proxy() {
    if [ "$USE_PROXY" == "true" ]; then
        echo "👉 Unsetting proxy profile"
        rcc config switch --noprofile
    fi
    rcc config switch | grep "Currently active profile is: default" > /dev/null
    if [ $? -ne 0 ]; then
        echo "❌ Failed to unset proxy profile."
        echo "Current profiles:"
        rcc config switch
        exit 1
    fi
}

main