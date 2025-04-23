import 'package:flutter/material.dart';
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
  List<SocialPlatFormModel> _socialItems = [
    SocialPlatFormModel(
      id: 'abc',
      title: 'Instagram',
      url: '@susan',
      followerCount: 10,
    ),
    SocialPlatFormModel(
      id: 'efg',
      title: 'Facebook',
      url: 'facebook.com/susan123',
      followerCount: 10,
    ),
  ];

  _removeItem(String targetId) {

    List<SocialPlatFormModel> newItems = [];
    for (SocialPlatFormModel item in _socialItems) {
      if (item.id != targetId) {
        newItems.add(item);
      }
    }

    setState(() {
      _socialItems = newItems;
    });
  }

  _removeTap(String targetId) {
    showCustomModal(
      context: context,
      title: 'Are you sure about removing this account?',
      leftButtonText: 'Remove',
      rightButtonText: 'Cancel',
      onLeftButtonClick: () {
        _removeItem(targetId);
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
              ..._socialItems.map((item) {
                return SocialPlatformItem(
                  model: item,
                  onRemoveTap: () {
                    _removeTap(item.id);
                  },
                );
              }),
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
  final SocialPlatFormModel model;
  final Function()? onRemoveTap;

  SocialPlatformItem({super.key, required this.model, this.onRemoveTap});

  final List<String> supportedSocials = ['instagram', 'facebook'];

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
          CustomSvg(
            asset:
                supportedSocials.contains(model.title.toLowerCase())
                    ? 'assets/icons/social_platforms/${model.title.toLowerCase()}.svg'
                    : 'assets/icons/social_platforms/default.svg',
            width: 28,
            height: 28,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '${model.title}: ${model.url}',
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
