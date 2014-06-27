#!/bin/sh -e
# SDL_libs.sh by Spork Schivago

SDL_LIBS="SDL-libs"

## Download the source code from our repository
git clone https://github.com/Spork-Schivago/${SDL_LIBS}

## Create the build directory.
cd ${SDL_LIBS}

## Compile and install.
./sdl_libraries.sh
