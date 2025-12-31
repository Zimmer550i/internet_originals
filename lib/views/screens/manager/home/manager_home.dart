import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/manager_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/base/task_card.dart';
import 'package:internet_originals/views/screens/manager/home/manager_all_pending_tasks.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({super.key});

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  final manager = Get.find<ManagerController>();
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    manager.getTasks().then((val) {
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
                const SizedBox(height: 24),
                Obx(
                  () =>
                      manager.taskLoading.value
                          ? CustomLoading()
                          : Row(
                            spacing: 16,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.dark[600],
                                  border: Border.all(
                                    color: AppColors.dark[400]!,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Active Campaigns",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: AppColors.green[100],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      manager.activeCampaigns.value.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 28,
                                        color: AppColors.green[50],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.dark[600],
                                  border: Border.all(
                                    color: AppColors.dark[400]!,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pending Metrics",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: AppColors.green[100],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      manager.pendingMetrics.value.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 28,
                                        color: AppColors.green[50],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () =>
                      manager.taskLoading.value
                          ? Container()
                          : Row(
                            spacing: 16,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.dark[600],
                                  border: Border.all(
                                    color: AppColors.dark[400]!,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Connected Talents",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: AppColors.green[100],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      manager.connectedTalents.value.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 28,
                                        color: AppColors.green[50],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.to(() => ManagerAllPendingTasks());
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
                      manager.taskLoading.value
                          ? CustomLoading()
                          : manager.tasks.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No tasks pending",
                              style: TextStyle(color: AppColors.green.shade100),
                            ),
                          )
                          : ListView.builder(
                            itemCount: min(2, manager.tasks.length),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (val, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: TaskCard(task: manager.tasks[index]),
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
