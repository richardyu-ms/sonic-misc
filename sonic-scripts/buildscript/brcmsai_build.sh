#!/bin/bash
pushd ./output/x86-dnx-deb/hsdk/
git clean -xdf
popd
pushd ./output/x86-xgsall-deb/hsdk/
git clean -xdf
popd
git clean -xdf
git submodule update --init --recursive -f
git checkout -- *