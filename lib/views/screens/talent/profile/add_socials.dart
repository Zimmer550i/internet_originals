import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';

class AddSocials extends StatefulWidget {
  const AddSocials({super.key});

  @override
  State<AddSocials> createState() => _AddSocialsState();
}

class _AddSocialsState extends State<AddSocials> {
  final talent = Get.find<TalentController>();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController followersController = TextEditingController();

  @override
  void dispose() {
    platformController.dispose();
    urlController.dispose();
    followersController.dispose();

    super.dispose();
  }

  _addSocials() async {
    final message = await talent.addSocialPlatform(
      platformController.text,
      urlController.text,
      followersController.text,
    );

    if (message == "success") {
      Get.until((route) => Get.currentRoute == AppRoutes.socialPlatforms);
      showSnackBar("Social platform added successfully");
    } else {
      showSnackBar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Social Platform'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Social Platform (e.g. Youtube, Instagram)',
              controller: platformController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                hintText: 'Link',
                controller: urlController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                hintText: 'Followers / Subscribers Count',
                controller: followersController,
              ),
            ),
            SizedBox(height: 48),
            Obx(
              () => CustomButton(
                text: 'Submit',
                onTap: _addSocials,
                isLoading: talent.isLoading.value,
              ),
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
