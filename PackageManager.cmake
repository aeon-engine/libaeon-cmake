# ROBIN DEGEN; CONFIDENTIAL
#
# 2012 - 2017 Robin Degen
# All Rights Reserved.
#
# NOTICE:  All information contained herein is, and remains the property of
# Robin Degen and its suppliers, if any. The intellectual and technical
# concepts contained herein are proprietary to Robin Degen and its suppliers
# and may be covered by U.S. and Foreign Patents, patents in process, and are
# protected by trade secret or copyright law. Dissemination of this
# information or reproduction of this material is strictly forbidden unless
# prior written permission is obtained from Robin Degen.

include(CMakeParseArguments)
include(CompilerInfo)

function(apm_get_platform_name platform_name)
    set(_platform_name "")

    if (MSVC)
        get_visual_studio_version(vs_version)
        set(_platform_name "${_platform_name}vs${vs_version}")
    elseif (APPLE)
        set(_platform_name "macos_llvm")
    else ()
        message(FATAL_ERROR "Unknown or unsupported platform.")
    endif ()

    get_platform_architecture_suffix(architecture_suffix)
    set(_platform_name "${_platform_name}_${architecture_suffix}")

    set(${platform_name} ${_platform_name} PARENT_SCOPE)
endfunction()

function(apm_download_package)
    cmake_parse_arguments(
        DOWNLOAD_PKG_PARSED_ARGS
        ""
        "NAME;VERSION;PATH"
        ""
        ${ARGN}
    )

    set(AEON_PACKAGE_MANAGER_USERNAME $ENV{AEON_PACKAGE_MANAGER_USERNAME} CACHE INTERNAL "" FORCE)
    set(AEON_PACKAGE_MANAGER_PASSWORD $ENV{AEON_PACKAGE_MANAGER_PASSWORD} CACHE INTERNAL "" FORCE)

    if (NOT AEON_PACKAGE_MANAGER_USERNAME OR NOT AEON_PACKAGE_MANAGER_PASSWORD)
        message(FATAL_ERROR "Downloading packages through the Aeon Package Manager requires setting a username and password. Please set AEON_PACKAGE_MANAGER_USERNAME and AEON_PACKAGE_MANAGER_PASSWORD as environment variables.")
    endif ()

    if (NOT DOWNLOAD_PKG_PARSED_ARGS_NAME)
        message(FATAL_ERROR "No package name was given for download package.")
    endif ()

    if (NOT DOWNLOAD_PKG_PARSED_ARGS_VERSION)
        message(FATAL_ERROR "No package version was given for download package.")
    endif ()

    if (NOT DOWNLOAD_PKG_PARSED_ARGS_PATH)
        message(FATAL_ERROR "No package path was given for download package.")
    endif ()

    apm_get_platform_name(platform_name)
    message("Platform name: ${platform_name}")

    message(STATUS "Package: ${DOWNLOAD_PKG_PARSED_ARGS_NAME} (${DOWNLOAD_PKG_PARSED_ARGS_VERSION})")

    #file(DOWNLOAD http://localhost/test.txt ${CMAKE_SOURCE_DIR}/test.txt STATUS DOWNLOAD_RESULT SHOW_PROGRESS)

endfunction()
