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

function(get_visual_studio_version visual_studio_version)
    if (NOT MSVC)
        message(WARNING "get_visual_studio_version called when MSVC is not set.")
        set(${visual_studio_version} "" PARENT_SCOPE)
        return()
    endif ()

    if (CMAKE_CXX_COMPILER_VERSION MATCHES 19.0.*)
        set(${visual_studio_version} "2015" PARENT_SCOPE)
    elseif (CMAKE_CXX_COMPILER_VERSION MATCHES 19.10.*)
        set(${visual_studio_version} "2017" PARENT_SCOPE)
    else ()
        message(WARNING "Unknown Visual Studio version ${CMAKE_CXX_COMPILER_VERSION}.")
        set(${visual_studio_version} "unknown" PARENT_SCOPE)
    endif ()
endfunction()

function(get_platform_architecture_suffix architecture_suffix)
    if (NOT AEON_PLATFORM_ARCHITECTURE_SUFFIX_SET)
        if (CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(AEON_PLATFORM_ARCHITECTURE_SUFFIX "64")
            set(AEON_PLATFORM_ARCHITECTURE_SUFFIX_SET 1)
            set(AEON_PLATFORM_ARCHITECTURE_32_BIT 0)
            set(AEON_PLATFORM_ARCHITECTURE_64_BIT 1)
        else ()
            set(AEON_PLATFORM_ARCHITECTURE_SUFFIX "32")
            set(AEON_PLATFORM_ARCHITECTURE_SUFFIX_SET 1)
            set(AEON_PLATFORM_ARCHITECTURE_32_BIT 1)
            set(AEON_PLATFORM_ARCHITECTURE_64_BIT 0)
        endif ()
    endif ()

    set(${architecture_suffix} ${AEON_PLATFORM_ARCHITECTURE_SUFFIX} PARENT_SCOPE)
endfunction()
