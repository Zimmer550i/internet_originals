import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_loading.dart';

class CampaignIssues extends StatefulWidget {
  final String id;
  const CampaignIssues({super.key, required this.id});

  @override
  State<CampaignIssues> createState() => _CampaignIssuesState();
}

class _CampaignIssuesState extends State<CampaignIssues> {
  final sub = Get.find<SubAdminController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    sub.getIssues(widget.id).then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        sub.getIssues(widget.id, loadMore: true).then((message) {
          if (message != "success") {
            showSnackBar(message);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Issues"),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Obx(
              () => Column(
                spacing: 16,
                children: [
                  for (var i in sub.issues)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.green[600],
                        border: Border.all(color: AppColors.green[400]!),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child:
                                    i.influencerAvatar != null
                                        ? Image.network(
                                          (ApiService().baseUrl +
                                              i.influencerAvatar!),
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
                                    i.influencerName,
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
                                      for (
                                        int j = 0;
                                        j < i.influencerRating.round();
                                        j++
                                      )
                                        CustomSvg(
                                          asset: AppIcons.starDark,
                                          size: 16,
                                        ),
                                      for (
                                        int j = 0;
                                        j < 5 - i.influencerRating.round();
                                        j++
                                      )
                                        CustomSvg(
                                          asset: AppIcons.star,
                                          size: 16,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            i.content * 50,
                            style: TextStyle(color: AppColors.green[50]),
                          ),
                          const SizedBox(height: 32),
                          CustomButton(
                            text: i.unread ? "Mark as Read" : "Read",
                            leading:
                                i.unread
                                    ? null
                                    : "assets/icons/payments/double_check.svg",
                            isDisabled: !i.unread,
                            width: null,
                            onTap: () {
                              sub
                                  .issues
                                  .firstWhere((val) => val.id == i.id)
                                  .unread = false;

                              sub.readIssue(i.id).then((message) {
                                if (message != "success") {
                                  showSnackBar(message);
                                  sub
                                      .issues
                                      .firstWhere((val) => val.id == i.id)
                                      .unread = true;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  if (sub.campaignLoading.value)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CustomLoading()),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
