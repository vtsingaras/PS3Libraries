#!/bin/sh -e
# freetype-2.5.0.1.sh by Dan Peori (danpeori@oopo.net) (Updated by Spork Schivago)

FREETYPE="freetype-2.5.0.1"

## Download the source code.
wget --continue http://download.savannah.gnu.org/releases/freetype/freetype-old/${FREETYPE}.tar.gz;

## Unpack the source code.
rm -Rf ${FREETYPE} && tar -zxvf ${FREETYPE}.tar.gz && cd ${FREETYPE}

## Patch the source if a patch exists.
if [ -f ../../patches/${FREETYPE}-PPU.patch ]; then
  echo "patching ${FREETYPE}..."
  cat ../../patches/${FREETYPE}-PPU.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## freetype insists on GNU make
which gmake 1>/dev/null 2>&1 && MAKE=gmake

## Configure the build.
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
LIBPNG_LDFLAGS="-I${PS3DEV}/portlibs/ppu/include/libpng16" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
GNUMAKE=$MAKE ../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
