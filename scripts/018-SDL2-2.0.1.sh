#!/bin/sh -e
# SDL2-2.0.1.sh by Dan Peori (dan.peori@oopo.net) (Updated by Spork Schivago)

SDL2="SDL2-2.0.1"

## Download the source code.
wget --no-check-certificate http://libsdl.org/release/${SDL2}.tar.gz;

## Unpack the source code.
rm -Rf ${SDL2} && mkdir ${SDL2} && tar -zxvf ${SDL2}.tar.gz && cd ${SDL2}

## Patch the source if a patch exists.
if [ -f ../../patches/${SDL2}-PPU.patch ]; then
  echo "patching ${SDL2}..."
  cat ../../patches/${SDL2}-PPU.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu

## SDL requires we run autogen, so lets do that first.
./autogen.sh

## Change to the build directory
cd build-ppu

## Configure the build
CPPFLAGS="-I${PSL1GHT}/ppu/include -D__PSL1GHT__" \
CFLAGS="-O2 -Wall" \
LDFLAGS="-L${PSL1GHT}/ppu/lib" ../configure \
--prefix="${PS3DEV}/portlibs/ppu" --host=powerpc64-ps3-elf \
--enable-atomic=yes --enable-video-psl1ght=yes --enable-joystick=yes \
--enable-audio=yes

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
