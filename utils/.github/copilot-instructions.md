## About

**rcc-test** is a Bash/PowerShell script for course participants to test whether RCC can build an environment on their computer. This mitigates potential environment setup issues during the training course.

---

## Project Structure

### [rcc-test](../rcc-test/)

**Existing project** - Bash and PowerShell scripts focused on RCC testing.

- Contains `conda.yaml` and `robot.yaml` files in the `envs/` directory
- Includes configurations for:
  - Simple Robot Framework environment
  - Complex environment with Playwright
- Default behavior: attempts to create both environments
- Automatically downloads RCC if not present

### [rmk-env](../rmk-env/)

**New project** - A copy of the env-init script, intended to become the new standard.

**Your task:** Improve the Linux version first.

**Versions:**
- Bash version: Linux/macOS
- PowerShell version: Windows

**Requirements:**

Follow bash best practices:
- Use functions
- Implement error handling
- Add comprehensive comments
- Include logging functionality
- Keep code modular for easy future extensions
- Maintain readability

**Important:** For all improvements, first analyze the existing code. If something is unclear, ask me.

---

## Implementation Iterations

### 1. Tool Subcommand - Integrate CSM

The first argument specifies the environment tool:

**`rcc`** - As described above

**`csm`** - New CLI tool for Robotmk to create/manage environments on micromamba basis without RCC

Download URLs:
- **Windows:** `https://github.com/Checkmk/csm/releases/download/1.1.0/csm-1.1.0-x86_64-pc-windows-msvc.zip`
- **Linux:** `https://github.com/Checkmk/csm/releases/download/1.1.0/csm-1.1.0-x86_64-unknown-linux-musl.tar.gz`
- **macOS:** `https://github.com/Checkmk/csm/releases/download/1.1.0/csm-1.1.0-x86_64-apple-darwin.tar.gz`

**Requirements:**
- All subsequent arguments are passed to the respective tool
- The downloaded RCC/CSM binary should be placed in the same directory as the script
- CSM requires a different set of YAML files (will be provided - ask me)
- Update help documentation accordingly

### 2. Self-Contained Environment Configs

**Problem:** Having environment config files outside the script is not ideal.

**Solution:** Embed all YAML files within the script (using heredoc or similar) to create a single, shareable file.

**Requirements:**
- Update help documentation accordingly

### 3. Test Mode

**Behavior:** When the second argument is `test`, create test environments instead of production environments.

**Implementation:**
- In both RCC and CSM modes, when the second argument is `test`
- Prompt user interactively to select which test environments to create:
  - Simple Robot Framework environment
  - Robot Framework + Playwright environment

**Reference:** See existing test environment creation process in:
- PowerShell: [rcc-test.ps1](../rcc-test/rcc-test.ps1)
- Bash: [rcc-test.sh](../rcc-test/rcc-test.sh)

**Requirements:**
- Update help documentation accordingly

### 4. Argument Passing

**Behavior:** In both RCC and CSM modes, when the second argument is NOT `test`, all arguments are passed directly to the respective tool.

**Requirements:**
- Update help documentation accordingly