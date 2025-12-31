import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/base/profile_picture.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  bool _isEditing = false;
  bool isLoading = false;
  File? _image;
  final user = Get.find<UserController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  _updateProfile() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> payload = {};
    payload['data'] = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "address": locationController.text.trim(),
    };

    if (_image != null) {
      payload['avatar'] = _image;
    }
    final message = await user.updateInfo(payload);

    if (message == "success") {
      user.getInfo();
      showSnackBar("Personal information updated!", isError: false);
    } else {
      showSnackBar(message);
    }

    setState(() {
      isLoading = false;
      _isEditing = false;
    });
  }

  @override
  void initState() {
    super.initState();

    nameController.text = user.userInfo.value!.name;
    emailController.text = user.userInfo.value!.email;
    phoneController.text = user.userInfo.value!.phone ?? "";
    locationController.text = user.userInfo.value!.address ?? "";
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
            SizedBox(height: 24),
            ProfilePicture(
              image: user.getImageUrl(),
              imageFile: _image,
              imagePickerCallback:
                  !_isEditing
                      ? null
                      : (image) {
                        setState(() {
                          _image = image;
                        });
                      },
              size: 116,
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                isDisabled: !_isEditing,
                controller: nameController,
                leading: 'assets/icons/personal_information/user.svg',
              ),
            ),
            if(!_isEditing)
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                isDisabled: !_isEditing,
                controller: emailController,
                leading: 'assets/icons/personal_information/mail.svg',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                isDisabled: !_isEditing,
                controller: phoneController,
                leading: 'assets/icons/personal_information/phone.svg',
              ),
            ),
            if(user.userInfo.value?.role != EUserRole.SUB_ADMIN)
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                isDisabled: !_isEditing,
                controller: locationController,
                leading: 'assets/icons/personal_information/location.svg',
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
