import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/language_module/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

LanguageCubit changeLanguageCubit = LanguageCubit()..onDecideLanguageChange();

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(SelectedLanguageState(Locale(LanguageType.en.name)));

  var local = Locale(LanguageType.en.name);

  void toEnglish() {
    _saveOptionValue(0);
    local = Locale(LanguageType.en.name);
    emit(SelectedLanguageState(local));
  }

  void toItalian() {
    _saveOptionValue(1);
    local = Locale(LanguageType.it.name);
    emit(SelectedLanguageState(local));
  }

  void onDecideLanguageChange() async {
    final optionValue = await getOption();
    AppLogs.debugPrint("Lang optionValue is $optionValue");

    switch (optionValue) {
      case 0:
        /// English Language
        toEnglish();
        break;
      case 1:
      /// Italian Language
        toItalian();
        break;
    }
  }

  Future<void> _saveOptionValue(int optionValue) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setInt('lang_option', optionValue);
  }

  Future<int> getOption() async {
    try {
      var preferences = await SharedPreferences.getInstance();
      int option = preferences.getInt('lang_option') ?? 0;
      return option;
    } catch (e) {
      return 0;
    }
  }

  Future<LanguageType> getLanguageType() async {
    var option = await getOption();

    switch (option) {
      case 0:
        /// English Language
        return LanguageType.en;
      case 1:
      /// Italian Language
        return LanguageType.it;
    }
    return LanguageType.en;
  }
}
