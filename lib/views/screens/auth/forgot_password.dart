import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/auth/email_verification.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class ForgotPassword extends StatefulWidget {
  final String email;
  const ForgotPassword({super.key, required this.email});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
  }

  void sendOtpCallback() async {
    setState(() {
      isLoading = true;
    });

    final message = await Get.find<AuthController>().forgotPassword(
      emailController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.to(
        () => EmailVerification(email: emailController.text, resetPass: true),
      );
      showSnackBar(
        "Otp sent to ${emailController.text.trim()}",
        isError: false,
      );
    } else {
      showSnackBar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Forgot Password"),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: AppColors.red[400],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Please enter your email address to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  hintText: "Enter Email",
                  leading: AppIcons.mail,
                  controller: emailController,
                ),
                const SizedBox(height: 24),
                CustomButton(text: "Send OTP", onTap: sendOtpCallback, isLoading: isLoading,),
                const SizedBox(height: 140),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
