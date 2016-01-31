
project(libcard)

file(GLOB _HDRS "include/*/*.hpp")
file(GLOB _SRCS "src/*.[hc]pp")

add_library(${PROJECT_NAME} ${_HDRS} ${_SRCS})
#target_link_libraries(${PROJECT_NAME})
target_include_directories(${PROJECT_NAME} PUBLIC
	"$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
	"$<INSTALL_INTERFACE:include>")

add_subdirectory(test)
