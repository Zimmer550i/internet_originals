import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/base/profile_picture.dart';

class AdminPersonalInformation extends StatefulWidget {
  const AdminPersonalInformation({super.key});

  @override
  State<AdminPersonalInformation> createState() =>
      _AdminPersonalInformationState();
}

class _AdminPersonalInformationState extends State<AdminPersonalInformation> {
  bool _isEditing = false;

  _updateProfile() {
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Personal Information'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            ProfilePicture(
              image: "https://picsum.photos/200/300",
              imagePickerCallback: (p0) {},
              size: MediaQuery.of(context).size.width * 0.26,
            ),
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                isDisabled: !_isEditing,
                hintText: 'Chelofer',
                leading: 'assets/icons/personal_information/user.svg',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                isDisabled: !_isEditing,
                hintText: 'susan@gmail.com',
                leading: 'assets/icons/personal_information/mail.svg',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),

              child: CustomTextField(
                isDisabled: !_isEditing,
                hintText: '+88012 3456-7897',
                leading: 'assets/icons/personal_information/phone.svg',
              ),
            ),
            SizedBox(height: 48),
            CustomButton(
              text: _isEditing ? 'Update' : 'Edit Profile',
              isSecondary: !_isEditing,
              onTap: () {
                if (_isEditing) {
                  _updateProfile();
                } else {
                  setState(() {
                    _isEditing = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
