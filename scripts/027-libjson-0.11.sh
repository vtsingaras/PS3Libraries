#!/bin/sh -e
# libjson-c.sh by Mohammad Haseeb (mmhaqs@gmail.com)
JSONC=json-c-0.11

## Download the source code.
wget --no-check-certificate https://s3.amazonaws.com/json-c_releases/releases/${JSONC}.tar.gz;

## Unpack the source code.
rm -Rf ${JSONC} && mkdir ${JSONC} && tar -zxvf ${JSONC}.tar.gz && cd ${JSONC}

## Patch the source if a patch exists.
if [ -f ../../patches/${JSONC}.patch ]; then
  echo "patching ${JSONC}..."
  cat ../../patches/${JSONC}.patch | patch -p1;
fi

## Remove json-c leftover config files
if [ -f config.status -o -f config.log -o -f config.h ]; then
  rm -f config.status config.log config.h
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
AR="powerpc64-ps3-elf-ar" \
CC="powerpc64-ps3-elf-gcc" \
RANLIB="powerpc64-ps3-elf-ranlib" \
CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" \
ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes \
--enable-static --disable-shared


## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
