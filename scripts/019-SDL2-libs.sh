#!/bin/sh -e
# SDL2_libs.sh Spork Schivago

SDL2_LIBS="SDL2-libs"

## Download the source code from our repository
git clone https://github.com/Spork-Schivago/${SDL2_LIBS}

## Create the build directory.
cd ${SDL2_LIBS}

## Compile and install.
./sdl2_libraries.sh
