import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_networked_image.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/base/profile_picture.dart';
import 'package:internet_originals/views/screens/manager/campaign/manager_campaign_details.dart';
import 'package:internet_originals/views/screens/manager/campaign/manager_performance_metrics.dart';
import 'package:internet_originals/views/screens/manager/payments/manager_payment_selection.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/add_influencers.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/assigned_influencers.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/campaign_issues.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/create_new_campaign.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/campaign_assigned.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_campaign_details.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_feedback.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_performance_metrics.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_sign_contract.dart';

class CampaignCard extends StatelessWidget {
  final bool isDetailed;
  final CampaignModel campaign;
  final UserModel? influencer;
  const CampaignCard({
    super.key,
    this.influencer,
    this.isDetailed = false,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.green[600],
        border: Border.all(color: AppColors.green[400]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          const SizedBox(height: 12),
          isDetailed ? detailedInfo(context) : shortInfo(),
          const SizedBox(height: 8),
          if (campaign.influencer != null && !isDetailed)
            Row(
              children: [
                Text("Your Connected Talent"),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColors.green[25],
                    shape: BoxShape.circle,
                  ),
                  child: ProfilePicture(
                    image:
                        "${ApiService().baseUrl}${campaign.influencer?['avatar']}",
                    size: 24,
                  ),
                ),
              ],
            ),
          if (!isDetailed && influencer == null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: CustomButton(
                  text: "View Details",
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  textSize: 14,
                  onTap: () {
                    if (Get.find<UserController>().userInfo.value!.role ==
                        EUserRole.MANAGER) {
                      Get.to(() => ManagerCampaignDetails(campaign: campaign));
                    } else {
                      Get.to(() => TalentCampaignDetails(campaign: campaign));
                    }
                  },
                ),
              ),
            ),
          if (influencer != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: CustomButton(
                  text: "Assign",
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  textSize: 14,
                  onTap: () {
                    showCampaignAssignModal(
                      context: context,
                      campaign: campaign,
                      influencer: influencer,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Row header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkedImage(url: "${ApiService().baseUrl}${campaign.banner}"),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campaign.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: "Open-Sans",
                  color: AppColors.green[25],
                ),
              ),
              Text(
                campaign.brand,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Open-Sans",
                  color: AppColors.green[25],
                ),
              ),
            ],
          ),
        ),
        if (isDetailed &&
            Get.find<UserController>().userInfo.value!.role ==
                EUserRole.SUB_ADMIN)
          InkWell(
            onTap: () {
              Get.to(() => CreateNewCampaign(campaign: campaign));
            },
            child: CustomSvg(asset: "assets/icons/edit.svg"),
          ),
        if (!isDetailed &&
            Get.find<UserController>().userInfo.value!.role ==
                EUserRole.SUB_ADMIN)
          CustomSvg(
            asset: "assets/icons/payments/warning_circle.svg",
            size: 18,
            color: Color(0xffFFDC00),
          ),
      ],
    );
  }

  detailedInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              height: 1.5,
              fontFamily: "Open-Sans",
              color: AppColors.green[25],
            ),
            children: [
              TextSpan(text: 'Description: '),
              TextSpan(text: '${campaign.campaignType}\n'),

              TextSpan(text: 'Content Type: '),
              TextSpan(text: '${campaign.contentType}\n'),

              TextSpan(text: 'Metrics Needed: '),

              if (campaign.expectedMetrics != null)
                for (var i in campaign.expectedMetrics!.entries)
                  TextSpan(
                    text: "${i.value} ",
                    children: [
                      TextSpan(
                        text:
                            "${i.key.substring(0, 1).toUpperCase() + i.key.substring(1)}${campaign.expectedMetrics!.entries.last.key == i.key ? "" : ", "}",
                      ),
                    ],
                  ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            CustomSvg(asset: AppIcons.price, color: AppColors.red, size: 18),
            const SizedBox(width: 8),
            Text(
              "\$${campaign.budget} ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              "(${campaign.payoutDeadline})",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            CustomSvg(asset: AppIcons.calendar, color: AppColors.red, size: 18),
            const SizedBox(width: 8),
            Text(
              formatDateRange(campaign.createdAt, campaign.duration),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 20),
          child: Row(
            spacing: 8,
            children: [
              if (Get.find<UserController>().userInfo.value!.role ==
                  EUserRole.SUB_ADMIN)
                CustomSvg(
                  asset: "assets/icons/payments/warning_circle.svg",
                  size: 18,
                  color: Color(0xffFFDC00),
                ),
              if (Get.find<UserController>().userInfo.value!.role ==
                  EUserRole.SUB_ADMIN)
                Text(
                  "${campaign.unreadIssueCount} Issue reported",
                  style: TextStyle(fontSize: 16),
                ),
              GestureDetector(
                onTap: () {
                  if (Get.find<UserController>().userInfo.value!.role ==
                      EUserRole.SUB_ADMIN) {
                    Get.to(() => CampaignIssues(id: campaign.id));
                  } else {
                    reportIssue(context);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Text(
                  (Get.find<UserController>().userInfo.value!.role ==
                          EUserRole.SUB_ADMIN)
                      ? "See Issue"
                      : "Report Issue",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.red[300],
                    decorationColor: AppColors.red[300],
                    decorationThickness: 2,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (campaign.influencer != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text("Your Connected Talent"),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColors.green[25],
                    shape: BoxShape.circle,
                  ),
                  child: ProfilePicture(
                    image:
                        "${ApiService().baseUrl}${campaign.influencer?['avatar']}",
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

        if (campaign.status == "PENDING" &&
            Get.find<UserController>().userInfo.value!.role ==
                EUserRole.INFLUENCER)
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: "Decline",
                  textSize: 14,
                  isSecondary: true,
                  onTap: () {
                    declineCampaign(context);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  text: "Accept",
                  textSize: 14,
                  onTap: () {
                    Get.to(() => TalentSignContract(id: campaign.id));
                  },
                ),
              ),
            ],
          ),

        if (campaign.status == "ACTIVE" &&
            Get.find<UserController>().userInfo.value!.role ==
                EUserRole.INFLUENCER)
          Align(
            child: CustomButton(
              text: "Upload Matrix",
              width: null,
              textSize: 14,
              onTap: () {
                Get.to(() => TalentPerformanceMetrics(campaign: campaign));
              },
            ),
          ),

        if (campaign.status == "ACTIVE" &&
            Get.find<UserController>().userInfo.value!.role ==
                EUserRole.MANAGER)
          Align(
            child: CustomButton(
              text: "Upload Matrix",
              width: null,
              textSize: 14,
              onTap: () {
                Get.to(() => ManagerPerformanceMetrics(campaign: campaign));
              },
            ),
          ),

        if (campaign.status == "COMPLETED" &&
            Get.find<UserController>().userInfo.value!.role ==
                EUserRole.INFLUENCER)
          Align(
            child: CustomButton(
              text: "Give Feedback",
              width: null,
              textSize: 14,
              onTap: () {
                Get.to(() => TalentFeedback(campaign: campaign));
              },
            ),
          ),

        if (campaign.status == "COMPLETED" &&
            campaign.paymentStatus == "PENDING" &&
            Get.find<UserController>().userInfo.value!.role ==
                EUserRole.MANAGER)
          Align(
            child: CustomButton(
              text: "Send Payment Request",
              width: null,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textSize: 14,
              onTap: () {
                Get.to(() => ManagerPaymentSelection(campaign: campaign));
              },
            ),
          ),

        if (Get.find<UserController>().userInfo.value!.role ==
            EUserRole.SUB_ADMIN)
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: "Add Influencers",
                  width: null,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  isSecondary: true,
                  onTap: () => Get.to(() => AddInfluencers(campaign: campaign)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  text: "See Influencers",
                  width: null,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  isSecondary: true,
                  onTap:
                      () =>
                          Get.to(() => AssignedInfluencers(campaign: campaign)),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Future<dynamic> reportIssue(BuildContext context) {
    final controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.green[600],
              border: Border.all(color: AppColors.green[400]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "What is missing?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 28 / 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controller,
                    hintText: "Describe the issue",
                  ),
                  const SizedBox(height: 40),
                  Obx(() {
                    final talent = Get.find<TalentController>();

                    return CustomButton(
                      text: "Send Report",
                      isLoading: talent.campaignLoading.value,
                      width: null,
                      textSize: 14,
                      onTap: () {
                        talent
                            .reportAnIssue(campaign.id, controller.text.trim())
                            .then((message) {
                              if (message == "success") {
                                showSnackBar(
                                  "Report successfully submitted",
                                  isError: false,
                                );
                              } else {
                                showSnackBar(message);
                              }
                            });
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> declineCampaign(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.green[600],
              border: Border.all(color: AppColors.green[400]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Are you sure you want to decline?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18,
                      height: 28 / 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "This campaign will no longer appear in your request list.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 28 / 18,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Cancel",
                          textSize: 14,
                          padding: EdgeInsets.all(10),
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          text: "Confirm",
                          textSize: 14,
                          isSecondary: true,
                          padding: EdgeInsets.all(10),
                          onTap: () {
                            Get.find<TalentController>()
                                .cancelCampaign(campaign.id)
                                .then((message) {
                                  if (message != "success") {
                                    showSnackBar(message);
                                  }
                                });
                            Get.until(
                              (route) =>
                                  Get.currentRoute == AppRoutes.talentApp ||
                                  Get.currentRoute == AppRoutes.subAdminApp ||
                                  Get.currentRoute == AppRoutes.managerApp,
                            );

                            Get.find<TalentController>()
                                .getCampaigns(status: "PENDING")
                                .then((val) {
                                  if (val != "success") {
                                    showSnackBar(val);
                                  }
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  shortInfo() {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(campaign.description, style: TextStyle(fontSize: 14)),
        RichText(
          text: TextSpan(
            text: "Metrics Needed: ",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: "Open-Sans",
              color: AppColors.green[25],
            ),
            children: [
              if (campaign.expectedMetrics != null)
                for (var i in campaign.expectedMetrics!.entries)
                  TextSpan(
                    text: "${i.value} ",
                    children: [
                      TextSpan(
                        text:
                            "${i.key.substring(0, 1).toUpperCase() + i.key.substring(1)}${campaign.expectedMetrics!.entries.last.key == i.key ? "" : ", "}",
                      ),
                    ],
                  ),
            ],
          ),
        ),
        if (campaign.status != "PENDING")
          Row(
            children: [
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Color(0xffFFDC00),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Status: ${campaign.status}",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ],
          ),
        Row(
          children: [
            CustomSvg(asset: AppIcons.price, color: AppColors.red, size: 18),
            const SizedBox(width: 8),
            Text(
              "\$${campaign.budget} ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              "(${campaign.payoutDeadline})",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  String formatDateRange(DateTime startDate, DateTime endDate) {
    String formatDate(DateTime date) {
      return '${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][date.month - 1]} ${date.day.toString().padLeft(2, '0')}';
    }

    String startFormatted = formatDate(startDate);
    String endFormatted = formatDate(endDate);

    if (startDate.year == endDate.year) {
      return '$startFormatted - $endFormatted, ${startDate.year}';
    } else {
      return '$startFormatted - $endFormatted, ${startDate.year} - ${endDate.year}';
    }
  }
}

showCampaignAssignModal({
  required BuildContext context,
  required UserModel? influencer,
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
                          child: Image.network(
                            ApiService().baseUrl + influencer!.avatar!,
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
