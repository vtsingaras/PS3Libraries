#!/bin/sh -e
# flac-1.3.0.sh by dhewg (dhewg@wiibrew.org) (Updated by Spork Schivago)

LIBFLAC="flac-1.3.0"

## Download the source code.
wget --continue http://downloads.xiph.org/releases/flac/${LIBFLAC}.tar.xz;

## Unpack the source code.
rm -Rf ${LIBFLAC} && tar -Jxvf ${LIBFLAC}.tar.xz && cd ${LIBFLAC}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBFLAC}.patch ]; then
  echo "patching ${LIBFLAC}..."
  cat ../../patches/${LIBFLAC}.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PS3DEV}/portlibs/ppu/lib" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" \
--disable-shared --enable-altivec --disable-xmms-plugin --disable-oggtest

## Compile (only parts to prevent failures in unrequired parts) and install.
${MAKE:-make} -C src/libFLAC -j4 && ${MAKE:-make} -C src/libFLAC++ && \
${MAKE:-make} -C src/libFLAC install && ${MAKE:-make} -C src/libFLAC++ install && \
${MAKE:-make} -C include install

