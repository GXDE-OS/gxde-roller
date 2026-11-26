/*
 * Copyright (C) 2025 CharOfString <root@charofstring.cc>
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

#include "src/translation_loader/translation_loader.h"

#include <QApplication>
#include <QDebug>
#include <QFile>
#include <QLocale>
#include <QStyleHints>
#include <QVariant>

#include "absl/log/check.h"
#include "absl/log/log.h"
#include "absl/strings/str_cat.h"
#include "absl/strings/str_format.h"

namespace gxde {
namespace roller {

TranslationLoader::TranslationLoader(const QString& file,
                                     const LanguageType& fallback_lng) {
  LOG(INFO) << absl::StrCat("Initializing translator...");
  if (!QFile::exists(file)) {
    LOG(ERROR) << absl::StrCat("Invalid locale file!! Translator halted...");
  }

  LOG(INFO) << absl::StrCat(
      absl::StrFormat("Fallback language is set to %s...",
                      GetLocaleDisplayName(fallback_lng).toStdString()));
  fallback_lng_ = fallback_lng;

  LOG(INFO) << absl::StrCat("Initializing translation reader...");
  translation_ = new QSettings(file, QSettings::IniFormat, this);

  RecordCurrentLanguage(QLocale());
}

QString TranslationLoader::GetLocaleSuffix(const LanguageType& type) {
  switch (type) {
    case LanguageType::kArSa:
      return "ar_sa";

    case LanguageType::kEnUs:
      return "en_us";

    case LanguageType::kEsEs:
      return "es_es";

    case LanguageType::kFrFr:
      return "fr_fr";

    case LanguageType::kJaJp:
      return "ja_jp";

    case LanguageType::kKoKr:
      return "ko_kr";

    case LanguageType::kRuRu:
      return "ru_ru";

    case LanguageType::kZhCn:
      return "zh_cn";

    case LanguageType::kZhHk:
      return "zh_hk";

    default:
      LOG(ERROR) << absl::StrCat("Unknown type, defaulting to EN-US...");
      return "en_us";
  }
}

QString TranslationLoader::GetLocaleDisplayName(const LanguageType& type) {
  switch (type) {
    case LanguageType::kArSa:
      return "العربية (المملكة العربية السعودية)";

    case LanguageType::kEnUs:
      return "English (United States)";

    case LanguageType::kEsEs:
      return "Español (España)";

    case LanguageType::kFrFr:
      return "Français (France)";

    case LanguageType::kJaJp:
      return "日本語（日本）";

    case LanguageType::kKoKr:
      return "한국어 (대한민국)";

    case LanguageType::kRuRu:
      return "Русский (Россия)";

    case LanguageType::kZhCn:
      return "简体中文（中国）";

    case LanguageType::kZhHk:
      return "繁體中文（香港）";

    default:
      LOG(ERROR) << absl::StrCat("Unknown type, defaulting to EN-US...");
      return "English (United States)";
  }
}

void TranslationLoader::RecordCurrentLanguage(const QLocale& locale) {
  LOG(INFO) << absl::StrCat("Getting current language...");
  LOG(INFO) << absl::StrCat(
      absl::StrFormat("QLocale raw value: %s.", locale.name().toStdString()));

  switch (locale.language()) {
    case QLocale::Arabic:
      current_lng_ = LanguageType::kArSa;
      break;

    case QLocale::English:
      current_lng_ = LanguageType::kEnUs;
      break;

    case QLocale::Spanish:
      current_lng_ = LanguageType::kEsEs;
      break;

    case QLocale::French:
      current_lng_ = LanguageType::kFrFr;
      break;

    case QLocale::Japanese:
      current_lng_ = LanguageType::kJaJp;
      break;

    case QLocale::Korean:
      current_lng_ = LanguageType::kKoKr;
      break;

    case QLocale::Russian:
      current_lng_ = LanguageType::kRuRu;
      break;

    case QLocale::Chinese:
      current_lng_ = locale.script() == QLocale::TraditionalChineseScript
                         ? LanguageType::kZhHk
                         : LanguageType::kZhCn;
      break;

    default:
      LOG(INFO) << absl::StrCat(absl::StrFormat(
          "Unknown language type, now setting language to fallback %s...",
          GetLocaleDisplayName(fallback_lng_).toStdString()));
      current_lng_ = fallback_lng_;
      return;
  }

  LOG(INFO) << absl::StrCat(absl::StrFormat(
      "Language set to %s!", GetLocaleDisplayName(current_lng_).toStdString()));
}

std::optional<QString> TranslationLoader::FindTranslation(
    const QString& message, const LanguageType& lng) const {
  if (translation_ == nullptr || message.isEmpty()) {
    return std::nullopt;
  }

  QString search_path = "/" + message + "/" + GetLocaleSuffix(lng);
  QVariant result = translation_->value(search_path);
  if (!result.isValid()) {
    return std::nullopt;
  }
  return result.toString();
}

QString TranslationLoader::GetTranslation(const QString& message) {
  if (translation_ == nullptr) {
    LOG(ERROR) << absl::StrCat("Translator is NOT set up properly!! ",
                               "Now returning original message...");
    return message;
  }

  if (auto result = FindTranslation(message, current_lng_)) {
    return *result;
  }

  LOG(ERROR) << absl::StrCat(absl::StrFormat(
      "The message %s is NOT found in translation file, now trying fallback...",
      message.toStdString()));
  if (auto result = FindTranslation(message, fallback_lng_)) {
    return *result;
  }

  LOG(ERROR) << absl::StrCat(absl::StrFormat(
      "The message %s is even NOT found in fallback, aborting...",
      message.toStdString()));
  return message;
}

QString TranslationLoader::translate(const char* /*context*/,
                                     const char* source_text,
                                     const char* /*disambiguation*/,
                                     int /*n*/) const {
  const QString message = QString::fromUtf8(source_text);
  if (auto result = FindTranslation(message, current_lng_)) {
    return *result;
  }
  if (auto result = FindTranslation(message, fallback_lng_)) {
    return *result;
  }
  return {};
}

bool TranslationLoader::isEmpty() const { return translation_ == nullptr; }

QString TranslationLoader::Tr(const QString& message) {
  return GetTranslation(message);
}

}  // namespace roller
}  // namespace gxde
