#!/bin/bash
set -eu
set -o pipefail

print_python_library_version() {
  name=$1
  module=$2
  python3 -c "import importlib.metadata; print('$name', importlib.metadata.version("madminer"))"
}

grep '^PRETTY_NAME' /etc/os-release | cut -d = -f 2 | tr -d '"'
root --version 2>&1 | head -1
python3 --version
python3 -c 'import importlib.metadata; print("MadMiner", importlib.metadata.version("madminer"))'
python3 -c 'import importlib.metadata; print("NumPy", importlib.metadata.version("numpy"))'
python3 -c 'import importlib.metadata; print("SciPy", importlib.metadata.version("scipy"))'
python3 -c 'import importlib.metadata; print("PyTorch", importlib.metadata.version("torch"))'
python3 -c 'import importlib.metadata; print("Matplotlib", importlib.metadata.version("matplotlib"))'
