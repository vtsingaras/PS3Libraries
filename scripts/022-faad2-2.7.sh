#!/bin/sh -e
# faad2-2.7.sh by dhewg (dhewg@wiibrew.org) (Updated by Spork Schivago)

FAAD2="faad2-2.7"

## Download the source code.
wget --continue http://downloads.sourceforge.net/faac/${FAAD2}.tar.gz;

## Unpack the source code.
rm -Rf ${FAAD2} && tar -zxvf ${FAAD2}.tar.gz && cd ${FAAD2}

## Patch the source if a patch exists.
if [ -f ../../patches/${FAAD2}.patch ]; then
  echo "patching ${FAAD2}..."
  cat ../../patches/${FAAD2}.patch | patch -p1;
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
