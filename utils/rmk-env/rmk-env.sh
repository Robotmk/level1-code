#!/bin/bash

# ================================
# Robotmk Environment Setup Tool
# ================================
# This script sets up Robot Framework environments using either RCC or CSM.
# All configuration files are embedded - no external files needed.
# Usage: ./rmk-env.sh <tool> <mode|args>
#   tool: rcc or csm
#   mode: test (full setup) or args to pass directly to tool

set -euo pipefail  # Exit on error, undefined variable, or pipe failure

# ================================
# Global Variables
# ================================

# Script configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "$0")"

# Tool selection (set via command line argument)
TOOL=""
TOOL_BINARY=""

# Test mode flag
TEST_MODE="false"
TEST_ENVS=()

# Pass-through mode (pass args directly to tool)
PASSTHROUGH_MODE="false"
PASSTHROUGH_ARGS=()

# RCC configuration
readonly RCC_DOWNLOAD_URL="https://github.com/elabit/robotmk/releases/download/v4.0.0-alpha-1"
readonly RCC_PROFILE_NAME="RCCTestProfile"

# CSM configuration
readonly CSM_VERSION="1.1.0"
readonly CSM_BASE_URL="https://github.com/Checkmk/csm/releases/download/${CSM_VERSION}"

# Proxy configuration
USE_PROXY="false"

# Environment paths
export ROBOCORP_HOME="$HOME/.robotmk/rcc-test"

# ================================
# Error Handling
# ================================

SCRIPT_ERROR=0

# Error handler - called on ERR trap
on_error() {
    SCRIPT_ERROR=1
}

