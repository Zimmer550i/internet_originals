import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/base/task_card.dart';
import 'package:internet_originals/views/screens/talent/home/talent_all_pending_tasks.dart';
import 'package:internet_originals/views/screens/talent/talent_app.dart';

class TalentHome extends StatefulWidget {
  const TalentHome({super.key});

  @override
  State<TalentHome> createState() => _TalentHomeState();
}

class _TalentHomeState extends State<TalentHome> {
  final talent = Get.find<TalentController>();
  int selectedTab = 0;
  List<String> status = ["pending", "active", "completed"];

  @override
  void initState() {
    super.initState();
    talent.getTasks().then((val) {
      if (val != "success") {
        showSnackBar(val);
      }
    });
    talent.getCampaigns(status: status[selectedTab].toUpperCase()).then((val) {
      if (val != "success") {
        showSnackBar(val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(isHome: true),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.to(() => TalentAllPendingTasks());
                  },
                  child: Row(
                    children: [
                      Text(
                        "Pending Tasks",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.green[100],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "See All ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.green[100],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 18,
                        color: AppColors.green[100],
                      ),
                    ],
                  ),
                ),
                Obx(
                  () =>
                      talent.taskLoading.value
                          ? CustomLoading()
                          : ListView.builder(
                            itemCount: min(2, talent.tasks.length),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (val, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: TaskCard(task: talent.tasks[index]),
                              );
                            },
                          ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    talentAppKey.currentState?.changePage(1);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Campaigns",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.green[100],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "See All ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.green[100],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 18,
                        color: AppColors.green[100],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CustomTabBar(
                  options: ["Requested", "Active", "Completed"],
                  onChange: (val) {
                    setState(() {
                      selectedTab = val;
                    });
                    talent
                        .getCampaigns(status: status[selectedTab].toUpperCase())
                        .then((val) {
                          if (val != "success") {
                            showSnackBar(val);
                          }
                        });
                  },
                ),

                Obx(
                  () =>
                      talent.campaignLoading.value
                          ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomLoading(),
                          )
                          : ListView.builder(
                            itemCount: min(2, talent.campaigns.length),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (val, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: CampaignCard(
                                  campaign: talent.campaigns.elementAt(index),
                                ),
                              );
                            },
                          ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
