# WebKitRequirements
> Third party packages required for building the open source WebKit port for Windows.

## Setup

WebKitRequirements uses [vcpkg](https://github.com/microsoft/vcpkg) to drive
building the libraries. A helper script, `Install-Vcpkg.ps1`, configures
`vcpkg` to be able to build the repository.

```powershell
> Install-Vcpkg.ps1 -vcpkgPath <path-to-vcpkg> [-update]
```

The script clones `vcpkg` at the given location if it is not already there. If
the `vcpkg` repository was already checked out at that location the script does
not automatically update the sources. An optional flag, `-update`, is required
to trigger a `git pull`.

After the repository is ready the script will copy over any resources from the
`vcpkg` checkout that are required to do the build. View the
[Install-Vcpkg.ps1](Install-Vcpkg.ps1) script for additional options.

## Building

After installing `vcpkg` the requirements can be fully built using the
`Install-Requirements` script, which is just a wrapper around `vcpkg` which
builds the listed ports. A default is chosen based on the triplet, for windows
[WindowsRequirements.json](WindowsRequirements.json) is used.

```powershell
> Install-Requirements.ps1 -triplet <triplet-file>
```

After the script runs the requirements will be built in the expected manner for
use within WebKit. View the
[Install-Requirements.ps1](Install-Requirements.ps1) script for additional
options.

Ports can be manually built using `vcpkg` directly. The
`Install-Requirements.ps1` is just provided as a convenience for fully building
the requirements.

```powershell
> vcpkg.exe install <port> --triplet <triplet>
```

## Current Versions

| Library | Version | Release Date |
|---|:---:|:---:|
| [icu](http://site.icu-project.org) | 74.1 | 2023-10-31 |
| [zlib](https://github.com/zlib-ng/zlib-ng) | 2.1.5 | 2023-11-27 |
| [brotli](https://github.com/google/brotli) | 1.1.0 | 2023-08-31 |
| [libressl](https://www.libressl.org) | 3.8.2 | 2023-11-02 |
| [nghttp2](https://nghttp2.org) | 1.58.0 | 2023-10-27 |
| [nghttp3](https://github.com/ngtcp2/nghttp3) | 1.1.0 | 2023-11-25 |
| [ngtcp2](https://github.com/ngtcp2/ngtcp2) | 1.1.0 | 2023-11-25 |
| [c-ares](https://c-ares.org) | 1.25.0 | 2024-01-04 |
| [curl](https://curl.se) | 8.5.0 | 2023-12-06 |
| [libxml2](http://xmlsoft.org) | 2.12.2 | 2023-12-05 |
| [libxslt](http://xmlsoft.org/libxslt) | 1.1.39 | 2023-11-16 |
| [lcms](https://www.littlecms.com/) | 2.16.0 | 2023-12-03 |
| [highway](https://github.com/google/highway) | 1.0.7 | 2023-08-30 |
| [libpng](http://www.libpng.org/pub/png/libpng.html) | 1.6.40 | 2023-06-21 |
| [libjpeg-turbo](http://libjpeg-turbo.virtualgl.org) | 3.0.1 | 2023-10-16 |
| [libwebp](https://github.com/webmproject/libwebp) | 1.3.2 | 2023-09-13 |
| [libjxl](https://github.com/libjxl/libjxl) | 0.8.2 | 2023-06-14 |
| [sqlite](http://sqlite.org) | 3.44.2 | 2023-11-24 |
| [woff2](https://github.com/google/woff2) | 1.0.2 | 2017-11-13 |
| [freetype](https://www.freetype.org) | 2.13.2 | 2023-08-25 |
| [harfbuzz](https://github.com/harfbuzz/harfbuzz) | 8.3.0 | 2023-11-11 |
| [pixman](http://www.pixman.org) | 0.42.2 | 2022-11-02 |
| [cairo](https://gitlab.freedesktop.org/cairo/cairo) | 1.18.0 | 2023-09-23 |
| [libpsl](https://github.com/rockdaboot/libpsl) | 0.21.2 | 2022-12-26 |
