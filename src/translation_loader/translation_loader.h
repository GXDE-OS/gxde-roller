/*
 * Copyright (C) CharOfString <root@charofstring.cc>
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

#ifndef SRC_TRANSLATION_LOADER_TRANSLATION_LOADER_H_
#define SRC_TRANSLATION_LOADER_TRANSLATION_LOADER_H_

#include <optional>

#include <QLocale>
#include <QObject>
#include <QSettings>
#include <QString>
#include <QTranslator>
#include <QWidget>

namespace gxde {
namespace roller {

enum class LanguageType {
  kArSa,  // Arabic, right-to-left.
  kEnUs,  // English.
  kEsEs,  // Spanish.
  kFrFr,  // French.
  kJaJp,  // Japanese.
  kKoKr,  // Korean.
  kRuRu,  // Russian.
  kZhCn,  // Chinese (Simplified).
  kZhHk,  // Chinese (Traditional).
};

class TranslationLoader : public QTranslator {
  Q_OBJECT

 public:
  explicit TranslationLoader(const QString& file,
                             const LanguageType& fallback_lng);
  ~TranslationLoader() override = default;

  static QString GetLocaleSuffix(const LanguageType& type);
  static QString GetLocaleDisplayName(const LanguageType& type);
  QString GetTranslation(const QString& message);
  Q_INVOKABLE QString Tr(const QString& message);

  QString translate(const char* context, const char* source_text,
                    const char* disambiguation, int n) const override;
  bool isEmpty() const override;

 private:
  void RecordCurrentLanguage(const QLocale& locale);
  std::optional<QString> FindTranslation(const QString& message,
                                         const LanguageType& lng) const;

  LanguageType fallback_lng_ = LanguageType::kEnUs;
  LanguageType current_lng_ = LanguageType::kEnUs;
  QSettings* translation_ = nullptr;
};

}  // namespace roller
}  // namespace gxde

#endif  // SRC_TRANSLATION_LOADER_TRANSLATION_LOADER_H_
