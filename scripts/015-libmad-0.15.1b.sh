#!/bin/sh -e
# libmad-0.15.1b.sh by dhewg (dhewg@wiibrew.org) (Updated by Spork Schivago)

LIBMAD_VERSION="0.15.1b"
LIBMAD="libmad-${LIBMAD_VERSION}"

## Download the source code.
wget --continue http://downloads.sourceforge.net/project/mad/libmad/${LIBMAD_VERSION}/${LIBMAD}.tar.gz;

## Unpack the source code.
rm -Rf ${LIBMAD} && tar -zxvf ${LIBMAD}.tar.gz && cd ${LIBMAD}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBMAD}.patch ]; then
  echo "patching ${LIBMAD}..."
  cat ../../patches/${LIBMAD}.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
CFLAGS="-O1 -mcpu=cell" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" \
--disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
