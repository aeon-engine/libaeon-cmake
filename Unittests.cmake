include(CMakeParseArguments)

include(CTest)
enable_testing()

function(add_unit_test_suite)
    cmake_parse_arguments(
        UNIT_TEST_PARSED_ARGS
        ""
        "TARGET"
        "SOURCES;LIBRARIES;INCLUDES;LABELS"
        ${ARGN}
    )

    if (NOT UNIT_TEST_PARSED_ARGS_TARGET)
        message(FATAL_ERROR "No target name was given for unit test.")
    endif ()

    if (NOT UNIT_TEST_PARSED_ARGS_SOURCES)
        message(FATAL_ERROR "No sources were given for unit test.")
    endif ()

    add_executable(${UNIT_TEST_PARSED_ARGS_TARGET}
        ${UNIT_TEST_PARSED_ARGS_SOURCES}
    )

    if (UNIT_TEST_PARSED_ARGS_INCLUDES)
        include_directories(${UNIT_TEST_PARSED_ARGS_INCLUDES})
    endif ()

    if (UNIT_TEST_PARSED_ARGS_LIBRARIES)
        target_link_libraries(
            ${UNIT_TEST_PARSED_ARGS_TARGET}
            ${UNIT_TEST_PARSED_ARGS_LIBRARIES}
        )
    endif ()

    add_test(
        NAME ${UNIT_TEST_PARSED_ARGS_TARGET}
        WORKING_DIRECTORY $<TARGET_FILE_DIR:${UNIT_TEST_PARSED_ARGS_TARGET}>
        COMMAND $<TARGET_FILE:${UNIT_TEST_PARSED_ARGS_TARGET}>
    )

    list(APPEND UNIT_TEST_PARSED_ARGS_LABELS "unittest")
    set_tests_properties(${UNIT_TEST_PARSED_ARGS_TARGET} PROPERTIES LABELS "${UNIT_TEST_PARSED_ARGS_LABELS}")
endfunction()
