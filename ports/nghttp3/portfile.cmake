set(VERSION 1.4.0)

set(FILENAME "nghttp3-${VERSION}.tar.xz")
set(URLS "https://github.com/ngtcp2/nghttp3/releases/download/v${VERSION}/${FILENAME}")

# Get archive
vcpkg_download_distfile(ARCHIVE
    URLS ${URLS}
    FILENAME ${FILENAME}
    SHA512 39ff9418009dcf84ae58d8297f53427da91509a69ecc4fc78c4c00f0fe6bbe348f7afffeafe535ae4c02ff9f0413016b4f51de6a87d8e8c8f6b415bb7f2b0895
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
)

if (VCPKG_LIBRARY_LINKAGE MATCHES static)
    set(NGHTTP3_SHARED_LIB OFF)
    set(NGHTTP3_STATIC_LIB ON)
else ()
    set(NGHTTP3_SHARED_LIB ON)
    set(NGHTTP3_STATIC_LIB OFF)
endif ()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        ${BUILD_OPTIONS}
        -DBUILD_TESTING=OFF
        -DENABLE_SHARED_LIB=${NGHTTP3_SHARED_LIB}
        -DENABLE_STATIC_LIB=${NGHTTP3_STATIC_LIB}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/nghttp3)
vcpkg_fixup_pkgconfig()

# Prepare distribution
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/man)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/doc)
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/nghttp3 RENAME copyright)
file(WRITE ${CURRENT_PACKAGES_DIR}/share/nghttp3/version ${VERSION})
