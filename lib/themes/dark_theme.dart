import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';

ThemeData dark() {
  // Start with the default dark theme
  final base = ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.green[700],
    textTheme: base.textTheme.apply(
      fontFamily: "Open-Sans",
      bodyColor: Colors.white, // sets default color for body text
      displayColor: Colors.white, // sets default color for display text
    ),
  );
}
