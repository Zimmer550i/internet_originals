import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_constants.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/auth/account_under_review.dart';
import 'package:internet_originals/views/screens/auth/email_verification.dart';
import 'package:internet_originals/views/screens/auth/forgot_password.dart';
import 'package:internet_originals/views/screens/auth/registration.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String? emailError;
  String? passError;
  final auth = Get.find<AuthController>();

  void loginCallback() async {
    final String email = emailController.text.trim();
    final String pass = passController.text.trim();

    setState(() {
      isLoading = true;
    });

    final message = await auth.login(email, pass);

    if (message == "success") {
      final role = Get.find<UserController>().userInfo.value!.role;
      if (role == "SUB_ADMIN") {
        Get.offNamed(AppRoutes.subAdminApp);
      } else if (role == "INFLUENCER") {
        Get.offNamed(AppRoutes.talentApp);
      }
    } else if (message ==
        "Please verify your account, then try to login again") {
      final message = await auth.sendOtp(email);
      if (message == "success") {
        showSnackBar("OTP sent to $email");
        Get.to(() => EmailVerification());
      } else {
        showSnackBar(message);
      }
    } else if (message == "pending") {
      Get.to(() => AccountUnderReview());
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
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomSvg(asset: AppIcons.logo, height: 64, width: 193),
                const SizedBox(height: 40),
                CustomTextField(
                  hintText: "Enter Email",
                  leading: AppIcons.mail,
                  controller: emailController,
                  errorText: emailError,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Enter Password",
                  leading: AppIcons.lock,
                  isPassword: true,
                  errorText: passError,
                  controller: passController,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () =>
                            ForgotPassword(email: emailController.text.trim()),
                      );
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.red[400],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: "Login",
                  isLoading: isLoading,
                  onTap: loginCallback,
                ),
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
                      onTap: () {
                        Get.to(() => Registration());
                      },
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValid(String email, String pass) {
    if (!email.contains(AppConstants.emailValidator)) {
      emailError = "Invalid email address";
    } else {
      emailError = null;
    }

    if (pass.isEmpty) {
      passError = "Enter password";
    } else {
      passError = null;
    }

    if (emailError == null && passError == null) {
      return true;
    } else {
      return false;
    }
  }
}
