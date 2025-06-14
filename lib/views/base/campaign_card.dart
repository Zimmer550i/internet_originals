import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_campaign_details.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_feedback.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_performance_metrics.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_sign_contract.dart';

class CampaignCard extends StatelessWidget {
  final bool isDetailed;
  final Widget? action;
  final String? status;
  final Function()? onTap;
  const CampaignCard({
    super.key,
    this.isDetailed = false,
    this.action,
    this.status,
    this.onTap,
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
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(child: action!),
            ),
          if (action == null && isDetailed == false)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: CustomButton(
                  text: "View Details",
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  textSize: 14,
                  onTap:
                      onTap ??
                      () {
                        Get.to(() => TalentCampaignDetails(status: status));
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
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.network(
            "https://picsum.photos/200/200",
            height: 44,
            width: 44,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Samsung Galaxy Unpacked",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: "Open-Sans",
                color: AppColors.green[25],
              ),
            ),
            Text(
              "Samsung",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Open-Sans",
                color: AppColors.green[25],
              ),
            ),
          ],
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
              TextSpan(text: 'campaign.campaignType\n'),

              TextSpan(text: 'Content Format: '),
              TextSpan(text: 'campaign.contentType\n'),

              TextSpan(text: 'Metrics Needed: '),
              TextSpan(text: 'campaign.getMatricsText()\n'),

              for (var i
                  in {
                    "reach": "100K",
                    "engagementRate": "5%",
                    "conversion": "2K",
                    "view": "10K",
                  }.entries)
                TextSpan(
                  text: "${i.key}: ",
                  children: [TextSpan(text: "${i.value}\n")],
                ),
            ],
          ),
        ),
        Row(
          children: [
            CustomSvg(asset: AppIcons.price, color: AppColors.red, size: 18),
            const SizedBox(width: 8),
            Text(
              "\$500 ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              "(campaign.payoutDeadline)",
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
              formatDateRange(
                DateTime.now().add(Duration(days: 1)),
                DateTime.now().add(Duration(days: 3)),
              ),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 20),
          child: GestureDetector(
            onTap: () {
              reportIssue(context);
            },
            behavior: HitTestBehavior.translucent,
            child: Text(
              "Report Issue",
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
        ),

        if (status == "pending")
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
                    Get.to(() => TalentSignContract());
                  },
                ),
              ),
            ],
          ),

        if (status == "active")
          Align(
            child: CustomButton(
              text: "Upload Matrix",
              width: null,
              textSize: 14,
              onTap: () {
                Get.to(() => TalentPerformanceMetrics());
              },
            ),
          ),

        if (status == "completed")
          Align(
            child: CustomButton(
              text: "Give Feedback",
              width: null,
              textSize: 14,
              onTap: () {
                Get.to(() => TalentFeedback());
              },
            ),
          ),
      ],
    );
  }

  Future<dynamic> reportIssue(BuildContext context) {
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
                  CustomTextField(hintText: "Describe the issue"),
                  const SizedBox(height: 40),
                  CustomButton(text: "Send Report", width: null, textSize: 14),
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
                            Get.until(
                              (route) =>
                                  Get.currentRoute == AppRoutes.talentApp ||
                                  Get.currentRoute == AppRoutes.subAdminApp,
                            );
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
        Text("Campaign Description", style: TextStyle(fontSize: 14)),
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
              TextSpan(text: " 10k+ Views, 1,500+ Likes & 300+ Shares"),
            ],
          ),
        ),
        if (status != "pending" && status != null)
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
                "Status: $status",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ],
          ),
        Row(
          children: [
            CustomSvg(asset: AppIcons.price, color: AppColors.red, size: 18),
            const SizedBox(width: 8),
            Text(
              "\$500 ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              "(within 6 months of completion)",
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
