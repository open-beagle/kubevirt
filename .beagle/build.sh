#!/usr/bin/env bash

set -ex

export KUBEVIRT_NO_BAZEL=true
export KUBEVIRT_VERSION="${BUILD_VERSION:-v1.3.1}"
# export KUBEVIRT_GO_BUILD_TAGS=
export KUBEVIRT_RELEASE=true

export KUBEVIRT_ARCH="${BUILD_ARCH:-amd64}"

rm -rf _out/cmd

if ! [ -d _out/dist/${KUBEVIRT_ARCH} ]; then

  apk add --no-cache \
    libvirt-dev rsync git

  git config --global --add safe.directory $PWD

  ./hack/build-go.sh install
  ./hack/build-copy-artifacts.sh

  mkdir -p _out/dist/${KUBEVIRT_ARCH}/
  mv _out/cmd/* _out/dist/${KUBEVIRT_ARCH}/
fi
