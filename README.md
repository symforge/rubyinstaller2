[![Build status](https://ci.appveyor.com/api/projects/status/7ack9ax1gihvn2hb/branch/master?svg=true)](https://ci.appveyor.com/project/larskanis/rubyinstaller2/branch/master)

# RubyInstaller2

This project provides an Installer for Ruby on Windows based on the MSYS2 toolchain.
It is licensed under the 3-clause Modified BSD License.

In contrast to the [RubyInstaller](https://github.com/oneclick/rubyinstaller/) it does not provide it's own DevKit, but makes use of the rich set of [MINGW libraries](https://github.com/Alexpux/MINGW-packages) of the [MSYS2 project](https://msys2.github.io/) .
It therefore integrates well into MSYS2 after installation on the target system to provide a build- and runtime environment for installation of gems with C-extensions.

This project is currently in a very early stage.
Testers and contributors are welcome.
The aim is to [build a successor to the RubyInstaller](https://github.com/oneclick/rubyinstaller/issues/352) .

## Using the Installer on a target system

- Download and install the latest RubyInstaller2: https://github.com/larskanis/rubyinstaller2/releases

That's already enough to use pure Ruby gems or fat binary gems for x64-mingw32 or x86-mingw32.
In order to build gems with C-extensions from the sources, MSYS2 development tools and MINGW compilers are required.
They can be downloaded and installed as part of the installation wizard or later per `ridk install` command.

### The `ridk` command
`ridk` is a cmd/powershell script which can be used to install MSYS2 components, to issue MSYS commands like `pacman` or to set environment variables for using MSYS2 development tools from the running shell.
See `ridk help` for further options:
```sh
    Usage:
        C:/Ruby24-x64/bin/ridk.cmd [option]

    Option:
        install                   Install MSYS2 and MINGW dev tools
        exec <command>            Execute a command within MSYS2 context
        enable                    Set environment variables for MSYS2
        disable                   Unset environment variables for MSYS2
        version                   Print RubyInstaller and MSYS2 versions
        help | --help | -? | /?   Display this help and exit
```

### Setup MSYS2 without `ridk`
MSYS2 can also be installed manually like so:
- Install the latest MSYS2 for x64 or x86 at per installer: https://msys2.github.io/

- Install development tools per MSYS2/MINGW shell window:
```sh
    pacman -Sy pacman
    pacman -S base-devel mingw-w64-i686-toolchain # for 32 bit RubyInstaller
    pacman -S base-devel mingw-w64-x86_64-toolchain # for 64 bit RubyInstaller
```

### Install gems with C-extensions and additional library dependencies

Installation of additional library dependencies for gems can be done per pacman as well. Exchange `mingw-w64-x86_64` by `mingw-w64-i686` for the 32-bit RubyInstaller.
For instance:

- Install pg.gem
```sh
    ridk exec pacman -S mingw-w64-x86_64-postgresql
    gem install pg --platform ruby
```

- Install sqlite3.gem
```sh
    ridk exec pacman -S mingw-w64-x86_64-sqlite3
    gem install sqlite3 --platform ruby
```

- Install nokogiri.gem
```sh
    ridk exec pacman -S mingw-w64-x86_64-libxslt
    gem install nokogiri --platform ruby -- --use-system-libraries --with-xml2-include=c:/msys64/mingw64/include/libxml2 --with-xslt-dir=c:/msys64/mingw64
```

The DLL search paths of Ruby processes are extended as soon as rubygems is used, so that MINGW DLLs are found at runtime.

## Build the Installer

The installer is regular built on [AppVeyor](https://ci.appveyor.com/project/larskanis/rubyinstaller2) for each push to the github respoitory.
It also executes the installer and runs all tests on it.
You can download the generated files as build artifacts.

To build RubyInstaller2 on your own machine:

- Make sure you have a working Ruby and Git installation

- Install the latest MSYS2 for x64 at the default path per installer: https://msys2.github.io/

- Install the mingw toolchain for x86 and x64 per MSYS2 shell:
```sh
    pacman -Sy pacman
    pacman -S base-devel  mingw-w64-x86_64-toolchain  mingw-w64-i686-toolchain
```

- Install the latest Inno-Setup (unicode): http://www.jrsoftware.org/isdl.php

- Run cmd.exe and add iscc.exe to PATH: ```set PATH=%PATH%;"c:\Program Files (x86)\Inno Setup 5"```

- Clone RubyInstaller2 and compile and package RubyInstallers for x86 and x64:
```sh
    git clone https://github.com/larskanis/rubyinstaller2
    cd rubyinstaller2
    rake
```

- If everything works well, you will find the final setup and archive files: `installer-inno/rubyinstaller-<VERSION>-<ARCH>.exe` and `archive-7z/rubyinstaller-<VERSION>-<ARCH>.7z`

- Try also `rake -T` to see the available build targets.

##Known Issues

* Avoid running this project in a PATH containing spaces.
* See also [the issue list](https://github.com/larskanis/rubyinstaller2/issues)
