#!/bin/sh -e
# libogg-1.3.1.sh by Dan Peori (danpeori@oopo.net) (Updated by Spork Schivago)

LIBOGG="libogg-1.3.1"

## Download the source code.
wget --continue http://downloads.xiph.org/releases/ogg/${LIBOGG}.tar.xz;

## Unpack the source code.
rm -Rf ${LIBOGG} && tar -xvJf ${LIBOGG}.tar.xz && cd ${LIBOGG}

## Patch the source if a patch exists
if [ -f ../../patches/${LIBOGG}-PPU.patch ]; then
  echo "patching ${LIBOGG}..."
  cat ../../patches/${LIBOGG}-PPU.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
