#!/bin/sh 
TAG=$SWIFT_VERSION
BRANCH=$SWIFT_BRANCH
SUDO="sudo"
SW_BUILD_DIR=$SWIFT_WORK_DIR
OS_VERSION=7
TIMESTAMP=`date +"%m-%d-%y.%H-%m"`

if [ "/root" == $HOME ]; then
  SUDO=""
fi

# Map some utils

if [ ! -f /usr/bin/gold ] ; then
  if [ -f /usr/bin/ld.gold ] ; then
    $SUDO ln -s /usr/bin/ld.gold /usr/bin/gold
  fi
fi

if [ ! -f /usr/bin/ninja ] ; then
  if [ -f /usr/bin/ninja-build ] ; then
    $SUDO ln -s /usr/bin/ninja-build /usr/bin/ninja
  fi
fi

mkdir -p $SW_BUILD_DIR/install
pushd $SW_BUILD_DIR

#sigh, git supidity

SW_BUILD_TEMP="buildbot_linux_${BRANCH}_fc${OS_VERSION}"

# sed -i '/#include <Block.h>/d' swift-corelibs-foundation/CoreFoundation/Base.subproj/CFBase.h
# sed -i 's/#include <Block.h>/#include <closure\/Block.h>/g' swift-corelibs-foundation/CoreFoundation/Collections.subproj/CFBasicHash.c
# sed -i 's/#include <Block.h>/#include <closure\/Block.h>/g' swift-corelibs-foundation/CoreFoundation/RunLoop.subproj/CFRunLoop.c
# sed -i 's/CachedVFile = {};/CachedVFile = {nullptr, nullptr};/g' swift/lib/Basic/SourceLoc.cpp

pushd $SW_BUILD_DIR/build-scripts

cat > ./mypreset.ini <<ZZZZ
[preset: my_buildbot_linux]
mixin-preset=mixin_linux_installation
build-subdir=$SW_BUILD_TEMP
lldb
release
test
validation-test
long-test
foundation
libdispatch
lit-args=-v
dash-dash
skip-test-lldb
skip-test-linux
skip-test-swiftpm
install-foundation
install-libdispatch
reconfigure
[preset: my_notest_buildbot_linux]
mixin-preset=mixin_lightweight_assertions
build-subdir=$SW_BUILD_TEMP
lldb
release
foundation
libdispatch
lit-args=-v
dash-dash
build-ninja
install-swift
install-lldb
install-llbuild
install-swiftpm
install-xctest
install-prefix=/usr
swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;swift-remote-mirror;sdk-overlay;license
build-swift-static-stdlib
build-swift-static-sdk-overlay
build-swift-stdlib-unittest-extra
# Executes the lit tests for the installable package that is created
# Assumes the swift-integration-tests repo is checked out
install-destdir=%(install_destdir)s
installable-package=%(installable_package)s
reconfigure
ZZZZ

cat ../swift/utils/build-presets.ini ./mypreset.ini > ./workpreset.ini
pushd $SW_BUILD_DIR

#cleanout the output directory

rm -rf $SW_BUILD_DIR/install/*

#Build the swift system

swift/utils/build-script --jobs 1 \
 --preset-file=./build-scripts/workpreset.ini \
 --preset=my_notest_buildbot_linux \
                install_destdir=$SW_BUILD_DIR/install \
                installable_package=$SW_BUILD_DIR/$BRANCH.$TIMESTAMP.fc$OS_VERSION.tar.gz


#Make lldb /lib and /lib64 the same to fool the tests.

$SUDO cp -r build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/* build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib
$SUDO cp -r build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/* build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64

if [ ! -f build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.3 ] ; then
  if [ -f  build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.4.0.0 ] ; then
    $SUDO unlink build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.3
    $SUDO cp build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.4.0.0 build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.3
  fi
 if [ -f  build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.3.9.0 ] ; then
    $SUDO unlink build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.3
    $SUDO cp build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.3.9.0 build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib/liblldb.so.3
  fi

fi

if [ ! -f build/buildbot_linux_fc$OS_VERSION/lldb-linux-x86_64/lib64/liblldb.so.3 ] ; then
  if [ -f  build/buildbot_linux_fc$OS_VERSION/lldb-linux-x86_64/lib64/liblldb.so.4.0.0 ] ; then
    $SUDO unlink build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/liblldb.so.3
    $SUDO cp build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/liblldb.so.4.0.0 build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/liblldb.so.3
  fi
 if [ -f  build/buildbot_linux_fc$OS_VERSION/lldb-linux-x86_64/lib64/liblldb.so.3.9.0 ] ; then
    $SUDO unlink build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/liblldb.so.3
    $SUDO cp build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/liblldb.so.3.9.0 build/$SW_BUILD_TEMP/lldb-linux-x86_64/lib64/liblldb.so.3
  fi

fi


#Run the build a second time to run all the tests

# swift/utils/build-script --jobs 4 \
#         --preset-file=./workpreset.ini \
# 	--preset=my_buildbot_linux \
# 		install_destdir=$SW_BUILD_DIR/install \
# 		installable_package=$SW_BUILD_DIR/$BRANCH.$TIMESTAMP.fc$OS_VERSION.tar.gz

# if [ ! -f install/usr/lib/liblldb.so.3 ] ; then
#   if [ -f  install/usr/lib/liblldb.so.4.0.0 ] ; then
#     $SUDO unlink install/usr/lib/liblldb.so.3
#     $SUDO cp install/usr/lib/liblldb.so.4.0.0 install/usr/lib/liblldb.so.3
#   fi
# fi

# if [ ! -f install/usr/lib/liblldb.so.3 ] ; then
#   if [ -f  install/usr/lib/liblldb.so.3.9.0 ] ; then
#     $SUDO unlink install/usr/lib/liblldb.so.3
#     $SUDO cp install/usr/lib/liblldb.so.3.9.0 install/usr/lib/liblldb.so.3
#   fi
# fi


pushd $SW_BUILD_DIR/install
tar -cvzf $SW_BUILD_DIR/$BRANCH.$TIMESTAMP.fc$OS_VERSION.tar.gz .
popd