# Exit handler - displays support information if an error occurred
on_exit() {
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

# Set up error handling traps
trap 'on_error' ERR
trap 'on_exit; cleanup_config_files' EXIT

# ================================
# Configuration Files (Embedded)
# ================================

# Create all necessary configuration files from embedded content
create_config_files() {
    local temp_dir="${SCRIPT_DIR}/.tmp_configs"
    
    # Create temporary directory for config files
    mkdir -p "$temp_dir"
    
    # Create robot-rf.yaml (RCC config for Robot Framework)
    cat > "$temp_dir/robot-rf.yaml" <<'EOF_ROBOT_RF'
tasks:
  noexec:
    shell: echo "not for execution as RCC task"

environmentConfigs:
  - conda-rf.yaml

artifactsDir: output
EOF_ROBOT_RF

    # Create robot-pw.yaml (RCC config for Robot Framework + Playwright)
    cat > "$temp_dir/robot-pw.yaml" <<'EOF_ROBOT_PW'
tasks:
  noexec:
    shell: echo "not for execution as RCC task"

environmentConfigs:
  - conda-pw.yaml

artifactsDir: output
EOF_ROBOT_PW

    # Create conda-rf.yaml (Conda config for simple RF environment)
    cat > "$temp_dir/conda-rf.yaml" <<'EOF_CONDA_RF'
channels:
- conda-forge
dependencies:
- python=3.12.3
- pip=23.2.1
- pip:
  - robotframework==7.2

EOF_CONDA_RF

    # Create conda-pw.yaml (Conda config for RF + Playwright environment)
    cat > "$temp_dir/conda-pw.yaml" <<'EOF_CONDA_PW'
channels:
- conda-forge
dependencies:
- python=3.12.3
- pip=23.2.1
- nodejs=22.11.0
- pip:
  - robotframework==7.2
  - robotframework-browser==19.12.4

rccPostInstall:
- rfbrowser init
EOF_CONDA_PW

    # Create rccdiag.yaml (RCC network diagnostics configuration)
    cat > "$temp_dir/rccdiag.yaml" <<'EOF_RCCDIAG'
network:
    dns-lookup:
    - anaconda.org
    - conda.anaconda.org
    - files.pythonhosted.org  
    - playwright.azureedge.net  
    - playwright-akamai.azureedge.net  
    - playwright-verizon.azureedge.net
    - registry.npmjs.org
    - pypi.org  
    - github.com
    - raw.githubusercontent.com
    - update.code.visualstudio.com
    - vscode.download.prss.microsoft.com
    - ms-vscode.gallery.vsassets.io
    - marketplace.visualstudio.com
    tls-verify:
    - anaconda.org
    - conda.anaconda.org
    - files.pythonhosted.org  
    - playwright.azureedge.net  
    - playwright-akamai.azureedge.net  
    - playwright-verizon.azureedge.net
    - registry.npmjs.org
    - pypi.org
    - github.com
    - raw.githubusercontent.com
    - update.code.visualstudio.com
    - vscode.download.prss.microsoft.com
    - ms-vscode.gallery.vsassets.io
    - marketplace.visualstudio.com
    head-request:
    - url: https://conda.anaconda.org/conda-forge/linux-64/repodata.json
      codes: [200]

EOF_RCCDIAG

    # Create robotmk-env-rf.yaml (CSM config for Robot Framework)
    cat > "$temp_dir/robotmk-env-rf.yaml" <<'EOF_ROBOTMK_ENV_RF'
channels:
  - conda-forge

dependencies:
  - python=3.12.3          
  - pip=23.2.1  
  - pip:
    # Python packages installed via pip
    - robotframework==7.3
EOF_ROBOTMK_ENV_RF

    # Create robotmk-env-pw.yaml (CSM config for Robot Framework + Playwright)
    cat > "$temp_dir/robotmk-env-pw.yaml" <<'EOF_ROBOTMK_ENV_PW'
channels:
- conda-forge
dependencies:
- python=3.12
- pip=23.2.1
- nodejs=22.11.0
- pip:
  - robotframework==7.1.1
  - robotframework-browser==19.12.4
EOF_ROBOTMK_ENV_PW

    # Create robotmk-setup-rf.yaml (CSM post-build for Robot Framework)
    cat > "$temp_dir/robotmk-setup-rf.yaml" <<'EOF_ROBOTMK_SETUP_RF'
# This file contains commands to be executed by the Robotmk Scheduler 
# AFTER the environment has been created. 
#

EOF_ROBOTMK_SETUP_RF

    # Create robotmk-setup-pw.yaml (CSM post-build for Robot Framework + Playwright)
    cat > "$temp_dir/robotmk-setup-pw.yaml" <<'EOF_ROBOTMK_SETUP_PW'
# This file contains commands to be executed by the Robotmk Scheduler 
# AFTER the environment has been created. 
#
post_build_commands:
 - name: rfbrowser_init
   command:
     - rfbrowser
     - init
EOF_ROBOTMK_SETUP_PW

    echo "$temp_dir"
}

# Clean up temporary configuration files
cleanup_config_files() {
    local temp_dir="${SCRIPT_DIR}/.tmp_configs"
    if [ -d "$temp_dir" ]; then
        rm -rf "$temp_dir"
    fi
}

# ================================
# Utility Functions
# ================================

# Print a header message
print_header() {
    echo ""
    echo "========================================="
    echo "$1"
    echo "========================================="
}

# Print a section message
print_section() {
    echo ""
    echo "-------------------------------------"
    echo ">>> $1"
    echo "-------------------------------------"
}

# Display usage information
show_usage() {
    cat << EOF
Usage: $SCRIPT_NAME <tool> <mode|args>

Description:
  This script manages Robot Framework environments for Robotmk using either RCC or CSM.

Arguments:
  tool        Environment tool to use: 'rcc' or 'csm'
              - rcc: Robocorp Control Room environment manager
              - csm: Checkmk Synthetic Monitoring tool (micromamba-based)

  mode/args   Required:
              - 'test': Run full setup and create test environments (interactive)
              - Any other args: Pass directly to the tool (assumes setup done)

Examples:
  # Test mode - full setup with environment creation:
  $SCRIPT_NAME rcc test              # Interactive environment selection
  $SCRIPT_NAME csm test              # Interactive environment selection
  
  # Pass-through mode - assumes setup is complete:
  $SCRIPT_NAME rcc version           # Pass command to RCC
  $SCRIPT_NAME rcc holotree list     # Pass command to RCC
  $SCRIPT_NAME rcc config switch     # Pass command to RCC
  $SCRIPT_NAME csm list              # Pass command to CSM
  $SCRIPT_NAME csm --help            # Pass --help to CSM

Environment Variables:
  ROBOCORP_HOME         Location for RCC/CSM data (default: ~/.robotmk/rcc-test)

The script bootstraps itself and downloads the required tool binarys if not present.
  
For more information, visit: https://robotmk.org

EOF
}

# Get the operating system type
get_os_type() {
    local os_type
    case "$(uname)" in
        Darwin)
            os_type="macos"
            ;;
        Linux)
            os_type="linux"
            ;;
        *)
            echo "❌ Unsupported operating system: $(uname)"
            exit 1
            ;;
    esac
    echo "$os_type"
}

