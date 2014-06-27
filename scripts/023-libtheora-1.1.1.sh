#!/bin/sh -e
# libtheora-1.1.1.sh by dhewg (dhewg@wiibrew.org) (Updated by Spork Schivago)

LIBTHEORA="libtheora-1.1.1"

## Download the source code.
wget --continue http://downloads.xiph.org/releases/theora/${LIBTHEORA}.tar.bz2;

## Unpack the source code.
rm -Rf ${LIBTHEORA} && tar -xvjf ${LIBTHEORA}.tar.bz2 && cd ${LIBTHEORA}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBTHEORA}.patch ]; then
  echo "patching ${LIBTHEORA}..."
  cat ../../patches/${LIBTHEORA}.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" \
--host="powerpc64-ps3-elf" --disable-shared --disable-examples \
--with-sdl-prefix=${PS3DEV}/portlibs/ppu

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
