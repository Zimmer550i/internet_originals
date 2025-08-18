import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/auth/email_verification.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isLoading = false;
  final auth = Get.find<AuthController>();

  bool obscureText = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String? nameError;
  String? emailError;
  String? phoneError;
  String? passError;
  String? conPassError;

  void registrationCallback() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String pass = passController.text.trim();
    String conPass = passController.text.trim();

    if (!isValid(name, email, phone, pass, conPass)) {
      setState(() {});
      return;
    }

    setState(() {
      isLoading = true;
    });

    final message = await auth.signup(name, email, phone, pass);

    if (message == "success") {
      showSnackBar("OTP Sent to $email", isError: false);
      Get.to(() => EmailVerification());
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
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomSvg(asset: AppIcons.logo, height: 64, width: 193),
                  const SizedBox(height: 40),
                  CustomTextField(
                    hintText: "Name",
                    leading: AppIcons.user,
                    controller: nameController,
                    errorText: nameError,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Email",
                    leading: AppIcons.mail,
                    controller: emailController,
                    errorText: emailError,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Phone Number",
                    leading: AppIcons.phone,
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                    errorText: phoneError,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Password",
                    leading: AppIcons.lock,
                    isPassword: true,
                    controller: passController,
                    errorText: passError,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Confirm Password",
                    leading: AppIcons.lock,
                    isPassword: true,
                    controller: confirmPassController,
                    errorText: conPassError,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(text: "Register", isLoading: isLoading, onTap: registrationCallback),
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

  bool isValid(
    String name,
    String email,
    String phone,
    String pass,
    String conPass,
  ) {
    if (name.isEmpty) {
      nameError = "This field cannot be empty";
    } else {
      nameError = null;
    }
    if (email.isEmpty) {
      emailError = "This field cannot be empty";
    } else {
      emailError = null;
    }
    if (phone.isEmpty) {
      phoneError = "This field cannot be empty";
    } else {
      phoneError = null;
    }
    if (pass.isEmpty) {
      passError = "This field cannot be empty";
    } else {
      passError = null;
    }

    if (pass != conPass) {
      conPassError = "Password didn't match";
    } else {
      conPassError = null;
    }

    if (nameError == null &&
        emailError == null &&
        phoneError == null &&
        passError == null &&
        conPassError == null) {
      return true;
    } else {
      return false;
    }
  }
}
