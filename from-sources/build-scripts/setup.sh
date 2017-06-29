#!/bin/sh 
TAG=$SWIFT_VERSION
BRANCH=$SWIFT_BRANCH
OS_VERSION=7
SW_BUILD_DIR=$SWIFT_WORK_DIR

TIMESTAMP=`date +"%m-%d-%y.%H-%m"`

mkdir -p $SW_BUILD_DIR
mkdir -p $SW_BUILD_DIR/package
mkdir -p $SW_BUILD_DIR/symroot
mkdir -p $SW_BUILD_DIR/build

declare -a SWIFTREPOS=(\
        "https://github.com/apple/swift.git swift" \
        "https://github.com/apple/swift-llvm.git llvm" \
        "https://github.com/apple/swift-clang.git clang" \
        "https://github.com/apple/swift-lldb.git lldb" \
        "https://github.com/apple/swift-cmark.git cmark" \
        "https://github.com/apple/swift-llbuild.git llbuild" \
        "https://github.com/apple/swift-package-manager.git swiftpm" \
        "https://github.com/apple/swift-corelibs-xctest.git swift-corelibs-xctest"  \
        "https://github.com/apple/swift-corelibs-foundation.git swift-corelibs-foundation"\
        "https://github.com/apple/swift-corelibs-libdispatch.git swift-corelibs-libdispatch"\
        )
BUILDTHREADS=2


SW_BUILD_TEMP="buildbot_linux_${BRANCH}_fc${OS_VERSION}"

#substitute cmake3 for cmake
sudo mv /usr/bin/cmake /usr/bin/cmake2
sudo ln -s /usr/bin/cmake3 /usr/bin/cmake

#substitute ld.gold for ld
sudo rm /etc/alternatives/ld
sudo ln -s /usr/bin/ld.gold /etc/alternatives/ld

mkdir -p $SW_BUILD_DIR/package
mkdir -p $SW_BUILD_DIR/symroot
mkdir -p $SW_BUILD_DIR/build


pushd $SW_BUILD_DIR
for repo in "${SWIFTREPOS[@]}"; do
    repodir=$SW_BUILD_DIR/`echo $repo | cut -d " " -f 2`
    if [ ! -d "$repodir" ] ; then
    git clone -b $SWIFT_BRANCH $repo
    fi
done

if [ ! -d $SW_BUILD_DIR/ninja ] ; then
    git clone https://github.com/martine/ninja.git
fi

if [ ! -f /usr/bin/ninja ] ; then
        if [ -f /usr/bin/ninja-build ] ; then
        sudo ln -s /usr/bin/ninja-build /usr/bin/ninja
        fi
fi

mkdir -p $SW_BUILD_DIR/build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib
mkdir -p $SW_BUILD_DIR/build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/python2.7

if [ ! -d $SW_BUILD_DIR/build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/python2.7 ] ; then
if [ -d $SW_BUILD_DIR/build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/python2.7 ] ; then
    ln -s $SW_BUILD_DIR/build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/python2.7 $SW_BUILD_DIR/build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/python2.7
fi
fi