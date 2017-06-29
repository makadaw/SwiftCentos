#!/bin/sh 
echo on 

sudo ln -s /usr/bin/ninja-build /usr/bin/ninja

RPMTOPDIR=$BUILD_FOLDER
mkdir -p $RPMTOPDIR/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
TAG=3.1-RELEASE
VER=3.1
REL=RELEASE3.1

wget https://github.com/apple/swift/archive/swift-${TAG}.tar.gz -O swift.tar.gz >/dev/null 2>&1
mv swift.tar.gz $RPMTOPDIR/SOURCES/swift.tar.gz
wget https://github.com/apple/swift-corelibs-foundation/archive/swift-${TAG}.tar.gz -O corelibs-foundation.tar.gz >/dev/null 2>&1
mv corelibs-foundation.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-integration-tests/archive/swift-${TAG}.tar.gz -O swift-integration-tests.tar.gz >/dev/null 2>&1
mv swift-integration-tests.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-corelibs-xctest/archive/swift-${TAG}.tar.gz -O corelibs-xctest.tar.gz >/dev/null 2>&1
mv corelibs-xctest.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-clang/archive/swift-${TAG}.tar.gz -O clang.tar.gz >/dev/null 2>&1
mv clang.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-package-manager/archive/swift-${TAG}.tar.gz -O package-manager.tar.gz >/dev/null 2>&1
mv package-manager.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-lldb/archive/swift-${TAG}.tar.gz -O lldb.tar.gz >/dev/null 2>&1
mv lldb.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-llvm/archive/swift-${TAG}.tar.gz -O llvm.tar.gz >/dev/null 2>&1
mv llvm.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-llbuild/archive/swift-${TAG}.tar.gz -O llbuild.tar.gz >/dev/null 2>&1
mv llbuild.tar.gz $RPMTOPDIR/SOURCES/
wget https://github.com/apple/swift-cmark/archive/swift-${TAG}.tar.gz -O cmark.tar.gz >/dev/null 2>&1
mv cmark.tar.gz $RPMTOPDIR/SOURCES/

sed -e "s/%{ver}/$VER/" -e "s/%{rel}/$REL/" -e "s/%{tag}/$TAG/" swift.spec > $RPMTOPDIR/SPECS/swift.spec

# starting with 3.1
git clone https://github.com/ninja-build/ninja.git $RPMTOPDIR/BUILD/ninja
pushd $RPMTOPDIR/BUILD/ninja
git checkout release
popd

# XYZZY - test for me
pushd $RPMTOPDIR/BUILD
rm -rf swift
git clone https://github.com/tachoknight/swift swift
pushd swift
git checkout xyzzy-swift-3.1-RELEASE
popd
popd

# Explicit checkout of libdispatch so we can also initialize
# the submodules
git clone https://github.com/apple/swift-corelibs-libdispatch swift-corelibs-libdispatch
pushd swift-corelibs-libdispatch
git checkout swift-3.1-branch
git submodule init; git submodule update
popd
