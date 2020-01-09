# Qt Setting
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
find_package(Qt5Core REQUIRED)
find_package(Qt5Gui REQUIRED)
find_package(Qt5Widgets REQUIRED)

file(GLOB_RECURSE _SRCS "src/*.[hc]pp")
file(GLOB_RECURSE _QRCS "data/*.qrc")

add_executable(card ${_SRCS} ${_QRCS})
target_link_libraries(card Card::Card Qt5::Core Qt5::Gui Qt5::Widgets)

install(
	TARGETS card
	EXPORT CardTargets
	DESTINATION bin)
