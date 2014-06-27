#!/bin/sh -e
# WebP-0.3.1.sh (By Spork Schivago)

WEBP=libwebp-0.3.1

## Download the source code.
wget --continue https://webp.googlecode.com/files/${WEBP}.tar.gz

## Unpack the source code.
rm -Rf ${WEBP} && tar -xvzf ${WEBP}.tar.gz && cd ${WEBP}

## Patch the source code if a patch exists.
if [ -f ../../patches/${WEBP}.patch ]; then
  echo "patching ${WEBP}..."
  cat ../../patches/${WEBP}.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
LIBPNG_CONFIG="${PS3DEV}/portlibs/ppu/bin/libpng-config" \
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
LIBS="-lz -lm" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host=powerpc64-ps3-elf 

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
