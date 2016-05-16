# ROBIN DEGEN; CONFIDENTIAL
#
# 2012 - 2016 Robin Degen
# All Rights Reserved.
#
# NOTICE:  All information contained herein is, and remains the property of
# Robin Degen and its suppliers, if any. The intellectual and technical
# concepts contained herein are proprietary to Robin Degen and its suppliers
# and may be covered by U.S. and Foreign Patents, patents in process, and are
# protected by trade secret or copyright law. Dissemination of this
# information or reproduction of this material is strictly forbidden unless
# prior written permission is obtained from Robin Degen.

message("Compiler: ${CMAKE_CXX_COMPILER_ID}")
message("Version: ${CMAKE_CXX_COMPILER_VERSION}")

if (MSVC)
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 19.0)
        message(FATAL_ERROR "Requires Visual Studio 2015 or higher!")
    endif ()

    message("Visual Studio detected. Setting flags:")
    message(" - Defining _SCL_SECURE_NO_WARNINGS")
    message(" - Defining _CRT_SECURE_NO_DEPRECATE")
    message(" - Defining NOMINMAX")
    message(" - Setting Windows 7 API level (_WIN32_WINNT=0x0601)")
    message(" - Setting Warning Level 4")
    message(" - Ignore warning C4201: nonstandard extension used: nameless struct/union")
    message(" - Treat warnings as errors (/WX)")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_CRT_SECURE_NO_WARNINGS")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_SCL_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE -DNOMINMAX -D_WIN32_WINNT=0x0601 /W4 /WX /wd4201")
endif ()

if (NOT MSVC AND NOT CYGWIN)
    message("Not on Visual Studio. Setting flags:")
    message(" - C++1y support")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")
endif ()

if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" AND NOT CYGWIN)
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 5.1)
        message(FATAL_ERROR "Requires GCC 5.1.0 or higher!")
    else ()
        message("GNU GCC detected. Setting flags:")

        message(" - CLion Debugger STL Renderer workaround")
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -gdwarf-3")
        set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -gdwarf-3")

        message(" - Suppressing C++ deprecation warnings.")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations")
    endif ()
endif ()

if (CYGWIN)
    message("Cygwin detected. Setting flags:")
    message(" - C++11 support")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
endif ()