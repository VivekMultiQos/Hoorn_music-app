import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';
import 'base_theme.dart';

class AppLightTheme extends BaseTheme {
  static final AppLightTheme _instance = AppLightTheme._();

  AppLightTheme._();

  factory AppLightTheme() => _instance;

  @override
  Color get primaryColor => Colors.black;

  @override
  Color get accentColor => Colors.black;

  @override
  Brightness get brightness => Brightness.light;

  @override
  ThemeData get lightTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: LightThemeColors.white,
      shadowColor: LightThemeColors.white,
    );
  }

  @override
  Color? get darkAccentColor => null;

  @override
  Color? get darkPrimaryColor => null;

  @override
  ThemeData? get darkTheme => null;

  /// This will use for custom colors which couldn't part of the theme data.
  @override
  Map<String, Color> get customColor => {
        AppColors.white: LightThemeColors.white,
        AppColors.black: LightThemeColors.black,
        AppColors.themeColor: LightThemeColors.themeColor,
        AppColors.yellow: LightThemeColors.yellow,
        AppColors.grey666: LightThemeColors.grey666,
        AppColors.greyABAB: LightThemeColors.greyABAB,
        AppColors.greyE2E: LightThemeColors.greyE2E,
        AppColors.greyF4F: LightThemeColors.greyF4F,
        AppColors.greyF7F: LightThemeColors.greyF7F,
        AppColors.greyE8E: LightThemeColors.greyE8E,
        AppColors.lightThemeColor: LightThemeColors.lightThemeColor,
        AppColors.blue4C: LightThemeColors.blue4C,
      };
}
