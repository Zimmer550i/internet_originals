import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/base/profile_picture.dart';
import 'package:internet_originals/views/screens/auth/account_under_review.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  File? _profilePic;
  TextEditingController addressController = TextEditingController();
  TextEditingController socialController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController followersController = TextEditingController();

  void submitInformation() {
    // final address = addressController.text.trim();
    // final social = socialController.text.trim();
    // final link = linkController.text.trim();
    // final followers = followersController.text.trim();

    Get.to(() => AccountUnderReview());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "User Information"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    final image = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (image != null) {
                      setState(() {
                        _profilePic = File(image.path);
                      });
                    }
                  },
                  child: ProfilePicture(
                    imageFile: _profilePic,
                    allowEdit: true,
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  hintText: "Address",
                  controller: addressController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Social Platform (Example: Youtube, Instagram)",
                  controller: socialController,
                ),
                const SizedBox(height: 16),
                CustomTextField(hintText: "Link", controller: linkController),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Subscriber/Follower Count",
                  controller: followersController,
                ),
                const SizedBox(height: 40),
                CustomButton(text: "Submit", onTap: submitInformation),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
