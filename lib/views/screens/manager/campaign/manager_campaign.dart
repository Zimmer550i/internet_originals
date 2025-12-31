import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/manager_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';

class ManagerCampaign extends StatefulWidget {
  const ManagerCampaign({super.key});

  @override
  State<ManagerCampaign> createState() => _ManagerCampaignState();
}

class _ManagerCampaignState extends State<ManagerCampaign> {
  int selectedTab = 0;
  final manager = Get.find<ManagerController>();
  List<String> status = ["active", "completed"];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    manager.getCampaigns(status: status[selectedTab]).then((val) {
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
                // key: managerCampaignTabBarKey,
                options: ["Active", "Completed"],
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
                    manager.campaignLoading.value
                        ? Center(child: CustomLoading())
                          : manager.campaigns.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No campaigns available",
                              style: TextStyle(color: AppColors.green.shade100),
                            ),
                          )
                        : ListView.builder(
                          itemCount: manager.campaigns.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CampaignCard(
                                campaign: manager.campaigns.elementAt(index),
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
