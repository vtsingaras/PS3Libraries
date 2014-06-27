#!/bin/sh -e
# jpeg-9.sh by Dan Peori (danpeori@oopo.net) (Updated by Spork Schivago)

JPEG="jpegsrc.v9"

## Download the source code.
wget --continue http://www.ijg.org/files/${JPEG}.tar.gz;

## Unpack the source code.
rm -Rf ${JPEG} && mkdir ${JPEG} &&
tar --strip-components=1 --directory=${JPEG} -zxvf ${JPEG}.tar.gz && cd ${JPEG}

## Patch the source if a patch exists.
if [ -f ../../patches/${JPEG}-PPU.patch ]; then
  echo "patching ${ZLIB}..."
  cat ../../patches/${JPEG}-PPU.patch | patch -p1;
fi
## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install

