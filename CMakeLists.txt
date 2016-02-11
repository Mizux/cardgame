cmake_minimum_required(VERSION 3.2)
project(CardGame)

##########################
##  INSTALL PARAMETERS  ##
##########################
# Offer the user the choice of overriding the installation directories
set(CMAKE_INSTALL_PREFIX install)
set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib:$ORIGIN/")

#####################
##  DOCUMENTATION  ##
#####################
#add_subdirectory(doc)

##############################
##  COMPILATION PARAMETERS  ##
##############################
set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
set(BUILD_SHARED_LIBS ON)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/bin)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
enable_testing()

##################
##  GOOGLETEST  ##
##################
# Download and unpack googletest at configure time
configure_file(
	googletest.in
	${CMAKE_BINARY_DIR}/googletest/CMakeLists.txt)
execute_process(
	COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googletest)
execute_process(
	COMMAND ${CMAKE_COMMAND} --build .
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googletest)

# Add googletest directly to our build.
# This adds the following targets: gtest, gtest_main, gmock and gmock_main
add_subdirectory(
  ${CMAKE_BINARY_DIR}/googletest/src
  ${CMAKE_BINARY_DIR}/googletest/build)

add_subdirectory(libcard)
add_subdirectory(cardapp)
