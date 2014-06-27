#!/bin/sh -e
# SDL-psl1ght.sh by Dan Peori (dan.peori@oopo.net)(Updated by Spork Schivago)
SDL1=sdl_psl1ght


## Download the source code.
wget --no-check-certificate https://github.com/zeldin/SDL_PSL1GHT/tarball/master -O ${SDL1}.tar.gz

## Unpack the source code.
rm -Rf sdl_psl1ght && mkdir sdl_psl1ght && tar --strip-components=1 --directory=sdl_psl1ght -zxvf ${SDL1}.tar.gz

## Create the build directory.
cd sdl_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} && ${MAKE:-make} install
