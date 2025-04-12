import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/base/custom_button.dart';
import 'package:internet_originals/base/custom_text_field.dart';
import 'package:internet_originals/screens/auth/email_verification.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/utils/svg.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool obscureText = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  void registrationCallback() {
    String name = nameController.text.trim();
    // String email = emailController.text.trim();
    // String phone = phoneController.text.trim();
    // String pass = passController.text.trim();

    if (name != "") {
      showSnackBar("Hi $name");
    }
    Get.to(() => EmailVerification());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          reverse: true,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Svg(asset: AppIcons.logo, height: 64, width: 193),
                  const SizedBox(height: 40),
                  CustomTextField(
                    hintText: "Name",
                    leading: AppIcons.user,
                    controller: nameController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Email",
                    leading: AppIcons.mail,
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Phone Number",
                    leading: AppIcons.phone,
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Password",
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
                  const SizedBox(height: 40),
                  CustomButton(text: "Register", onTap: registrationCallback),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.green[100],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          " Login",
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
      ),
    );
  }
}
