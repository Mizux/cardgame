file(GLOB _SRCS "src/*.[hc]pp")

add_executable(Card_UT ${_SRCS})
# use GTest::gtest once ALIAS is available
# see https://github.com/google/googletest/issues/2429
target_link_libraries(Card_UT Card::Card gtest)
add_test(NAME Card_UT COMMAND Card_UT)
