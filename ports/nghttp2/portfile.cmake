set(VERSION 1.46.0)

# Get archive
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nghttp2/nghttp2/archive/v${VERSION}.zip"
    FILENAME "nghttp2-${VERSION}.zip"
    SHA512 4646bed446cb44e95bb348f29ebea4d2147859b076b6d728167b2d67df136492743e6951628ea879ff1ef23899d8ed557f5547ef0dc3ff154267011845494408
)

# Extract archive
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${VERSION}
    PATCHES ${PATCHES}
)

# Run CMake build
set(BUILD_OPTIONS
    # ENABLE options
    -DENABLE_LIB_ONLY=ON
    -DENABLE_ASIO_LIB=OFF
    -DENABLE_FAILMALLOC=OFF
    -DENABLE_THREADS=OFF
    -DENABLE_WERROR=OFF
    # WITH options
    -DWITH_JEMALLOC=OFF
    -DWITH_LIBXML2=OFF
    -DWITH_MRUBY=OFF
    -DWITH_NEVERBLEED=OFF
    -DWITH_SPDYLAY=OFF
)

if (VCPKG_LIBRARY_LINKAGE MATCHES static)
    set(NGHTTP2_SHARED_LIB OFF)
    set(NGHTTP2_STATIC_LIB ON)
else ()
    set(NGHTTP2_SHARED_LIB ON)
    set(NGHTTP2_STATIC_LIB OFF)
endif ()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        ${BUILD_OPTIONS}
        -DENABLE_SHARED_LIB=${NGHTTP2_SHARED_LIB}
        -DENABLE_STATIC_LIB=${NGHTTP2_STATIC_LIB}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

# Prepare distribution
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/man)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/doc)
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/nghttp2 RENAME copyright)
file(WRITE ${CURRENT_PACKAGES_DIR}/share/nghttp2/version ${VERSION})