# ================================
# Tool Management Functions
# ================================

# Verify that the tool binary exists and is executable
verify_tool() {
    local tool_name=$(echo "$TOOL" | tr '[:lower:]' '[:upper:]')
    
    if [ ! -f "$TOOL_BINARY" ]; then
        echo "❌ $tool_name binary not found at: $TOOL_BINARY"
        exit 1
    fi
    
    if [ ! -x "$TOOL_BINARY" ]; then
        echo "❌ $tool_name binary is not executable: $TOOL_BINARY"
        exit 1
    fi
    
    # Test if the tool can be executed
    if [ "$TOOL" == "rcc" ]; then
        if ! "$TOOL_BINARY" version &>/dev/null; then
            echo "❌ RCC could not be executed."
            echo "There might be a conflict with the QT tool 'rcc'."
            echo "Make sure the RCC binary is correct: $TOOL_BINARY"
            exit 1
        fi
    elif [ "$TOOL" == "csm" ]; then
        if ! "$TOOL_BINARY" --version &>/dev/null; then
            echo "❌ CSM could not be executed."
            echo "Make sure the CSM binary is correct: $TOOL_BINARY"
            exit 1
        fi
    fi
    
    echo "✅ $tool_name binary found and functional: $TOOL_BINARY"
}

# Download RCC binary
download_rcc() {
    local os_type
    
    print_section "RCC Download"
    
    # Skip download if proxy is used (RCC must already exist)
    if [ "$USE_PROXY" == "true" ]; then
        echo "⏭️  Skipping download (proxy is configured, RCC already present)"
        return
    fi
    
    if [ -f "$TOOL_BINARY" ]; then
        echo "✅ RCC already present: $TOOL_BINARY"
        return
    fi
    
    os_type=$(get_os_type)
    echo "Downloading RCC for $os_type..."
    
    local download_exit_code=0
    if [ "$os_type" == "macos" ]; then
        curl -L "$RCC_DOWNLOAD_URL/rcc_macos64" -o "$TOOL_BINARY" || download_exit_code=$?
    else
        curl -L "$RCC_DOWNLOAD_URL/rcc_linux64" -o "$TOOL_BINARY" || download_exit_code=$?
    fi
    
    if [ $download_exit_code -ne 0 ]; then
        echo "❌ Error downloading RCC"
        exit 1
    fi
    
    chmod +x "$TOOL_BINARY"
    echo "✅ RCC successfully downloaded and made executable"
}

