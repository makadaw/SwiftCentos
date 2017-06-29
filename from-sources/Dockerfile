FROM centos:7
MAINTAINER Alex <makadaw@gmail.com>

RUN yum -q update -y && \
    yum -q install -y \
    which \
    python-2.7 \
    python-devel-2.7 \
    sudo 

#install epel-release, wget
RUN sudo yum -q -y install epel-release wget

#get updated packages from Fedora
RUN wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/b/binutils-2.26-18.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/c/clang-3.8.0-1.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/c/clang-devel-3.8.0-1.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/c/clang-libs-3.8.0-1.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/c/cpp-6.1.1-2.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/gcc-6.1.1-2.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/gcc-c++-6.1.1-2.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/glibc-2.23.1-7.fc24.i686.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/glibc-2.23.1-7.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/glibc-all-langpacks-2.23.1-7.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/glibc-common-2.23.1-7.fc24.x86_64.rpm >/dev/null 2>&1  && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/glibc-devel-2.23.1-7.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/g/glibc-headers-2.23.1-7.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/i/isl-0.14-5.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/libgcc-6.1.1-2.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/libgomp-6.1.1-2.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/libmpc-1.0.2-5.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/libstdc++-6.1.1-2.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/libstdc++-devel-6.1.1-2.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/llvm-3.8.0-1.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/llvm-devel-3.8.0-1.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/llvm-libs-3.8.0-1.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/m/mpfr-3.1.4-1.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Everything/x86_64/os/Packages/l/libtool-2.4.6-11.fc24.x86_64.rpm >/dev/null 2>&1 && \
    wget https://copr-be.cloud.fedoraproject.org/results/lebauce/Darling/fedora-22-x86_64/libkqueue-2.0.1-1/libkqueue-2.0.1-1.x86_64.rpm >/dev/null 2>&1 && \
    wget https://copr-be.cloud.fedoraproject.org/results/lebauce/Darling/fedora-22-x86_64/libkqueue-2.0.1-1/libkqueue-devel-2.0.1-1.x86_64.rpm >/dev/null 2>&1

#install binutils
RUN sudo yum -q install -y binutils-2.26-18.fc24.x86_64.rpm

#install development tools
RUN sudo yum -q install -y cpp-6.1.1-2.fc24.x86_64.rpm \
    gcc-6.1.1-2.fc24.x86_64.rpm \
    gcc-c++-6.1.1-2.fc24.x86_64.rpm \
    clang-3.8.0-1.fc24.x86_64.rpm \
    clang-devel-3.8.0-1.fc24.x86_64.rpm \
    clang-libs-3.8.0-1.fc24.x86_64.rpm \
    glibc-2.23.1-7.fc24.i686.rpm \
    glibc-2.23.1-7.fc24.x86_64.rpm \
    glibc-all-langpacks-2.23.1-7.fc24.x86_64.rpm \
    glibc-common-2.23.1-7.fc24.x86_64.rpm \
    glibc-devel-2.23.1-7.fc24.x86_64.rpm \
    glibc-headers-2.23.1-7.fc24.x86_64.rpm \
    isl-0.14-5.fc24.x86_64.rpm \
    libgcc-6.1.1-2.fc24.x86_64.rpm \
    libgomp-6.1.1-2.fc24.x86_64.rpm \
    libmpc-1.0.2-5.fc24.x86_64.rpm \
    libstdc++-6.1.1-2.fc24.x86_64.rpm \
    libstdc++-devel-6.1.1-2.fc24.x86_64.rpm \
    llvm-3.8.0-1.fc24.x86_64.rpm \
    llvm-devel-3.8.0-1.fc24.x86_64.rpm \
    llvm-libs-3.8.0-1.fc24.x86_64.rpm \
    mpfr-3.1.4-1.fc24.x86_64.rpm \
    libtool-2.4.6-11.fc24.x86_64.rpm \
    libkqueue-2.0.1-1.x86_64.rpm \
    libkqueue-devel-2.0.1-1.x86_64.rpm

#install other required packages
RUN sudo yum -q install -y \
    git \
    cmake \
    cmake3 \
    ninja-build \
    re2c \
    uuid-devel \
    libuuid-devel \
    icu \
    libicu \
    libicu-devel \
    libbsd-devel \
    libedit-devel \
    libxml2-devel \
    sqlite-devel \
    swig \
    python-libs \
    ncurses-devel \
    python-devel \
    pkgconfig \
    autoconf \
    automake

ARG SWIFT_PLATFORM=centos7
# swift-4.0-branch
ARG SWIFT_BRANCH=swift-3.1-branch 
ARG SWIFT_VERSION=swift-3.1-RELEASE

ENV SWIFT_PLATFORM=$SWIFT_PLATFORM \
    SWIFT_BRANCH=$SWIFT_BRANCH \
    SWIFT_VERSION=$SWIFT_VERSION \
    SWIFT_WORK_DIR=/root/swift-work

WORKDIR /root/swift-work

COPY ./build-scripts ./build-scripts
RUN chmod +x build-scripts/setup.sh
RUN chmod +x build-scripts/build.sh
RUN ./build-scripts/setup.sh
# RUN ./build-scripts/build.sh
