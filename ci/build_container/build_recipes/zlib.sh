#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${SCRIPT_DIR}/versions.sh"

stage_source ZLIB

mkdir build; cd build

cmake -G "Ninja" \
  -DCMAKE_INSTALL_PREFIX:PATH="$THIRDPARTY_BUILD" \
  ..
ninja
ninja install

if [[ "${OS}" == "Windows_NT" ]]; then
  cp "CMakeFiles/zlibstatic.dir/zlibstatic.pdb" "$THIRDPARTY_BUILD/lib/zlibstatic.pdb"
fi
