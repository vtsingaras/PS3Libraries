#!/bin/sh -e
# SDL_libs.sh by Dan Peori (dan.peori@oopo.net) (Updated by Spork Schivago)

SDL_LIBS="SDL-libs"

## Check for the source code in the previous directory
## because we have no place to host it {:-(
if [ ! -f ../${SDL_LIBS}.tar.xz ]; then
  echo "This distribution must have the ${SDL-LIBS}.tar.xz file in the root directory of the PS3 Libraries...";
  exit
else
## We found our archive, move it to the build directory.
  cp ../${SDL_LIBS}.tar.xz .
fi


## Unpack the source code.
rm -Rf ${SDL_LIBS} && mkdir ${SDL_LIBS} && tar -xvJf ${SDL_LIBS}.tar.xz

## Create the build directory.
cd ${SDL_LIBS}

## Compile and install.
./sdl_libraries.sh
