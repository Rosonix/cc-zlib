#!/bin/bash

set -e

ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TOOLCHAIN="${ROOT_DIR}/../mipsel-toolchain"
ROOTFS="${ROOT_DIR}/../rootfs"
OUT_DIR="${ROOTFS}/usr"

export TARGETMACH=mipsel-linux
export CROSS=mipsel-linux
export CROSS_COMPILE=${CROSS}

export CC="${TOOLCHAIN}/bin/${CROSS_COMPILE}-gcc"
export CXX="${TOOLCHAIN}/bin/${CROSS_COMPILE}-g++"
export AR="${TOOLCHAIN}/bin/${CROSS_COMPILE}-ar"
export AS="${TOOLCHAIN}/bin/${CROSS_COMPILE}-as"
export LD="${TOOLCHAIN}/bin/${CROSS_COMPILE}-ld"
export NM="${TOOLCHAIN}/bin/${CROSS_COMPILE}-nm"
export RANLIB="${TOOLCHAIN}/bin/${CROSS_COMPILE}-ranlib"

export CPPFLAGS=" -I${ROOTFS}/include -I${ROOTFS}/usr/include"
export LDFLAGS=" -L${ROOTFS}/lib -L${ROOTFS}/usr/lib"
export LIBS=" -lssl -lcrypto -lz"

./configure --prefix="${OUT_DIR}"
make
make install
