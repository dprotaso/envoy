#!/bin/bash

set -e

if [[ "${OS}" == "Windows_NT" ]]; then
  exit 0
fi

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${SCRIPT_DIR}/versions.sh"

stage_source GPERFTOOLS

./autogen.sh

LDFLAGS="-lpthread" ./configure --prefix="$THIRDPARTY_BUILD" --enable-shared=no --enable-frame-pointers --disable-libunwind
make V=1 install
