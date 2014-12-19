#!/bin/sh
arch=x86
archdir=
clean_build=true
enable_debug=true
for opt in "$@"
do
    case "$opt" in
    release)
            enable_debug=false
            ;;
    quick)
            clean_build=false
            ;;
    *)
            echo "Unknown Option $opt"
            exit 1
    esac
done

probe_arch() {
  if cl 2>&1 | grep -q 'ARM'; then
    arch=arm
  else
    arch=x86
  fi
  if $enable_debug ; then
    archdir=bin_${arch}d
  else
    archdir=bin_${arch}
  fi
}

make_dirs() (
  if [ ! -d $archdir/lib ]; then
    mkdir -p $archdir/lib
  fi
)

copy_libs() (
  cp lib*/*.dll $archdir
  cp lib*/*.pdb $archdir
  cp lib*/*.lib $archdir/lib
)

clean() (
  make distclean > /dev/null 2>&1
)

setup_environment() {
  link_path=$(dirname "$(which cl)")
  export PATH="$link_path:$PATH"
  if link 2>&1 | grep -q 'Microsoft'; then
    if gcc -v 2>&1 | grep -q 'version'; then
      return 
    else
      ## gas-preprocessor.pl required the cpp.exe 
      echo Can not found gcc, install the gcc in mingw and add it to path
      exit 1
    fi
  else
    ## make sure the link.exe in msvc default link, 
    ## not the link in msys 
    echo Set link failed, please rename the link.exe in msys bin folder
    exit 1
  fi
}

configure() (
  OPTIONS="
    --enable-shared                 \
    --disable-static                \
    --enable-gpl                    \
    --enable-w32threads             \
    --enable-winrtapi               \
    --disable-devices               \
    --disable-filters               \
    --disable-protocols             \
    --enable-network                \
    --disable-muxers                \
    --disable-hwaccels              \
    --enable-avresample             \
    --disable-encoders              \
    --disable-programs              \
    --enable-debug                  \
    --disable-doc                   \
    --enable-cross-compile          \
    --target-os=win32"

  EXTRA_CFLAGS="-D_WIN32_WINNT=0x0603 -MDd -D_WINAPI_FAMILY=WINAPI_FAMILY_PC_APP"
  EXTRA_LDFLAGS="-NODEFAULTLIB:libcmt -winmd -appcontaine"
case "$arch"  in
    x86)
        OPTIONS+="
            --arch=x86                      \
            --as=yasm"
            ;;
    arm)
        OPTIONS+="    
            --arch=arm                      \
            --cpu=armv7-a                   \
            --as=armasm                     \
            --enable-thumb"
        EXTRA_CFLAGS+=" -D_ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE  -D__ARM_PCS_VFP -D_ARM_"
            ;;
esac
  sh configure --toolchain=msvc --enable-debug --extra-cflags="${EXTRA_CFLAGS}" --extra-ldflags="${EXTRA_LDFLAGS}" ${OPTIONS}
)

build() (
  echo build ffmpeg
  make 
)

echo Building ffmpeg in MSVC Debug config...

probe_arch

echo "Found arch is $arch"

make_dirs

setup_environment

if $clean_build ; then
    clean
    
    echo config FFmpeg
    ## run configure, redirect to file because of a msys bug
    configure > config.out 2>&1
    CONFIGRETVAL=$?
    
    ## show configure output
    cat config.out
fi

## Only if configure succeeded, actually build
if ! $clean_build || [ ${CONFIGRETVAL} -eq 0 ]; then
  build &&
  copy_libs
fi

cd ..

