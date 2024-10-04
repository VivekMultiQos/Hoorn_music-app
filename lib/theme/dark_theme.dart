import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';
import 'base_theme.dart';

class AppDarkTheme extends BaseTheme {
  static final AppDarkTheme _instance = AppDarkTheme._();

  AppDarkTheme._();

  factory AppDarkTheme() => _instance;

  @override
  Color get primaryColor => Colors.black;

  @override
  Color get accentColor => Colors.black;

  @override
  Brightness get brightness => Brightness.dark;

  @override
  ThemeData get darkTheme {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: DarkThemeColors.black,
      shadowColor: DarkThemeColors.white,
    );
  }

  @override
  Color? get darkAccentColor => null;

  @override
  Color? get darkPrimaryColor => null;

  @override
  ThemeData? get lightTheme => null;

  /// This will use for custom colors which couldn't part of the theme data.
  @override
  Map<String, Color> get customColor => {
        AppColors.white: DarkThemeColors.black,
        AppColors.black: DarkThemeColors.white,
        AppColors.themeColor: DarkThemeColors.themeColor,
        AppColors.yellow: DarkThemeColors.yellow,
        AppColors.grey666: DarkThemeColors.grey666,
        AppColors.greyABAB: DarkThemeColors.greyABAB,
        AppColors.greyE2E: DarkThemeColors.greyE2E,
        AppColors.greyF4F: DarkThemeColors.greyF4F,
        AppColors.greyF7F: DarkThemeColors.greyF7F,
        AppColors.greyE8E: DarkThemeColors.greyE8E,
        AppColors.lightThemeColor: DarkThemeColors.lightThemeColor,
        AppColors.blue4C: DarkThemeColors.blue4C,
      };
}
