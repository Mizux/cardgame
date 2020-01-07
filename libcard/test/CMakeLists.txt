file(GLOB _SRCS "src/*.[hc]pp")

add_executable(test_libcard ${_SRCS})
target_link_libraries(test_libcard card gtest)
add_test(NAME libcard COMMAND test_libcard)
