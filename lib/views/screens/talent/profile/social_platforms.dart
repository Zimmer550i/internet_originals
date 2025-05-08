import 'package:flutter/material.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_modal.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:get/get.dart';

class SocialPlatforms extends StatefulWidget {
  const SocialPlatforms({super.key});

  @override
  State<SocialPlatforms> createState() => _SocialPlatformsState();
}

class _SocialPlatformsState extends State<SocialPlatforms> {
  final TalentController talent = TalentController();

  @override
  void initState() {
    super.initState();
    talent.getSocialPlatforms();
  }

  _removeTap(String targetId) {
    showCustomModal(
      context: context,
      title: 'Are you sure about removing this account?',
      leftButtonText: 'Remove',
      rightButtonText: 'Cancel',
      onLeftButtonClick: () async {
        await talent.deleteSocialPlatform(targetId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Social Platforms'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Obx(
                () => Column(
                  children: [
                    ...talent.socialPlatforms.map((item) {
                      return SocialPlatformItem(
                        model: item,
                        onRemoveTap: (String id) {
                          _removeTap(id);
                        },
                      );
                    }),
                    if (talent.socialPlatforms.isEmpty)
                      Text("No social platform has been added"),
                  ],
                ),
              ),
              SizedBox(height: 36),
              CustomButton(
                text: 'Add Social Platform',
                leading: 'assets/icons/social_platforms/add_circle.svg',
                onTap: () {
                  Get.toNamed(AppRoutes.addSocials);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialPlatformItem extends StatelessWidget {
  final SocialPlatformModel model;
  final Function(String id) onRemoveTap;

  const SocialPlatformItem({
    super.key,
    required this.model,
    required this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.dark[400]!, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 18),
      margin: EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '${model.platformName}: ${model.url.split("/").last}',
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              onRemoveTap(model.id);
            },
            child: CustomSvg(
              asset: 'assets/icons/social_platforms/delete_circle.svg',
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}
