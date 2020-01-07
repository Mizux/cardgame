file(GLOB_RECURSE _HDRS "include/*.hpp")
file(GLOB_RECURSE _SRCS "src/*.[hc]pp")

add_library(card
  ${_HDRS} ${_SRCS} src/player.cpp)
#target_link_libraries(card)
target_include_directories(card PUBLIC
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
  "$<INSTALL_INTERFACE:include>")

if(BUILD_TESTING)
  add_subdirectory(test)
endif()

install(
  TARGETS card
  DESTINATION lib
  COMPONENT RUNTIME)
