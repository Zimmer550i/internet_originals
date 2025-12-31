import 'package:flutter/material.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_modal.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:get/get.dart';

class SocialPlatforms extends StatefulWidget {
  const SocialPlatforms({super.key});

  @override
  State<SocialPlatforms> createState() => _SocialPlatformsState();
}

class _SocialPlatformsState extends State<SocialPlatforms> {
  final user = Get.find<UserController>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  removeSocial(int index) async {
    setState(() {
      isLoading = true;
    });

    var prevList = user.userInfo.value!.socials;
    prevList.removeAt(index);
    final message = await user.updateInfo({
      "data": {"socials": (prevList)},
    });

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.until((route) => Get.currentRoute == AppRoutes.socialPlatforms);
      showSnackBar("Social platform removed successfully", isError: false);
    } else {
      showSnackBar(message);
    }
  }

  _removeTap(int index) {
    showCustomModal(
      context: context,
      title: 'Are you sure about removing this account?',
      leftButtonText: 'Remove',
      rightButtonText: 'Cancel',
      onLeftButtonClick: () async {
        await removeSocial(index);
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
                    for (
                      int i = 0;
                      i < user.userInfo.value!.socials.length;
                      i++
                    )
                      SocialPlatformItem(
                        model: user.userInfo.value!.socials[i],
                        onRemoveTap: () => _removeTap(i),
                      ),
                    if (user.userInfo.value!.socials.isEmpty)
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
  final void Function() onRemoveTap;

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
              '${model.platform}: ${model.link.split("/").last}',
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
            onTap: onRemoveTap,
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
