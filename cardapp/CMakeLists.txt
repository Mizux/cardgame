
project(cardapp)

# Qt Setting
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
find_package(Qt5Core REQUIRED)
find_package(Qt5Gui REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Qml REQUIRED)

file(GLOB_RECURSE _SRCS "src/*.[hc]pp")
file(GLOB_RECURSE _QRCS "data/*.qrc")

add_executable(${PROJECT_NAME} ${_SRCS} ${_QRCS})
target_link_libraries(${PROJECT_NAME} libcard Qt5::Core Qt5::Gui Qt5::Widgets Qt5::Qml)

install(TARGETS ${PROJECT_NAME}	DESTINATION bin)
