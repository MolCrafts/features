#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

check "crates" cargo --version
check "rust" rustc --version
check "python" python --version
check "conda" conda --version

# Report result
reportResults