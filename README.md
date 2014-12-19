FFmpeg for WinRT 
=============

This project can be used for building ffmpeg in WinRT platform. You can use this project to build static library, or dynamic library (which linked as static library, because of the WinRT project cannot load non-WinRT dynamic library).  

## Build

1. You need to prepare [MinGW+MSYS](http://www.mingw.org/) environment, and install mingw-developer-toolkit, mingw32-base, msys-base. 
2. Download [gas-preprocessor.pl](https://github.com/FFmpeg/gas-preprocessor) , and copy it into  msys bin folder. 
3. Run VS2013 ARM Cross Tools Command Prompt first, and then run the msys from the command prompt. If you want to build x86 version, you should launch VS2013 x86 Native Tools Command Prompt first.
4. In the msys command prompt, open the ffmpeg folder, and run build_ffmpeg_msvc.sh. You can choice release or debug version, like `sh build_ffmpeg_msvc.sh release`, the default is debug. Run `sh build_ffmpeg_msvc.sh quick`, it means make ffmpeg without configure.

## Libraries

* `libavcodec` provides implementation of a wider range of codecs.
* `libavformat` implements streaming protocols, container formats and basic I/O access.
* `libavutil` includes hashers, decompressors and miscellaneous utility functions.
* `libavfilter` provides a mean to alter decoded Audio and Video through chain of filters.
* `libavdevice` provides an abstraction to access capture and playback devices.
* `libswresample` implements audio mixing and resampling routines.
* `libswscale` implements color conversion and scaling routines.

## License

FFmpeg codebase is mainly LGPL-licensed with optional components licensed under
GPL. Please refer to the LICENSE file for detailed information.
