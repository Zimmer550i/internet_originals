import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/auth/forgot_password.dart';
import 'package:internet_originals/views/screens/auth/registration.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/svg.dart';
import 'package:internet_originals/views/screens/sub_admin/sub_admin_app.dart';
import 'package:internet_originals/views/screens/talent/talent_app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void loginCallback() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Role"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Talent"),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => TalentApp());
                },
              ),
              ListTile(
                title: Text("Sub Admin"),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => SubAdminApp());
                },
              ),
            ],
          ),
        );
      },
    );
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
                Svg(asset: AppIcons.logo, height: 64, width: 193),
                const SizedBox(height: 40),
                CustomTextField(
                  hintText: "Enter Email",
                  leading: AppIcons.mail,
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Enter Password",
                  leading: AppIcons.lock,
                  isPassword: true,
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
                CustomButton(text: "Login", onTap: loginCallback),
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
}
