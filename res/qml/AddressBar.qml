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
 * This is the DFM styled address bar of GXDE Roller, made for the title bar.
 */

import QtQuick
import QtQuick.Controls.Gxde

GXFileToolBar {
  id: addressBar

  enableSystemMove: true
  iconName: "application-x-archive"
  sideBarButtonVisible: false
  detailsButtonVisible: false

  Text {
    parent: addressBar.crumbBar
    anchors.fill: parent
    anchors.leftMargin: 10
    anchors.rightMargin: 10
    visible: addressBar.folder.toString().length === 0
             && !addressBar.crumbBar.addressBarVisible
    text: qsTr("No archive opened")
    font: addressBar.font
    color: Qt.alpha(GxdePalette.text, 0.5)
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
  }
}
