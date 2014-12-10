FFmpeg for WinRT 
=============

This project can be used for building ffmpeg in WinRT platform. You can use this project to build static library, or dynamic library which linked as static library, because of the WinRT project cannot load non-WinRT dynamic library.  

## Build

1. You need to prepare MinGW+MSYS environment, install msys-make, msys-bash, msys-m4, msys-perl. 
2. Download gas-preprocessor.pl from https://github.com/FFmpeg/gas-preprocessor , and copy it into  msys bin folder. 
3. Run VS2013 ARM Cross Tools Command Prompt first, and then run the msys from the command prompt. If you want to build x86 version, you should launch VS2013 x86 Native Tools Command Prompt
4. make sure link is in the Visual Studio, not from MSYS. You can find out by running 'which link' to see which link.exe you are using. You can rename the link.exe in MSYS.
5. Run build_ffmpeg_msvc.sh, you can choice arch x86 or arm, like "sh build_ffmpeg_msvc.sh arm", default is x86.

## Libraries

* `libavcodec` provides implementation of a wider range of codecs.
* `libavformat` implements streaming protocols, container formats and basic I/O access.
* `libavutil` includes hashers, decompressors and miscellaneous utility functions.
* `libavfilter` provides a mean to alter decoded Audio and Video through chain of filters.
* `libavdevice` provides an abstraction to access capture and playback devices.
* `libswresample` implements audio mixing and resampling routines.
* `libswscale` implements color conversion and scaling routines.

## Tools

* [ffmpeg](http://ffmpeg.org/ffmpeg.html) is a command line toolbox to
  manipulate, convert and stream multimedia content.
* [ffplay](http://ffmpeg.org/ffplay.html) is a minimalistic multimedia player.
* [ffprobe](http://ffmpeg.org/ffprobe.html) is a simple analisys tool to inspect
  multimedia content.
* Additional small tools such as `aviocat`, `ismindex` and `qt-faststart`.

## Documentation

The offline documentation is available in the **doc/** directory.

The online documentation is available in the main [website](http://ffmpeg.org)
and in the [wiki](http://trac.ffmpeg.org).

### Examples

Coding examples are available in the **doc/examples** directory.

## License

FFmpeg codebase is mainly LGPL-licensed with optional components licensed under
GPL. Please refer to the LICENSE file for detailed information.
