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
 * This is the action button component of the tool bar.
 */

import QtQuick
import QtQuick.Controls.Gxde
import QtQuick.Layouts

ToolButton {
  display: AbstractButton.TextUnderIcon
  icon.width: 32
  icon.height: 32
  icon.color: "transparent"
  leftPadding: 8
  rightPadding: 8
  topPadding: 6
  bottomPadding: 6
  Layout.minimumWidth: 60
}
