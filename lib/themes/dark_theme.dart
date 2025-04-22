import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';

ThemeData dark() {
  final base = ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.green[700],
    textTheme: base.textTheme.apply(
      fontFamily: "Open-Sans",
      bodyColor: AppColors.green[50],
      displayColor: AppColors.green[50],
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.green[600],
      hourMinuteColor: AppColors.green[100],
      hourMinuteTextColor: AppColors.green[700],
      dayPeriodColor: AppColors.green[100],
      dayPeriodTextColor: AppColors.green[700],
      dialBackgroundColor: AppColors.green[100],
      dialHandColor: AppColors.red[500], // The clock hand
      dialTextColor: AppColors.green[700],
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      dialTextStyle: TextStyle(
        // The numbers inside the clock
        color: AppColors.green[700],
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      entryModeIconColor: Colors.white, // The keyboard icon in the bottom
      helpTextStyle: TextStyle(
        // The help text at the top
        color: Colors.white,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      timeSelectorSeparatorColor: WidgetStatePropertyAll(
        Colors.white, // The separator between hour and minute
      ),
    ),
  );
}
