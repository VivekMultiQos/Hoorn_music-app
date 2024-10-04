import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/constant/import.dart';

class CalendarExtension {
  static Future<void> datePicker({
    required BuildContext context,
    required ChangeThemeState themeState,
    String format = 'yyyy/MM/dd',
    bool shouldAllowFutureDate = false,
    Function(String)? selectedDate,
  }) async {
    var currentDate = DateTime.now();
    var pastDate =
        DateTime(currentDate.year - 100, currentDate.month, currentDate.day);
    var lastDate = shouldAllowFutureDate
        ? DateTime(currentDate.year + 100, currentDate.month, currentDate.day)
        : currentDate;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: pastDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: themeState.customColors[AppColors.themeColor] ??
                  const Color(0xFFA42826),
              onPrimary: themeState.customColors[AppColors.white] ??
                  const Color(0xFFffffff),
              onSurface: themeState.customColors[AppColors.black] ??
                  const Color(0xFF000000),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: themeState.customColors[AppColors.black] ??
                    const Color(0xFF000000),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat(format).format(pickedDate);
      var callBack = selectedDate;
      if (callBack != null) {
        callBack(formattedDate);
      }
    }
  }
}
