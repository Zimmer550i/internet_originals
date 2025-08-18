import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class ResetPassword extends StatefulWidget {
  final String token;
  const ResetPassword({super.key, required this.token});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isLoading = false;
  final auth = Get.find<AuthController>();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  void resetPassword() async {
    if (passController.text.trim() != confirmPassController.text.trim()) {
      showSnackBar("Password didn't match");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final message = await auth.resetPassword(
      passController.text.trim(),
      widget.token
    );

    if (message == "success") {
      showSnackBar("Your password has been changed", isError: false);
      Get.back();
      Get.back();
      Get.back();
    } else {
      showSnackBar(message);
    }

    setState(() {
      isLoading = false;
    });
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
                CustomButton(
                  text: "Confirm",
                  onTap: resetPassword,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 140),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
