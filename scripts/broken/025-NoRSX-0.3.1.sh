#!/bin/sh -e
# libNoRSX.sh by wargio (wargio@libero.it) (Updated by Spork)
NORSX=NoRSX
VER=0.3.1

## Download the source code.
wget --no-check-certificate https://github.com/wargio/${NORSX}/tarball/master -O ${NORSX}.tar.gz;

## Unpack the source code.
rm -Rf ${NORSX}-${VER} && mkdir ${NORSX}-${VER} && tar --strip-components=1 --directory=${NORSX}-${VER} -zxvf ${NORSX}.tar.gz && cd ${NORSX}-${VER}

## Patch the source if a patch exists.
if [ -f ../../patches/${NORSX}-${VER}.patch ]; then
  echo "patching ${NORSX}-${VER}..."
  cat ../../patches/${NORSX}-${VER}.patch | patch -p1;
fi

## Compile and install.
${MAKE:-make}
