#!/bin/sh -e
# libxml2-2.9.1.sh by Dan Peori (danpeori@oopo.net) (Updated by Spork Schivago)

LIBXML2="libxml2-2.9.1"

## Download the source code.
wget --continue ftp://xmlsoft.org/libxml2/${LIBXML2}.tar.gz;

## Unpack the source code.
rm -Rf ${LIBXML2} && tar -zxvf ${LIBXML2}.tar.gz && cd ${LIBXML2}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBXML2}-PPU.patch ]; then
  echo "patching ${LIBXML2}..."
  cat ../../patches/${LIBXML2}-PPU.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" --enable-static --disable-shared --without-ftp --without-http --without-python

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
