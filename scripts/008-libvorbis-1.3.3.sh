#!/bin/sh -e
# libvorbis-1.3.3.sh by Dan Peori (danpeori@oopo.net) (Updated by Spork Schivago)

LIBVORBIS="libvorbis-1.3.3"

## Download the source code.
wget --continue http://downloads.xiph.org/releases/vorbis/${LIBVORBIS}.tar.xz;

## Unpack the source code.
rm -Rf ${LIBVORBIS} && tar -xvJf ${LIBVORBIS}.tar.xz && cd ${LIBVORBIS}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBVORBIS}-PPU.patch ]; then
  echo "patching ${LIBVORBIS}..."
  cat ../../patches/${LIBVORBIS}-PPU.patch | patch -p1;
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
