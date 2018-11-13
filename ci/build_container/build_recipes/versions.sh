#!/bin/bash

# Assuming all urls are GitHub SHA archives
function stage_source {
  local file_url="${1}_FILE_URL"
  local file_sha256="${1}_FILE_SHA256"
  local git_sha="${1}_GIT_SHA"
  local file_name="${!git_sha}".tar.gz

  curl "${!file_url}" -sLo "$file_name" \
    && echo "${!file_sha256}" "$file_name" | sha256sum --check

  tar xf "$file_name"
  cd $(tar tf "$file_name" | head -n1 )
}

# use commit where cmake 3.6 feature removed. Unblocks Ubuntu 16.xx or below builds
# TODO (moderation) change back to tarball method on next benchmark release
BENCHMARK_GIT_REPO=https://github.com/google/benchmark.git
BENCHMARK_GIT_SHA=505be96ab23056580a3a2315abba048f4428b04e
BENCHMARK_FILE_URL=https://github.com/google/benchmark/archive/$BENCHMARK_GIT_SHA.tar.gz
BENCHMARK_FILE_SHA256=0de43b6eaddd356f1d6cd164f73f37faf2f6c96fd684e1f7ea543ce49c1d144e

# git tag cares-1_15_0
CARES_GIT_REPO=https://github.com/c-ares/c-ares.git
CARES_GIT_SHA=e982924acee7f7313b4baa4ee5ec000c5e373c30
CARES_FILE_URL=https://github.com/c-ares/c-ares/archive/$CARES_GIT_SHA.tar.gz
CARES_FILE_SHA256=e8c2751ddc70fed9dc6f999acd92e232d5846f009ee1674f8aee81f19b2b915a

# git tag gperftools-2.7
GPERFTOOLS_GIT_REPO=https://github.com/gperftools/gperftools.git
GPERFTOOLS_GIT_SHA=9608fa3bcf8020d35f59fbf70cd3cbe4b015b972
GPERFTOOLS_FILE_URL=https://github.com/gperftools/gperftools/archive/$GPERFTOOLS_GIT_SHA.tar.gz
GPERFTOOLS_FILE_SHA256=4a6488eeb9ab0c115b267929ca355de36de65f15d8ba95df75b23a4f258d9d0b

# git tag release-2.1.8-stable
# Maintainer provided source tarball does not contain cmake content so using Github tarball.
LIBEVENT_GIT_REPO=https://github.com/libevent/libevent.git
LIBEVENT_GIT_SHA=e7ff4ef2b4fc950a765008c18e74281cdb5e7668
LIBEVENT_FILE_URL=https://github.com/libevent/libevent/archive/$LIBEVENT_GIT_SHA.tar.gz
LIBEVENT_FILE_SHA256=7619b66f6aefab29af15676110e66c5d537265511e11a220442802cea84333c0

# git tag v2.0.5
LUAJIT_GIT_REPO=https://github.com/LuaJIT/LuaJIT.git
LUAJIT_GIT_SHA=0bf80b07b0672ce874feedcc777afe1b791ccb5a
LUAJIT_FILE_URL=https://github.com/LuaJIT/LuaJIT/archive/$LUAJIT_GIT_SHA.tar.gz
LUAJIT_FILE_SHA256=ecd9259c8beb062a9020775611815e419674641adbd195417eef2108454c9e16

# git tag v1.34.0
NGHTTP2_GIT_REPO=https://github.com/nghttp2/nghttp2.git
NGHTTP2_GIT_SHA=2b085815b787270b6942fc86a414edace12d40c5
NGHTTP2_FILE_URL=https://github.com/nghttp2/nghttp2/archive/$NGHTTP2_GIT_SHA.tar.gz
NGHTTP2_FILE_SHA256=86adcc6aa3861a3bba1a15ec0ed78f9a7039103785d89985cc7cb0abbee17968

# Pin to this commit to pick up fix for building on Visual Studio 15.8
YAMLCPP_GIT_REPO=https://github.com/jbeder/yaml-cpp.git
YAMLCPP_GIT_SHA=0f9a586ca1dc29c2ecb8dd715a315b93e3f40f79
YAMLCPP_FILE_URL=https://github.com/jbeder/yaml-cpp/archive/$YAMLCPP_GIT_SHA.tar.gz
YAMLCPP_FILE_SHA256=53dcffd55f3433b379fcc694f45c54898711c0e29159a7bd02e82a3e0253bac3

# git tag v1.2.11
ZLIB_GIT_REPO=https://github.com/madler/zlib.git
ZLIB_GIT_SHA=cacf7f1d4e3d44d871b605da3b647f07d718623f
ZLIB_FILE_URL=https://github.com/madler/zlib/archive/$ZLIB_GIT_SHA.tar.gz
ZLIB_FILE_SHA256=6d4d6640ca3121620995ee255945161821218752b551a1a180f4215f7d124d45

