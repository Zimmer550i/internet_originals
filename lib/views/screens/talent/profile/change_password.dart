import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  _updatePassword() {
    //TODO: call update password api
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
              leading: 'assets/icons/lock.svg',
              isPassword: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                hintText: 'New Password',
                leading: 'assets/icons/lock.svg',
                isPassword: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),

              child: CustomTextField(
                hintText: 'Confirm Password',
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
