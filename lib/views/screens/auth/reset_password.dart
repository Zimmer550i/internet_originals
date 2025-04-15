import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/auth/login.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  void resetPassword() {
    showSnackBar("Password has been reset");
    Get.offAll(() => Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset Password"),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Enter Password",
                  leading: AppIcons.lock,
                  isPassword: true,
                  controller: passController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Confirm Password",
                  leading: AppIcons.lock,
                  isPassword: true,
                  controller: confirmPassController,
                ),
                const SizedBox(height: 24),
                CustomButton(text: "Confirm", onTap: resetPassword),
                const SizedBox(height: 140),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
