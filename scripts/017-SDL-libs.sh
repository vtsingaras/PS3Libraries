#!/bin/sh -e
# SDL_libs.sh by Spork Schivago

SDL_LIBS="SDL-libs"

## Remove the old directory if it exists  and download the source code from our repository
rm -rf ${SDL_LIBS}
git clone https://github.com/ChillyWillyGuru/${SDL_LIBS}

## Create the build directory.
cd ${SDL_LIBS}

## Compile and install.
./sdl_libraries.sh
