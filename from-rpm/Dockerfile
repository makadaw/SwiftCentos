FROM centos:7
MAINTAINER Alex <makadaw@gmail.com>

RUN yum -q update -y && \
    yum -q install -y \
    which \
    sudo 
RUN yum -q install -y \ 
    rpm-build \
    ninja-build \
    libicu-devel \
    gcc-c++ \
    clang \
    cmake \
    libuuid-devel \
    libedit-devel \
    swig \
    pkgconfig \
    libbsd-devel \
    libxml2-devel \
    libsqlite3x-devel \
    python-devel \
    autoconf \
    automake \
    libtool \
    libcurl-devel \
    wget \
    git \
    libsqlite3x-devel

ENV BUILD_FOLDER=/root/rpmbuild

WORKDIR /root/swift-work

COPY ./build-scripts ./build-scripts
RUN chmod +x build-scripts/rpm-from-source.sh
RUN ./build-scripts/rpm-from-source.sh
# RUN rpmbuild -ba /root/rpmbuild/SPECS/swift.spec
