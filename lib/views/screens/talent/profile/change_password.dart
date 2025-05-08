import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
  final user = Get.find<UserController>();
  bool isLoading = false;

  String? errorText;

  _updatePassword() async {
    if (newPass.text.trim().length < 6) {
      setState(() {
        errorText = "Password must contain at least 6 characters";
      });
      return;
    } else {
      setState(() {
        errorText = null;
      });
    }

    setState(() {
      isLoading = true;
    });

    final message = await user.changePassword(
      currentPass.text.trim(),
      newPass.text.trim(),
      confirmPass.text.trim(),
    );

    if (message == "success") {
      showSnackBar("Password successfully changed", isError: false);
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
      appBar: CustomAppBar(title: 'Change Password'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Current Password',
              controller: currentPass,
              leading: 'assets/icons/lock.svg',
              isPassword: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                hintText: 'New Password',
                controller: newPass,
                errorText: errorText,
                leading: 'assets/icons/lock.svg',
                isPassword: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),

              child: CustomTextField(
                hintText: 'Confirm Password',
                controller: confirmPass,
                leading: 'assets/icons/lock.svg',
                isPassword: true,
              ),
            ),
            SizedBox(height: 48),
            CustomButton(text: 'Set Password', onTap: _updatePassword),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
