/*
 * Copyright (C) 2026 CharOfString <root@charofstring.cc>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 * -----------------------------------------------------------------------------
 * This is the main tool bar of GXDE Roller.
 */

import QtQuick
import QtQuick.Controls.Gxde
import QtQuick.Layouts

import "components"

ToolBar {
  id: toolBar

  // Whether to show an "delete" button.
  property bool deleteEnabled: false

  signal openRequested()
  signal addRequested()
  signal extractToRequested()
  signal quickExtractRequested()
  signal compressRequested()
  signal deleteRequested()
  signal testRequested()

  RowLayout {
    anchors.fill: parent
    spacing: 4

    ActionButton {
      text: qsTr("Open")
      icon.name: "folder-open"
      onClicked: toolBar.openRequested()
    }

    ActionButton {
      text: qsTr("Add")
      icon.name: "archive-insert"
      onClicked: toolBar.addRequested()
    }

    Separator { }

    ActionButton {
      text: qsTr("Extract To")
      icon.name: "archive-extract"
      onClicked: toolBar.extractToRequested()
    }

    ActionButton {
      text: qsTr("Quick Extract")
      icon.name: "extract-archive"
      onClicked: toolBar.quickExtractRequested()
    }

    ActionButton {
      text: qsTr("Compress")
      icon.name: "package"
      onClicked: toolBar.compressRequested()
    }

    ActionButton {
      text: qsTr("Delete")
      icon.name: "user-trash"
      enabled: toolBar.deleteEnabled
      onClicked: toolBar.deleteRequested()
    }

    ActionButton {
      text: qsTr("Test")
      icon.name: "security-high"
      onClicked: toolBar.testRequested()
    }

    Item {
      Layout.fillWidth: true
    }
  }
}