# Download CSM binary
download_csm() {
    local os_type
    local download_url
    local temp_file
    
    print_section "CSM Download"
    
    # Skip download if proxy is used (CSM must already exist)
    if [ "$USE_PROXY" == "true" ]; then
        echo "⏭️  Skipping download (proxy is configured, CSM already present)"
        return
    fi
    
    if [ -f "$TOOL_BINARY" ]; then
        echo "✅ CSM already present: $TOOL_BINARY"
        return
    fi
    
    os_type=$(get_os_type)
    echo "Downloading CSM v${CSM_VERSION} for $os_type..."
    
    # Determine the correct download URL based on OS
    if [ "$os_type" == "macos" ]; then
        download_url="${CSM_BASE_URL}/csm-${CSM_VERSION}-x86_64-apple-darwin.tar.gz"
    else
        download_url="${CSM_BASE_URL}/csm-${CSM_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    fi
    
    # Download and extract
    temp_file="${SCRIPT_DIR}/csm-temp.tar.gz"
    temp_extract_dir="${SCRIPT_DIR}/.csm-extract"
    
    if ! curl -L "$download_url" -o "$temp_file"; then
        echo "❌ Error downloading CSM"
        rm -f "$temp_file"
        exit 1
    fi
    
    # Extract to temporary directory
    mkdir -p "$temp_extract_dir"
    if ! tar -xzf "$temp_file" -C "$temp_extract_dir"; then
        echo "❌ Error extracting CSM"
        rm -rf "$temp_file" "$temp_extract_dir"
        exit 1
    fi
    
    # Move the csm binary from release folder to script directory
    if [ -f "$temp_extract_dir/release/csm" ]; then
        mv "$temp_extract_dir/release/csm" "$TOOL_BINARY"
    elif [ -f "$temp_extract_dir/csm" ]; then
        mv "$temp_extract_dir/csm" "$TOOL_BINARY"
    else
        echo "❌ CSM binary not found in archive"
        rm -rf "$temp_file" "$temp_extract_dir"
        exit 1
    fi
    
    # Clean up temp files
    rm -rf "$temp_file" "$temp_extract_dir"
    
    # Make executable
    chmod +x "$TOOL_BINARY"
    echo "✅ CSM successfully downloaded and made executable"
}

# Download the appropriate tool binary
download_tool() {
    if [ "$TOOL" == "rcc" ]; then
        download_rcc
    elif [ "$TOOL" == "csm" ]; then
        download_csm
    else
        echo "❌ Unknown tool: $TOOL"
        exit 1
    fi
}

# ================================
# RCC-Specific Functions
# ================================

# Clean up RCC caches and configurations
rcc_cleanup() {
    print_section "RCC Cleanup"
    echo "Running RCC cleanup..."
    
    if ! "$TOOL_BINARY" config cleanup --all; then
        echo "❌ RCC cleanup failed"
        exit 1
    fi
    
    "$TOOL_BINARY" ht ls
    echo "✅ RCC cleanup successful"
}

# Disable RCC telemetry
disable_telemetry() {
    print_section "Disable Telemetry"
    echo "Disabling telemetry..."
    
    if ! "$TOOL_BINARY" configure identity -t; then
        echo "❌ Error disabling telemetry"
        exit 1
    fi
    
    echo "✅ Telemetry disabled"
}

# Run RCC network diagnostics
run_rccdiag() {
    local config_dir="$1"
    
    print_section "Network Diagnostics"
    echo "Running RCC network diagnostics (this can take a few moments)..."
    echo "--- RCC NETDIAG OUTPUT START ---"
    
    "$TOOL_BINARY" netdiag --checks "$config_dir/rccdiag.yaml"
    local exit_code=$?
    
    echo "--- RCC NETDIAG OUTPUT END ---"
    
    if [ $exit_code -ne 0 ]; then
        echo "❌ Network diagnostics failed"
        exit 1
    fi
    
    echo "✅ Network diagnostics successful"
}

# ================================
# Proxy Configuration Functions
# ================================

