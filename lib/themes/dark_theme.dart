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
  );
}
