include(CMakeParseArguments)

function(copy_folder_to_runtime_path)
    cmake_parse_arguments(
        FUNCTION_ARGS
        ""
        "DESTINATION"
        "PATH;CONFIGURATIONS"
        ${ARGN}
    )

    get_filename_component(FULL_SOURCE_PATH "${FUNCTION_ARGS_PATH}" ABSOLUTE)

    file(GLOB_RECURSE FILES_TO_COPY
        RELATIVE "${FULL_SOURCE_PATH}"
        "${FULL_SOURCE_PATH}/*"
    )

    # Use default values if applicable.
    if (NOT FUNCTION_ARGS_DESTINATION)
        set(FUNCTION_ARGS_DESTINATION "${CMAKE_BINARY_DIR}/bin")
    else ()
        set(FUNCTION_ARGS_DESTINATION "${CMAKE_BINARY_DIR}/bin/${FUNCTION_ARGS_DESTINATION}")
    endif ()

    if (MSVC)
        if (NOT FUNCTION_ARGS_CONFIGURATIONS)
            set(FUNCTION_ARGS_CONFIGURATIONS "Debug" "Release")
        endif ()
    else ()
        set(FUNCTION_ARGS_CONFIGURATIONS "dummy")
    endif ()

    # Copying of the files.
    foreach (CONFIGURATION ${FUNCTION_ARGS_CONFIGURATIONS})
        if (MSVC)
            set(DESTINATION "${FUNCTION_ARGS_DESTINATION}/${CONFIGURATION}")
        else ()
            set(DESTINATION "${FUNCTION_ARGS_DESTINATION}")
        endif ()

        execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${DESTINATION}")
        foreach (FILENAME ${FILES_TO_COPY})
            get_filename_component(FULL_DESTINATION_PATH "${DESTINATION}/${FILENAME}" DIRECTORY)
            execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${FULL_DESTINATION_PATH}")
            execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different "${FULL_SOURCE_PATH}/${FILENAME}" "${FULL_DESTINATION_PATH}")
        endforeach ()
    endforeach ()
endfunction ()

function (copy_files_to_runtime_path)
    cmake_parse_arguments(
        FUNCTION_ARGS
        ""
        "DESTINATION"
        "FILES;CONFIGURATIONS"
        ${ARGN}
    )

    # Argument validation.
    if(NOT FUNCTION_ARGS_FILES)
        message(FATAL_ERROR "No files provided for copying.")
    endif()

    # Use default values if applicable.
    if (NOT FUNCTION_ARGS_DESTINATION)
        set(FUNCTION_ARGS_DESTINATION "${CMAKE_BINARY_DIR}/bin")
    else ()
        set(FUNCTION_ARGS_DESTINATION "${CMAKE_BINARY_DIR}/${FUNCTION_ARGS_DESTINATION}")
    endif ()

    if (NOT FUNCTION_ARGS_CONFIGURATIONS)
        set(FUNCTION_ARGS_CONFIGURATIONS "Debug" "Release")
    endif ()

    # Copying of the files.
    foreach (CONFIGURATION ${FUNCTION_ARGS_CONFIGURATIONS})
        set(DESTINATION "${FUNCTION_ARGS_DESTINATION}/${CONFIGURATION}")
        execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${DESTINATION}")
        foreach (FILENAME ${FUNCTION_ARGS_FILES})
            execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different "${FILENAME}" "${DESTINATION}/")
        endforeach ()
    endforeach ()

endfunction ()