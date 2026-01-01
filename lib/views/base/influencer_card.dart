import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/campaign_assigned.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/campaign_list.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/pending_influencer_details.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/send_notification.dart';

class InfluencerCard extends StatelessWidget {
  final UserModel influencer;
  final CampaignModel? campaign;
  final bool showDetails;
  final String? status;
  final void Function()? callbackButton;
  final bool sendNotification;
  final Widget? button;
  const InfluencerCard({
    super.key,
    required this.influencer,
    this.campaign,
    this.status,
    this.callbackButton,
    this.sendNotification = false,
    this.showDetails = false,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>();

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
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.dark.shade400,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: AppColors.red,
                                  ),
                                ),
                              ),
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
              if (showDetails &&
                  influencer.role == EUserRole.USER &&
                  status == null)
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
          if (button != null) Center(child: button!),
          if (influencer.role == EUserRole.USER &&
              !showDetails &&
              status == null)
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
          if (influencer.role == EUserRole.INFLUENCER &&
              user.userInfo.value!.role == EUserRole.SUB_ADMIN &&
              campaign == null &&
              status == null &&
              !sendNotification)
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
          if (sendNotification)
            Center(
              child: CustomButton(
                text: "Send Notification",
                width: null,
                height: 40,
                textSize: 14,
                onTap: () {
                  Get.to(() => SendNotification(influencer: influencer));
                },
              ),
            ),

          if (campaign != null && status == null)
            Center(
              child: CustomButton(
                text: "Assign",
                width: null,
                height: 40,
                textSize: 14,
                onTap: () {
                  showCampaignAssignModal(
                    context: context,
                    influencer: influencer,
                    campaign: campaign!,
                  );
                },
              ),
            ),
          if (status == "ACTIVE")
            Row(
              spacing: 4,
              children: [
                CustomSvg(
                  asset: "assets/icons/payments/warning_circle.svg",
                  size: 18,
                  color: Color(0xffFFDC00),
                ),
                Text(
                  "Status: Pending Submission",
                  style: TextStyle(fontSize: 14, height: 20 / 14),
                ),
              ],
            ),
          if (status == "COMPLETED")
            Row(
              spacing: 4,
              children: [
                CustomSvg(asset: "assets/icons/tick_circle.svg", size: 18),
                Text(
                  "Status: Metrics Submitted",
                  style: TextStyle(fontSize: 14, height: 20 / 14),
                ),
              ],
            ),
          if (status == "COMPLETED")
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: CustomButton(
                  height: 40,
                  text: "Check Metrics",
                  width: null,
                  onTap: callbackButton,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

showCampaignAssignModal({
  required BuildContext context,
  required UserModel influencer,
  required CampaignModel campaign,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {
                // Do nothing here, this prevents the gesture detector of the whole container
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 36,
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.dark[600],
                  border: Border.all(color: AppColors.dark[400]!, width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      'Are you sure you want to assign',
                      style: TextStyle(
                        color: AppColors.dark[50],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child:
                              influencer.avatar == null
                                  ? SizedBox(height: 24, width: 24)
                                  : Image.network(
                                    ApiService().baseUrl + influencer.avatar!,
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          influencer.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'to',
                          style: TextStyle(
                            color: AppColors.dark[50],
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.network(
                            ApiService().baseUrl + campaign.banner,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          campaign.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Cancel',
                            isSecondary: true,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              text: 'Confirm',
                              isLoading:
                                  Get.find<SubAdminController>()
                                      .campaignLoading
                                      .value,
                              onTap: () {
                                Get.find<SubAdminController>()
                                    .assignCampaign(influencer.id, campaign.id)
                                    .then((message) {
                                      if (message == "success") {
                                        Get.to(
                                          () => CampaignAssigned(
                                            influncer: influencer,
                                            campaign: campaign,
                                          ),
                                        );
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
              ),
            ),
          ),
        ),
      );
    },
  );
}
