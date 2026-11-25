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
 */

#include <QCoreApplication>
#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QUrl>

#include "absl/log/initialize.h"
#include "absl/log/log.h"

int main(int argc, char* argv[]) {
  absl::InitializeLog();
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](const QObject* object, const QUrl& object_url) {
        if (object == nullptr && url == object_url) {
          LOG(ERROR) << "Failed to load " << url.toString().toStdString();
          QCoreApplication::exit(1);
        }
      },
      Qt::QueuedConnection);
  engine.load(url);

  return QGuiApplication::exec();
}