# Configure proxy settings (RCC only)
set_proxy() {
    local use_proxy
    local os_type
    
    print_section "Proxy Configuration"
    
    # CSM doesn't require proxy configuration
    if [ "$TOOL" == "csm" ]; then
        echo "ℹ️  CSM uses system proxy settings automatically"
        return
    fi
    
    read -p "Are you behind a proxy? (y/n): " use_proxy
    
    if [[ "$use_proxy" =~ ^[YyJj] ]]; then
        echo ""
        echo "⚠️  Proxy usage detected!"
        
        # Check if tool binary exists
        if [ ! -f "$TOOL_BINARY" ]; then
            echo ""
            echo "❌ $TOOL binary not found!"
            echo ""
            echo "When using a proxy, you must download $TOOL manually first."
            echo ""
            
            os_type=$(get_os_type)
            
            if [ "$TOOL" == "rcc" ]; then
                echo "Instructions for RCC:"
                echo "  1. Download RCC from:"
                if [ "$os_type" == "macos" ]; then
                    echo "     $RCC_DOWNLOAD_URL/rcc_macos64"
                else
                    echo "     $RCC_DOWNLOAD_URL/rcc_linux64"
                fi
                echo ""
                echo "  2. Save the file here: $TOOL_BINARY"
                echo "     (make sure to rename it to 'rcc')"
            fi
            
            echo ""
            echo "  3. Make the file executable:"
            echo "     chmod +x $TOOL_BINARY"
            echo ""
            echo "  4. Run this script again."
            echo ""
            exit 1
        fi
        
        echo "✅ $TOOL binary found, proceeding with proxy configuration..."
        create_proxy_profile
        import_proxy_profile
        switch_proxy_profile "$RCC_PROFILE_NAME"
        USE_PROXY="true"
    else
        echo "✅ No proxy will be used."
    fi
}

