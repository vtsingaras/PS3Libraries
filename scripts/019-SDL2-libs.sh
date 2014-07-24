#!/bin/sh -e
# SDL2_libs.sh Spork Schivago

SDL2_LIBS="SDL2-libs"

## Remove the SDl2-libs and download the source code from our repository
rm -rf ${SDL2_LIBS}
git clone https://github.com/Spork-Schivago/${SDL2_LIBS}

## Create the build directory.
cd ${SDL2_LIBS}

## Compile and install.
./sdl2_libraries.sh
