import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/constant/enums.dart';
import 'dart:convert' show json;
import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<void> load() async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map<String, String>((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => _localizedStrings?[key] ?? '';

  bool get isEnLocale => locale.languageCode == LanguageType.en.name;
}

AppLocalizations appLocalizations(BuildContext context) {
  return AppLocalizations.of(context)!;
}

String localize(BuildContext context, String key) {
  return appLocalizations(context).translate(key);
}
