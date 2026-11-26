# Copyright (C) 2026 CharOfString <root@charofstring.cc>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
#this program. If not, see <https://www.gnu.org/licenses/>. 
# -----------------------------------------------------------------------------
# Main CMake Build file for GXDE Roller.

cmake_minimum_required(VERSION 3.16)

project(gxde-roller
  VERSION 0.1.0
  DESCRIPTION "GXDE Roller"
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# GXTK7 only supports Qt6.
find_package(Qt6 REQUIRED
  COMPONENTS Core Gui Widgets Qml Quick QuickControls2
)

find_file(GXTK7_QMLDIR qmldir
  PATHS "${QT6_INSTALL_PREFIX}/${QT6_INSTALL_QML}/QtQuick/Controls/Gxde"
  NO_DEFAULT_PATH
)

if(NOT GXTK7_QMLDIR)
  message(FATAL_ERROR
    "GXTK7 (QML module QtQuick.Controls.Gxde) was not found in "
    "${QT6_INSTALL_PREFIX}/${QT6_INSTALL_QML}. Please install GXTK7: "
    "https://github.com/GXDE-OS/GXTK7")
endif()

file(STRINGS "${GXTK7_QMLDIR}" GXTK7_FILE_TOOL_BAR REGEX "^GXFileToolBar ")
if(NOT GXTK7_FILE_TOOL_BAR)
  message(FATAL_ERROR
    "GXTK7 at ${GXTK7_QMLDIR} is obslete: GXFileToolBar is missing. "
    "Please install GXTK7 0.1.3 or later: https://github.com/GXDE-OS/GXTK7")
endif()
message(STATUS "Found GXTK7: ${GXTK7_QMLDIR}")

set(ABSL_PROPAGATE_CXX_STD ON)
set(ABSL_BUILD_TESTING OFF)
set(ABSL_ENABLE_INSTALL OFF)
add_subdirectory(lib/abseil-cpp EXCLUDE_FROM_ALL)

add_library(gxde_roller_translation_loader STATIC
  src/translation_loader/translation_loader.cc
  src/translation_loader/translation_loader.h)
target_include_directories(gxde_roller_translation_loader
  PUBLIC ${PROJECT_SOURCE_DIR})
set_target_properties(gxde_roller_translation_loader PROPERTIES AUTOMOC ON)

target_link_libraries(gxde_roller_translation_loader
  PUBLIC
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
  PRIVATE
    absl::check
    absl::log
    absl::str_format
    absl::strings
)

add_executable(gxde-roller
  src/main.cc
  res/qml.qrc
  res/translations.qrc
)

set_target_properties(gxde-roller PROPERTIES AUTOMOC ON AUTORCC ON)
target_link_libraries(gxde-roller
  PRIVATE
    gxde_roller_translation_loader
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    absl::log
    absl::log_initialize
)
