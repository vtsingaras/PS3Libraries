#!/bin/sh -e
# SDL2_libs.sh by Dan Peori (dan.peori@oopo.net) (Updated by Spork Schivago)

SDL2_LIBS="SDL2-libs"

## Check for the source code in the previous directory
## because we have no place to host it {:-(
if [ ! -f ../${SDL2_LIBS}.tar.xz ]; then
  echo "This distribution must have the ${SDL2-LIBS}.tar.xz file in the root directory of the PS3 Libraries...";
  exit
else
## We found our archive, move it to the build directory.
  cp ../${SDL2_LIBS}.tar.xz .
fi


## Unpack the source code.
rm -Rf ${SDL2_LIBS} && mkdir ${SDL2_LIBS} && tar -xvJf ${SDL2_LIBS}.tar.xz

## Create the build directory.
cd ${SDL2_LIBS}

## Compile and install.
./sdl2_libraries.sh
