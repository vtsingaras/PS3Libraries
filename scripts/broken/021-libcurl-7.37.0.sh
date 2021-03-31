#!/bin/sh
# libcurl-7.37.0 by KaKaRoTo
# modified by mhaqs for 7.31.0 release and cpp compatibility
# modified by Spork Schivago for 7.33.0 release
# modified by Spork Schivago for 7.37.0 release (2014-06-23)

LIBCURL="curl-7.37.0"
CA_CERT="/usr/ssl/certs/ca-bundle.crt"

## Download the source code.
wget --continue http://curl.haxx.se/download/${LIBCURL}.tar.gz;

## Unpack the source code.
rm -Rf ${LIBCURL} && tar -zxvf ${LIBCURL}.tar.gz && cd ${LIBCURL}

## Look for our root Certificate Authorities file.
if [ ! -f ${CA_CERT_PATH}${CA_CERT} ]; then
  echo "We couldn't find a list of root Certificate Authorites, We will try to create one now..."
  wget --continue -O certdata.txt "https://hg.mozilla.org/releases/mozilla-release/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt";
  perl ./lib/mk-ca-bundle.pl -n || { echo "$SCRIPT: Failed. Cannot find or create a ca-bundle.crt file";
                                     echo "Perhaps find one and try putting it in /usr/ssl/certs?"; exit 1; }
  CA_CERT="`pwd`/ca-bundle.crt";
  echo "Creation successful ${CA_CERT}"
fi

## Patch the source if a patch exists.
if [ -f ../../patches/${LIBCURL}.patch ]; then
  echo "patching ${LIBCURL}..."
  cat ../../patches/${LIBCURL}.patch | patch -p1;
fi

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build. 
  AR="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ar" \
  AS="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-as" \
  CC="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-gcc" \
  CPP="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-gcc -E" \
  CXX="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-g++" \
  CXXCPP="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-g++ -E" \
  LD="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ld" \
  NM="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-nm" \
  RANLIB="${PS3DEV}/ppu/bin/powerpc64-ps3-elf-ranlib" \
  CFLAGS="-O2 -Wall" \
  CXXFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include" \
  CPPFLAGS="-I${PSL1GHT}/ppu/include -I${PS3DEV}/portlibs/ppu/include -I${PSL1GHT}/ppu/include/net" \
  LDFLAGS="-L${PSL1GHT}/ppu/lib -L${PS3DEV}/portlibs/ppu/lib" \
  LIBS="-lnet -lsysutil -lsysmodule -lm" \
  PKG_CONFIG_LIBDIR="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
  PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig" \
  ../configure --prefix="${PS3DEV}/portlibs/ppu" --host="powerpc64-ps3-elf" \
  --without-ssl --with-polarssl="${PS3DEV}/portlibs/ppu/include/polarssl" \
  --includedir="${PS3DEV}/portlibs/ppu/include" --libdir="${PS3DEV}/portlibs/ppu/lib" \
  --with-ca-bundle="${CA_CERT}"

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
