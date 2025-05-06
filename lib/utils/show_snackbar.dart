import 'package:internet_originals/main.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(String message, {bool isError = true}) {
  rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: isError ? AppColors.red : Colors.blue,
      content: Text(
        message,
        style: TextStyle(
          fontVariations: [FontVariation("wght", 400)],
          fontSize: 14,
          color: AppColors.red[25],
        ),
      ),
    ),
  );
}
