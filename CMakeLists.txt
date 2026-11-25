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

set(GXDE_ROLLER_QT_MAJOR_VERSION 5 CACHE STRING "Qt major version to build with (5 or 6)")
set_property(CACHE GXDE_ROLLER_QT_MAJOR_VERSION PROPERTY STRINGS 5 6)
find_package(Qt${GXDE_ROLLER_QT_MAJOR_VERSION} REQUIRED
  COMPONENTS Core Gui Widgets Qml Quick
)

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
    Qt${GXDE_ROLLER_QT_MAJOR_VERSION}::Core
    Qt${GXDE_ROLLER_QT_MAJOR_VERSION}::Gui
    Qt${GXDE_ROLLER_QT_MAJOR_VERSION}::Widgets
  PRIVATE
    absl::check
    absl::log
    absl::str_format
    absl::strings
)

add_executable(gxde-roller
  src/main.cc
  res/qml.qrc
)

set_target_properties(gxde-roller PROPERTIES AUTOMOC ON AUTORCC ON)
target_link_libraries(gxde-roller
  PRIVATE
    gxde_roller_translation_loader
    Qt${GXDE_ROLLER_QT_MAJOR_VERSION}::Gui
    Qt${GXDE_ROLLER_QT_MAJOR_VERSION}::Qml
    Qt${GXDE_ROLLER_QT_MAJOR_VERSION}::Quick
    absl::log
    absl::log_initialize
)
