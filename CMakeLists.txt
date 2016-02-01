cmake_minimum_required(VERSION 3.2)
project(CardGame)

set(_MAJOR_VERSION 0)
set(_MINOR_VERSION 1)
set(_PATCH_VERSION 0)
set(_VERSION ${_MAJOR_VERSION}.${_MINOR_VERSION}.${_PATCH_VERSION})

##########################
##  INSTALL PARAMETERS  ##
##########################
# Offer the user the choice of overriding the installation directories
set(CMAKE_INSTALL_PREFIX install)
set(INSTALL_LIB_DIR lib CACHE PATH "Installation directory for libraries")
set(INSTALL_BIN_DIR bin CACHE PATH "Installation directory for executables")
set(INSTALL_INCLUDE_DIR include CACHE PATH "Installation directory for header files")
set(INSTALL_CMAKE_DIR cmake/Modules CACHE PATH "Installation directory for CMake files")

#####################
##  DOCUMENTATION  ##
#####################
#add_subdirectory(doc)

# Make relative paths absolute (needed later on)
foreach(p LIB BIN INCLUDE CMAKE)
  set(var INSTALL_${p}_DIR)
  if(NOT IS_ABSOLUTE "${${var}}")
    set(${var} "${CMAKE_INSTALL_PREFIX}/${${var}}")
  endif()
endforeach()

##############################
##  COMPILATION PARAMETERS  ##
##############################
set(CMAKE_CXX_STANDARD   11)
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
