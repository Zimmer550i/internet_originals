import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  List<int> ratings = [0, 0];

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
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.green[600],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.green[400]!),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 52,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.green[400]!),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Rate Your Experience with",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 30 / 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: Image.network(
                              "https://picsum.photos/200/200",
                              height: 44,
                              width: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sophia Carter",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.green[25],
                                  height: 28 / 18,
                                ),
                              ),
                              Row(
                                spacing: 4,
                                children: [
                                  for (int i = 0; i < 4; i++)
                                    CustomSvg(
                                      asset: AppIcons.starDark,
                                      size: 16,
                                    ),
                                  for (int i = 0; i < 1; i++)
                                    CustomSvg(asset: AppIcons.star, size: 16),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      ratingWidget("Rate Influencer Performance", 0),
                      const SizedBox(height: 36),
                      ratingWidget("Overall Experience", 1),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: "Submit",
                        width: null,
                        height: 40,
                        onTap: () {
                          Get.until((route) {
                            return Get.currentRoute == AppRoutes.subAdminApp;
                          });
                        },
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
