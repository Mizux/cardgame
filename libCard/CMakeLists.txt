file(GLOB_RECURSE _HDRS "include/*.hpp")
file(GLOB_RECURSE _SRCS "src/*.[hc]pp")

add_library(Card ${_HDRS} ${_SRCS})
#target_link_libraries(Card)
target_include_directories(Card PUBLIC
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
  "$<INSTALL_INTERFACE:include>")
add_library(Card::Card ALIAS Card)

if(BUILD_TESTING)
  add_subdirectory(test)
endif()

install(
  TARGETS Card
  EXPORT CardTargets
  DESTINATION lib
  COMPONENT RUNTIME)
