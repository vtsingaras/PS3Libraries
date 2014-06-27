#!/bin/sh -e
# libmikmod-3.3.6.sh by Marcus Comstedt <marcus@mc.pp.se> (Updated by Spork Schivago)

LIBMIKMOD_VER="3.3.6"
LIBMIKMOD="libmikmod-${LIBMIKMOD_VER}"

## Download the source code.
wget --continue "http://downloads.sourceforge.net/project/mikmod/libmikmod/${LIBMIKMOD_VER}/${LIBMIKMOD}.tar.gz?r=http%3A%2F%2Fmikmod.sourceforge.net%2F&ts=1403638643&use_mirror=iweb" -O ${LIBMIKMOD}.tar.gz || wget --continue "http://sourceforge.net/projects/mikmod/files/outdated_versions/libmikmod/${LIBMIKMOD_VER}/${LIBMIKMOD}.tar.gz/download" -O ${LIBMIKMOD}.tar.gz

## Unpack the source code.
rm -Rf ${LIBMIKMOD} && tar -zxvf ${LIBMIKMOD}.tar.gz && cd ${LIBMIKMOD}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBMIKMOD}-PPU.patch ]; then
  echo "patching ${LIBMIKMOD}..."
  cat ../../patches/${LIBMIKMOD}-PPU.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
CC="powerpc64-ps3-elf-gcc" LD="powerpc64-ps3-elf-ld" NM="powerpc64-ps3-elf-nm" \
RANLIB="powerpc64-ps3-elf-ranlib" STRIP="powerpc64-ps3-elf-strip" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" \
--disable-esd --disable-dl --disable-shared

## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
