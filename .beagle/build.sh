#!/usr/bin/env bash

set -ex

apk add --no-cache libvirt-dev rsync git
git config --global --add safe.directory $PWD

export KUBEVIRT_NO_BAZEL=true
export KUBEVIRT_VERSION="${BUILD_VERSION:-v1.3.1}"
# export KUBEVIRT_GO_BUILD_TAGS="-s -w"
export KUBEVIRT_RELEASE=true

./hack/build-go.sh install
./hack/build-copy-artifacts.sh
