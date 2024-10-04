import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/constant/font_style.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/theme_module/change_theme_states.dart';
import 'package:music_app/theme/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  final ChangeThemeState themeState;
  final String hintText;
  final TextEditingController controller;
  final String? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Function(String)? onChange;

  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.prefixIcon,
      this.obscureText = false,
      required this.themeState,
      this.textCapitalization,
      this.keyboardType,
      this.inputFormatters,
      this.maxLength,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      controller: controller,
      cursorColor: themeState.customColors[AppColors.black],
      obscureText: obscureText,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: (value) {
        var callBack = onChange;
        if (callBack != null) {
          callBack(value);
        }
      },
      style: AppFontStyle.h3Regular.copyWith(
        fontSize: 16.sp,
        color: themeState.customColors[AppColors.black],
      ),
      decoration: InputDecoration(
        hintText: hintText,
        counter: Offstage(),
        hintStyle: AppFontStyle.h3Regular.copyWith(
          fontSize: 16.sp,
          color: themeState.customColors[AppColors.greyE8E],
        ),
        border: InputBorder.none,
      ),
    );
  }
}
