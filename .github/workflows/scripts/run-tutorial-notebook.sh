#!/bin/bash
# NOTE: this script is intended to be executed within a container.
set -eu

working_directory=$1
notebook_file=$2

if [ ! -f /.dockerenv ]; then
  echo 'error: this script must be executed within a container' >&2
  exit 1
fi

echo "::group::Install Papermill"
time {
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*
  # papermill 2.4.0+ is not compatible with jupyter-client 8.0.0+.
  # https://github.com/scikit-hep/pyhf/issues/2104
  python3 -m pip install --no-cache-dir papermill==2.6.0 jupyter-client==7.4.9
}
echo "::endgroup::"

cd "$working_directory"
papermill "$notebook_file" "$notebook_file"
