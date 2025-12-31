import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/screens/auth/reset_password.dart';
import 'package:internet_originals/views/screens/auth/user_information.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:pinput/pinput.dart';

class EmailVerification extends StatefulWidget {
  final bool resetPass;
  final String? email;
  final String? token;
  const EmailVerification({
    super.key,
    this.resetPass = false,
    this.email,
    this.token,
  });

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isLoading = false;
  TextEditingController otpController = TextEditingController();
  final auth = Get.find<AuthController>();

  void otpVerification() async {
    setState(() {
      isLoading = true;
    });

    final message = await auth.verifyEmail(
      widget.email ?? Get.find<UserController>().userInfo.value!.email,
      otpController.text.trim(),
      isResetingPassword: widget.resetPass,
    );

    if (message.contains("token")) {
      Get.to(() => ResetPassword(token: message.split(" ").last));
    } else if (message == "success") {
      if (Get.find<UserController>().userInfo.value!.role ==
          EUserRole.MANAGER) {
        Get.offNamed(AppRoutes.managerApp);
      } else {
        Get.to(() => UserInformation());
      }
    } else {
      showSnackBar(message);
    }

    setState(() {
      isLoading = false;
    });
  }

  void resendOtp() async {
    final message =
        widget.resetPass
            ? await auth.forgotPassword(widget.email!)
            : await auth.sendOtp(widget.email!);

    if (message == "success") {
      showSnackBar(
        "OTP sent to ${widget.email ?? "wasiul0491@gmail.com"}",
        isError: false,
      );
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
                  !widget.resetPass ? "Verify Your Email" : "Reset Password",
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
                CustomButton(
                  text: "Verify",
                  onTap: otpVerification,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t get code?",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.green[100],
                      ),
                    ),
                    GestureDetector(
                      onTap: resendOtp,
                      child: Text(
                        " Resend",
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
