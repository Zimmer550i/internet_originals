import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class TalentFeedback extends StatefulWidget {
  final CampaignModel campaign;
  const TalentFeedback({super.key, required this.campaign});

  @override
  State<TalentFeedback> createState() => _TalentFeedbackState();
}

class _TalentFeedbackState extends State<TalentFeedback> {
  final talent = Get.find<TalentController>();
  List<int> ratings = [0, 0, 0];

  void uploadData() async {
    Map<String, dynamic> data = {
      "Campaign Clarity": ratings[0],
      "Budget & Payment": ratings[1],
      "Overall Experience": ratings[2],
    };

    final message = await talent.giveCampaignFeedback(widget.campaign.id, data);

    if (message == "success") {
      showSnackBar("Rating submitted successfully", isError: false);
      Get.until(
        (route) =>
            Get.currentRoute == AppRoutes.talentApp ||
            Get.currentRoute == AppRoutes.subAdminApp,
      );
    } else {
      showSnackBar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Rating"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.green[600],
                    border: Border.all(color: AppColors.green[400]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Rate Your Experience with",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: AppColors.green[300]!,
                      ),
                      const SizedBox(height: 24),
                      ratingWidget("Campaign Clarity", 0),
                      const SizedBox(height: 36),
                      ratingWidget("Budget & Payment", 1),
                      const SizedBox(height: 36),
                      ratingWidget("Overall Experience", 2),
                      const SizedBox(height: 40),
                      Obx(
                        () => CustomButton(
                          text: "Submit",
                          isLoading: talent.campaignLoading.value,
                          width: null,
                          onTap: () => uploadData(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ratingWidget(String title, int index) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            for (int i = 0; i < ratings[index]; i++)
              InkWell(
                borderRadius: BorderRadius.circular(999),
                splashColor: AppColors.red,
                onTap: () {
                  setState(() {
                    ratings[index] = i + 1;
                  });
                },
                child: CustomSvg(asset: AppIcons.starDark, size: 35),
              ),
            for (int i = ratings[index]; i < 5; i++)
              InkWell(
                borderRadius: BorderRadius.circular(999),
                splashColor: AppColors.red,
                onTap: () {
                  setState(() {
                    ratings[index] = i + 1;
                  });
                },
                child: CustomSvg(asset: AppIcons.star, size: 35),
              ),
          ],
        ),
      ],
    );
  }
}
