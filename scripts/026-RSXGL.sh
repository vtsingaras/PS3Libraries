#!/bin/sh -e
# RSXGL.sh by Spork Schivago (SporkSchivago@gmail.com)
RSXGL=RSXGL

## Remove the directory and download the source code.
rm -rf ${RSXGL}
git clone https://github.com/ChillyWillyGuru/${RSXGL}

## Change to the source code.
cd ${RSXGL} && mkdir build-ppu

## Patch the source if a patch exists.
if [ -f ../../patches/${RSXGL}.patch ]; then
  echo "patching ${RSXGL}..."
  cat ../../patches/${RSXGL}.patch | patch -p1;
fi

## Run Autogen
echo -ne "Running autogen on ${RSXGL}, please wait : "
NOCONFIGURE=1 ./autogen.sh >./autogen_${RSXGL}.log 2>&1  || \
	(echo "Error!" && \
	(tail ./autogen_${RSXGL}.log || true) && \
	echo -ne "\n\nSee autogen_${RSXGL}.log for details.\n" && \
	exit 1)

## Enter the build directory
cd build-ppu

## Configure the build.
../configure --prefix="${PS3DEV}/portlibs"

## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
