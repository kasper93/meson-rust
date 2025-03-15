#!/bin/bash -eu

export CC=$TARGET-gcc-posix
export AS=$TARGET-gcc-posix
export CXX=$TARGET-g++-posix
export AR=$TARGET-ar
export NM=$TARGET-nm
export RANLIB=$TARGET-ranlib

if [[ "$TARGET" == "i686-"* ]]; then
    export WINEPATH="`$CC -print-file-name=`;/usr/$TARGET/lib"
fi

fam=x86_64
[[ "$TARGET" == "i686-"* ]] && fam=x86
cat >"crossfile" <<EOF
[built-in options]
buildtype = 'release'
[properties]
skip_sanity_check = ${SKIP_SANITY_CHECK}
[binaries]
c = '${CC}'
cpp = '${CXX}'
rust = ['rustc', '--target', '${RUST_TARGET}']
ar = '${AR}'
strip = '${TARGET}-strip'
pkgconfig = 'pkg-config'
pkg-config = 'pkg-config'
windres = '${TARGET}-windres'
dlltool = '${TARGET}-dlltool'
nasm = 'nasm'
exe_wrapper = 'wine'
[host_machine]
system = 'windows'
cpu_family = '${fam}'
cpu = '${TARGET%%-*}'
endian = 'little'
EOF

meson setup build --cross-file crossfile
meson compile -C build

wine ./build/rust_test.exe
