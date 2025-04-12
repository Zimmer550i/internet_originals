import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/base/custom_app_bar.dart';
import 'package:internet_originals/base/custom_button.dart';
import 'package:internet_originals/screens/auth/reset_password.dart';
import 'package:internet_originals/screens/auth/user_information.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:pinput/pinput.dart';

class EmailVerification extends StatefulWidget {
  final String? bearer;
  const EmailVerification({super.key, this.bearer});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController otpController = TextEditingController();

  void otpVerification() {
    if (widget.bearer == null) {
      Get.to(() => UserInformation());
    } else {
      Get.to(() => ResetPassword());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Otp Verification"),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  widget.bearer == null
                      ? "Verify Your Email"
                      : "Reset Password",
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
                    "Please enter the OTP code, We’ve sent you in your mail.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 32),

                Pinput(
                  length: 6,
                  controller: otpController,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  defaultPinTheme: PinTheme(
                    height: 48,
                    width: 48,
                    textStyle: TextStyle(fontSize: 18, color: AppColors.dark),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        width: 0.5,
                        color: AppColors.red.shade400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(text: "Send OTP", onTap: otpVerification),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.green[100],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        " Register Now",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.red[400],
                        ),
                      ),
                    ),
                  ],
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
