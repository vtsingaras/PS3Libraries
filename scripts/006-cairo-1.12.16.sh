#!/bin/sh -e
# cairo-1.12.16.sh by Dan Peori (danpeori@oopo.net) (Updated by Spork Schivago)

CAIRO="cairo-1.12.16"

## Download the source code.
wget --continue http://cairographics.org/releases/${CAIRO}.tar.xz;

## Unpack the source code.
rm -Rf ${CAIRO} && tar -xvJf ${CAIRO}.tar.xz && cd ${CAIRO}

## Patch the source if a patch exists.
if [ -f ../../patches/${CAIRO}-PPU.patch ]; then
  echo "patching ${CAIRO}..."
  cat ../../patches/${CAIRO}-PPU.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
CFLAGS="-DCAIRO_NO_MUTEX" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
LIBS="-liberty -lbfd" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" --enable-fc="no" \
--enable-xlib="no" --enable-xcb="no" --disable-shared --disable-valgrind --enable-gobject="no" --verbose

## Compile and install.
${MAKE:-make} -j4 V=1 && ${MAKE:-make} install
