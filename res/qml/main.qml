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
 * This is the main window of GXDE Roller.
 */

import QtQuick
import QtQuick.Controls.Gxde
import QtQuick.Layouts

GXMainWindow {
  id: mainWindow

  width: 960
  height: 640
  minimumWidth: 720
  minimumHeight: 480
  visible: true

  property url currentFolder
  titlebar.customAlignment: Qt.AlignVCenter
  titlebar.customItem: AddressBar {
    id: addressBar

    folder: mainWindow.currentFolder
    onFolderRequested: url => mainWindow.currentFolder = url
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 0

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    MainToolBar {
      id: toolBar

      Layout.fillWidth: true
    }

    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true

      Rectangle {
        id: hint

        readonly property bool overImage: mainWindow.windowBackground.isSet
        anchors.centerIn: parent
        width: Math.min(hintLabel.implicitWidth + 40, parent.width - 64)
        height: hintLabel.height + 24
        visible: mainWindow.currentFolder.toString().length === 0
        radius: 8
        color: overImage ? Qt.alpha(GxdePalette.window, 0.85) : "transparent"
        border.width: overImage ? 1 : 0
        border.color: GxdePalette.frameBorder

        Label {
          id: hintLabel

          anchors.centerIn: parent
          width: Math.min(implicitWidth, hint.width - 40)
          text: qsTr("Drag an archive into this window, or use “Open” to open one.")
          color: hint.overImage ? GxdePalette.text : Qt.alpha(GxdePalette.text, 0.6)
          horizontalAlignment: Text.AlignHCenter
          wrapMode: Text.Wrap
        }
      }
    }
  }
}
