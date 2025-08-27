import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';

class TalentCampaign extends StatefulWidget {
  const TalentCampaign({super.key});

  @override
  State<TalentCampaign> createState() => _TalentCampaignState();
}

class _TalentCampaignState extends State<TalentCampaign> {
  int selectedTab = 0;
  final talent = Get.find<TalentController>();
  List<String> status = ["pending", "active", "completed"];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    talent.getCampaigns(status: status[selectedTab].toUpperCase()).then((val) {
      if (val != "success") {
        showSnackBar(val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: CustomTabBar(
                key: talentCampaignTabBarKey,
                options: ["Request", "Active", "Completed"],
                onChange: (val) {
                  setState(() {
                    selectedTab = val;
                  });
                  getData();
                },
              ),
            ),
            Expanded(
              child: Obx(
                () =>
                    talent.campaignLoading.value
                        ? Center(child: CustomLoading())
                          : talent.campaigns.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No campaigns available",
                              style: TextStyle(color: AppColors.green.shade100),
                            ),
                          )
                        : ListView.builder(
                          itemCount: talent.campaigns.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CampaignCard(
                                campaign: talent.campaigns.elementAt(index),
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
