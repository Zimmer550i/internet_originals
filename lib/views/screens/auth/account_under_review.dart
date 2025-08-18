import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/screens/auth/login.dart';

class AccountUnderReview extends StatelessWidget {
  const AccountUnderReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomLoading(size: 142, secondsPerRotation: 4),
                const SizedBox(height: 60),
                Text(
                  "Your Informations Are Under Review",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: AppColors.red[400],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Thank you for submitting your details! Our team is\nreviewing your informations. You’ll receive a\nnotification once the verification is complete.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: "Log Out",
                  onTap: () {
                    Get.find<AuthController>().logout();
                    Get.offAll(() => Login());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
