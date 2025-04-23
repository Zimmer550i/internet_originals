import 'package:flutter/material.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:get/get.dart';

class AddSocials extends StatefulWidget {
  final Function(SocialPlatFormModel)? onAddSocials;

  const AddSocials({super.key, this.onAddSocials});

  @override
  State<AddSocials> createState() => _AddSocialsState();
}

class _AddSocialsState extends State<AddSocials> {
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

  _addSocials() {


    // final reqBody = {
    //   'platform': platformController.text.trim(),
    //   'url': urlController.text.trim(),
    //   'followers': followersController.text.trim(),
    // };

    // final SocialPlatFormModel model = SocialPlatFormModel(
    //   id: '21',
    //   title: platformController.text.trim(),
    //   url: urlController.text.trim(),
    //   followerCount: int.parse(followersController.text.trim()),
    // );

    // widget.onAddSocials?.call(model);

                  Get.toNamed(AppRoutes.socialAdded);

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
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                hintText: 'Link',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: CustomTextField(
                hintText: 'Followers / Subscribers Count',
              ),
            ),
            SizedBox(height: 48),
            CustomButton(text: 'Submit', onTap: _addSocials),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
