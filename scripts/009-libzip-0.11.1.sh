#!/bin/sh -e
# libzip-0.11.1.sh by Dan Peori (danpeori@oopo.net) (Updated by Spork Schivago)

LIBZIP="libzip-0.11.1"

## Download the source code.
wget --continue http://www.nih.at/libzip/${LIBZIP}.tar.xz;

## Unpack the source code.
rm -Rf ${LIBZIP} && tar -xvJf ${LIBZIP}.tar.xz && cd ${LIBZIP}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBZIP}-PPU.patch ]; then
  echo "patching ${LIBZIP}..."
  cat ../../patches/${LIBZIP}-PPU.patch | patch -p1;
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
