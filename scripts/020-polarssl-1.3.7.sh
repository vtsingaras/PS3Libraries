#!/bin/sh -e

# Automatic build script for polarssl
# for psl1ght, playstaion 3 open source sdk.
#
# Originally Created by Felix Schulze on 08.04.11.
# Updated by Spork Schivago on 11.12.13.
# Ported to PS3Libraries to compile with psl1ght.
# Copyright 2010 Felix Schulze. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
###########################################################################
# Change values here
#
VERSION="1.3.7"
#
###########################################################################
#
# Don't change anything here
CURRENTPATH=`pwd`
ARCH="powerpc64"
PLATFORM="PS3"

## Download the source code.
wget --continue --no-check-certificate -O polarssl-${VERSION}.gpl.tgz  https://polarssl.org/download/polarssl-${VERSION}-gpl.tgz?do=yes;

## Unpack the source code.
rm -Rf polarssl-${VERSION} && tar -zxvf polarssl-${VERSION}.gpl.tgz && cd polarssl-${VERSION}

## Patch the source code.
if [ -f ../../patches/polarssl-${VERSION}.patch ]; then
  echo "patching polarssl-${VERSION}...";
  cat ../../patches/polarssl-${VERSION}.patch | patch -p1;
fi

echo "Building polarssl for ${PLATFORM} ${SDKVERSION} ${ARCH}"

echo "Please stand by..."

export CC=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-gcc
export LD=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ld
export CPP=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-cpp
export CXX=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-g++
export AR=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ar
export AS=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-as
export NM=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-nm
export CXXCPP=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-cpp
export RANLIB=${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ranlib
export LDFLAGS=" -L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib -lrt -llv2 -lnet"
export SYS_LDFLAGS=" -lnet -lsysmodule"
export CFLAGS=" -I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include -mcpu=cell"


echo "Building polarssl..."
## Compile and install.
${MAKE:-make} no_test && ${MAKE:-make} install

echo "Building done."
