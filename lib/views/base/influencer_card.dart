import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/campaign_list.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/pending_influencer_details.dart';

class InfluencerCard extends StatelessWidget {
  final UserModel influencer;
  final bool showDetails;
  const InfluencerCard({
    super.key,
    required this.influencer,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.green[600],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.green[400]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child:
                    influencer.avatar != null
                        ? Image.network(
                          (ApiService().baseUrl + influencer.avatar!),
                          height: 44,
                          width: 44,
                          fit: BoxFit.cover,
                        )
                        : SizedBox(height: 44, width: 44),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    influencer.name,
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
                      for (int i = 0; i < influencer.rating.round(); i++)
                        CustomSvg(asset: AppIcons.starDark, size: 16),
                      for (int i = 0; i < 5 - influencer.rating.round(); i++)
                        CustomSvg(asset: AppIcons.star, size: 16),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (influencer.socials.isNotEmpty)
                Text(
                  "Social Handle: @${influencer.socials.elementAt(0).link.split("/").last}",
                  style: TextStyle(fontSize: 14, height: 20 / 14),
                ),
              if (influencer.socials.isNotEmpty)
                Text(
                  "Followers: ${Formatter.formatNumberMagnitude(influencer.socials.elementAt(0).followers.toDouble())}",
                  style: TextStyle(fontSize: 14, height: 20 / 14),
                ),
              if (showDetails)
                Text(
                  "Overall Rating: ${influencer.rating}",
                  style: TextStyle(fontSize: 14, height: 20 / 14),
                ),
              if (showDetails)
                Text(
                  "Location: ${influencer.address}",
                  style: TextStyle(fontSize: 14, height: 20 / 14),
                ),
              if (showDetails)
                Text(
                  "Requested on: ${Formatter.prettyDate(influencer.createdAt.millisecondsSinceEpoch)}",
                  style: TextStyle(fontSize: 14, height: 20 / 14),
                ),
              const SizedBox(height: 12),
              if (showDetails && influencer.role == EUserRole.USER)
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Decline',
                        height: 40,
                        textSize: 14,
                        isSecondary: true,
                        onTap: () {
                          Get.find<SubAdminController>()
                              .declineInfluencer(influencer.id)
                              .then((message) {
                                if (message == "success") {
                                  Get.until((route) {
                                    return Get.currentRoute ==
                                        AppRoutes.subAdminApp;
                                  });
                                  showSnackBar(
                                    "Influencer declined!",
                                    isError: false,
                                  );
                                  Get.find<SubAdminController>().getInfluencers(
                                    getPending: true,
                                  );
                                } else {
                                  showSnackBar(message);
                                }
                              });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(
                        () => CustomButton(
                          text: 'Approve',
                          height: 40,
                          textSize: 14,
                          isLoading:
                              Get.find<SubAdminController>()
                                  .influencerLoading
                                  .value,
                          onTap: () {
                            Get.find<SubAdminController>()
                                .approveInfluencer(influencer.id)
                                .then((message) {
                                  if (message == "success") {
                                    Get.until((route) {
                                      return Get.currentRoute ==
                                          AppRoutes.subAdminApp;
                                    });
                                    showSnackBar(
                                      "Influencer approved!",
                                      isError: false,
                                    );
                                    Get.find<SubAdminController>()
                                        .getInfluencers(getPending: true);
                                  } else {
                                    showSnackBar(message);
                                  }
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (influencer.role == EUserRole.USER && !showDetails)
            Center(
              child: CustomButton(
                text: "View Details",
                width: null,
                height: 40,
                textSize: 14,
                onTap: () {
                  Get.to(
                    () => PendingInfluencerDetails(influencer: influencer),
                  );
                },
              ),
            ),
          if (influencer.role == EUserRole.INFLUENCER)
            Center(
              child: CustomButton(
                text: "Assign a Campaign",
                width: null,
                height: 40,
                textSize: 14,
                onTap: () {
                  Get.to(() => CampaignList(influencer: influencer));
                },
              ),
            ),
        ],
      ),
    );
  }
}
