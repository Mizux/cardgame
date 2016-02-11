
project(libcard)

file(GLOB_RECURSE _HDRS "include/*.hpp")
file(GLOB_RECURSE _SRCS "src/*.[hc]pp")

add_library(${PROJECT_NAME} SHARED ${_HDRS} ${_SRCS} src/player.cpp)
#target_link_libraries(${PROJECT_NAME})
target_include_directories(${PROJECT_NAME} PUBLIC
	"$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
	"$<INSTALL_INTERFACE:include>")

if(ENABLE_TEST)
  add_subdirectory(test)
endif()

install(TARGETS ${PROJECT_NAME} DESTINATION lib COMPONENT RUNTIME)
