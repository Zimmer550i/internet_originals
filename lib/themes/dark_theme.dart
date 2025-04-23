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
      dayPeriodBorderSide: BorderSide(
        color: AppColors.green[400]!
      ),
      timeSelectorSeparatorTextStyle: WidgetStatePropertyAll(
        TextStyle(color: AppColors.green[100], fontSize: 50),
      ),
      backgroundColor: AppColors.green[700],
      hourMinuteColor: AppColors.green[400],
      hourMinuteTextColor: AppColors.green[25],
      dayPeriodColor: AppColors.red,
      dayPeriodTextColor: AppColors.green[25],
      dialBackgroundColor: AppColors.green[400],
      dialHandColor: AppColors.red,
      dialTextColor: AppColors.green[25],
      dayPeriodTextStyle: TextStyle(
        fontWeight: FontWeight.w900,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.green[400],
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        // Cancel Button
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      confirmButtonStyle: ButtonStyle(
        // Confirm Button
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
