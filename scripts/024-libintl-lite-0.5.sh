#!/bin/sh
## libintl-lite-0.5.sh (By Spork Schivago)

LIBINTL="libintl-lite-0.5"
CXX="powerpc64-ps3-elf-g++"
CXXFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include -Wall -mcpu=cell -c"
AR="powerpc64-ps3-elf-ar"
ARFLAGS="-cvq"

## Download the source code.
wget --continue http://downloads.sourceforge.net/project/libintl-lite/${LIBINTL}.tar.gz

## Unpack the source code.
rm -Rf ${LIBINTL} && tar -zxvf ${LIBINTL}.tar.gz && cd ${LIBINTL}

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBINTL}.patch ]; then
  echo "patching ${LIBINTL}..."
  cat ../../patches/${LIBINTL}.patch | patch -p1;
fi

## Create the build directory and copy the header file
mkdir build-lib && cd build-lib
cp ../libintl.h .

## Build static library libintl
echo -e "Compiling ${LIBINTL} and creating ${LIBINTL} static library"
echo "${CXX} ${CXXFLAGS} ../internal/libintl.cpp -o libintl.o"
${CXX} ${CXXFLAGS} ../internal/libintl.cpp -o libintl.o
echo "${AR} ${ARFLAGS} libintl.a libintl.o"
${AR} ${ARFLAGS} libintl.a libintl.o

## Install the finished library
echo -e "Installing ${LIBINTL} into ${PS3DEV}/portlibs/ppu/lib"
cp libintl.a ${PS3DEV}/portlibs/ppu/lib
cp libintl.h ${PS3DEV}/portlibs/ppu/include