# Create proxy profile configuration file
create_proxy_profile() {
    local http_proxy_address
    local https_proxy_address
    
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

# Import proxy profile into RCC
import_proxy_profile() {
    echo "Importing proxy profile..."
    
    if [ ! -f rcc-proxy-profile.yaml ]; then
        echo "❌ rcc-proxy-profile.yaml does not exist"
        exit 1
    fi
    
    if ! "$TOOL_BINARY" config import -f rcc-proxy-profile.yaml; then
        echo "❌ Failed to import proxy profile"
        exit 1
    fi
    
    echo "✅ Proxy profile imported"
}

# Switch to proxy profile in RCC
switch_proxy_profile() {
    local profile_name="$1"
    
    echo "Switching to proxy profile: $profile_name"
    
    "$TOOL_BINARY" config switch --profile "$profile_name"
    
    if ! "$TOOL_BINARY" config switch | grep -q "Currently active profile is: $profile_name"; then
        echo "❌ Failed to switch proxy profile."
        echo "Current profiles:"
        "$TOOL_BINARY" config switch
        exit 1
    fi
    
    echo "✅ Switched to proxy profile: $profile_name"
}

# Restore default profile (RCC only)
unset_proxy() {
    if [ "$USE_PROXY" == "true" ] && [ "$TOOL" == "rcc" ]; then
        print_section "Restoring Default Profile"
        echo "Switching back to default profile..."
        
        "$TOOL_BINARY" config switch --noprofile

        if ! "$TOOL_BINARY" config switch | grep -q "Currently active profile is: default"; then
            echo "⚠️  Warning: Failed to switch back to default profile."
            echo "Current profiles:"
            "$TOOL_BINARY" config switch
        else
            echo "✅ Restored default profile"
        fi
    fi
}

# ================================
# Environment Selection Functions
# ================================

# Ask user which environments to create test versions of
select_test_environments() {
    local rf_choice
    local pw_choice
    
    print_section "Test Environment Selection"
    echo "Select which environments you want to create test versions of:"
    echo ""
    
    # Ask for simple RF environment
    read -p "Create test version of simple Robot Framework environment? (y/n): " rf_choice
    if [[ "$rf_choice" =~ ^[YyJj] ]]; then
        TEST_ENVS+=("rf")
    fi
    
    # Ask for RF + Playwright environment
    read -p "Create test version of Robot Framework + Playwright environment? (y/n): " pw_choice
    if [[ "$pw_choice" =~ ^[YyJj] ]]; then
        TEST_ENVS+=("pw")
    fi
    
    echo ""
    
    if [ ${#TEST_ENVS[@]} -eq 0 ]; then
        echo "⚠️  No environments selected. Exiting."
        exit 0
    fi
    
    echo "✅ Selected environments: ${TEST_ENVS[*]}"
}

# ================================
# Environment Creation Functions
# ================================

# Create environment using RCC
create_env_rcc() {
    local env_name="$1"
    local env_desc="$2"
    local config_dir="$3"
    local config_file="$config_dir/robot-${env_name}.yaml"
    
    print_section "Creating RCC environment: $env_name ($env_desc)"
    
    if [ ! -f "$config_file" ]; then
        echo "❌ Configuration file not found: $config_file"
        exit 1
    fi
    
    echo "Creating environment with robot-${env_name}.yaml..."
    echo "--- RCC HOLOTREE OUTPUT START ---"
    
    "$TOOL_BINARY" holotree vars --robot "$config_file"
    local exit_code=$?
    
    echo "--- RCC HOLOTREE OUTPUT END ---"
    
    if [ $exit_code -ne 0 ]; then
        echo "❌ Error creating environment: $env_name"
        unset_proxy
        exit 1
    fi
    
    echo "✅ Environment $env_name created successfully"
}

# Create environment using CSM
create_env_csm() {
    local env_name="$1"
    local env_desc="$2"
    local config_dir="$3"
    local env_file="$config_dir/robotmk-env-${env_name}.yaml"
    local setup_file="$config_dir/robotmk-setup-${env_name}.yaml"
    
    print_section "Creating CSM environment: $env_name ($env_desc)"
    
    if [ ! -f "$env_file" ]; then
        echo "❌ Environment configuration file not found: $env_file"
        exit 1
    fi
    
    if [ ! -f "$setup_file" ]; then
        echo "❌ Setup configuration file not found: $setup_file"
        exit 1
    fi
    
    echo "Creating environment with robotmk-env-${env_name}.yaml and robotmk-setup-${env_name}.yaml..."
    echo "--- CSM OUTPUT START ---"
    
    "$TOOL_BINARY" env create --env-file "$env_file" --setup-file "$setup_file"
    local exit_code=$?
    
    echo "--- CSM OUTPUT END ---"
    
    if [ $exit_code -ne 0 ]; then
        echo "❌ Error creating environment: $env_name"
        exit 1
    fi
    
    echo "✅ Environment $env_name created successfully"
}

# Create environment with the selected tool
create_env() {
    local env_name="$1"
    local env_desc="$2"
    local config_dir="$3"
    
    if [ "$TOOL" == "rcc" ]; then
        create_env_rcc "$env_name" "$env_desc" "$config_dir"
    elif [ "$TOOL" == "csm" ]; then
        create_env_csm "$env_name" "$env_desc" "$config_dir"
    else
        echo "❌ Unknown tool: $TOOL"
        exit 1
    fi
}

# ================================
# Command Line Argument Parsing
# ================================

# Parse command line arguments
parse_arguments() {
    # Check if at least one argument provided
    if [ $# -lt 1 ]; then
        echo "❌ Error: Missing required argument"
        echo ""
        show_usage
        exit 1
    fi
    
    # First argument must be the tool
    TOOL="$1"
    shift
    
    # Validate tool selection
    case "$TOOL" in
        rcc|csm)
            TOOL_BINARY="$SCRIPT_DIR/$TOOL"
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "❌ Error: Invalid tool '$TOOL'"
            echo ""
            show_usage
            exit 1
            ;;
    esac
    
    # Check for test mode or pass-through mode
    if [ $# -gt 0 ]; then
        if [ "$1" == "test" ]; then
            TEST_MODE="true"
            shift
        else
            # Any other args means pass-through mode
            PASSTHROUGH_MODE="true"
            PASSTHROUGH_ARGS=("$@")
        fi
    else
        # No additional args - show usage
        echo "❌ Error: Missing mode or arguments"
        echo ""
        echo "You must specify either:"
        echo "  - 'test' to run full setup and create environments"
        echo "  - Arguments to pass directly to $TOOL"
        echo ""
        show_usage
        exit 1
    fi
}

# ================================
# Main Execution Function
# ================================

# Main execution function
main() {
    local tool_display=$(echo "$TOOL" | tr '[:lower:]' '[:upper:]')
    local config_dir
    
    # Handle pass-through mode - just execute the tool with args
    if [ "$PASSTHROUGH_MODE" == "true" ]; then
        print_header "Executing $tool_display Command"
        echo "Running: $TOOL_BINARY ${PASSTHROUGH_ARGS[*]}"
        echo ""
        
        # Check if tool exists
        if [ ! -f "$TOOL_BINARY" ]; then
            echo "❌ $tool_display binary not found at: $TOOL_BINARY"
            echo ""
            echo "In pass-through mode, the tool must already exist."
            echo "Please run '$SCRIPT_NAME $TOOL test' first to set up the environment."
            exit 1
        fi
        
        # Execute the tool with provided arguments
        "$TOOL_BINARY" "${PASSTHROUGH_ARGS[@]}"
        exit $?
    fi
    
    # Test mode - full setup
    print_header "Robotmk Environment Setup - $tool_display (TEST MODE)"
    
    echo "This script sets up Robot Framework environments using $tool_display."
    echo "Running in TEST MODE - creates test versions of selected environments."
    echo ""
    echo "Environment:"
    echo "  Tool: $tool_display"
    echo "  Binary: $TOOL_BINARY"
    echo "  ROBOCORP_HOME: $ROBOCORP_HOME"
    echo "  Mode: Test"
    echo ""
    
    # Ask user which environments to create
    select_test_environments
    echo ""
    
    # Create configuration files
    print_section "Preparing Configuration Files"
    echo "Creating embedded configuration files..."
    config_dir=$(create_config_files)
    echo "✅ Configuration files ready in temporary directory"
    echo ""
    
    # Tool-specific workflow
    if [ "$TOOL" == "rcc" ]; then
        echo "Setup steps:"
        echo "  1. Proxy configuration (optional)"
        echo "  2. RCC download (if required)"
        echo "  3. RCC cleanup"
        echo "  4. Disable telemetry"
        echo "  5. Network diagnostics"
        echo "  6. Create selected test environments"
        echo ""
        
        set_proxy
        download_tool
        verify_tool
        rcc_cleanup
        disable_telemetry
        run_rccdiag "$config_dir"
        
        # Create only selected environments
        local env_count=1
        local total_envs=${#TEST_ENVS[@]}
        for env_name in "${TEST_ENVS[@]}"; do
            create_env "$env_name" "Environment $env_count/$total_envs" "$config_dir"
            ((env_count++))
        done
        
        unset_proxy
        
    elif [ "$TOOL" == "csm" ]; then
        echo "Setup steps:"
        echo "  1. Proxy detection (system settings used)"
        echo "  2. CSM download (if required)"
        echo "  3. Create selected test environments"
        echo ""
        
        set_proxy  # Will just display info for CSM
        download_tool
        verify_tool
        
        # Create only selected environments
        local env_count=1
        local total_envs=${#TEST_ENVS[@]}
        for env_name in "${TEST_ENVS[@]}"; do
            create_env "$env_name" "Environment $env_count/$total_envs" "$config_dir"
            ((env_count++))
        done
    fi
    
    print_header "✅ Test environments created successfully"
}

# ================================
# Script Entry Point
# ================================

# Parse command line arguments
parse_arguments "$@"

# Run main function
main
