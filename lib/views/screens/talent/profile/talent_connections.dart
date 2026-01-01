import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_loading.dart';

class TalentConnections extends StatefulWidget {
  const TalentConnections({super.key});

  @override
  State<TalentConnections> createState() => _TalentConnectionsState();
}

class _TalentConnectionsState extends State<TalentConnections> {
  final talent = Get.find<TalentController>();

  @override
  void initState() {
    super.initState();
    talent.getConnections().then((message) {
      if (message != "success") showSnackBar(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Connections"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20, width: double.infinity,),
              if (talent.isLoading.value) CustomLoading(),
              if (!talent.isLoading.value && talent.connections.isEmpty)
                Text(
                  "No connection available",
                  style: TextStyle(color: AppColors.green.shade200),
                ),
              for (var i in talent.connections)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.green.shade600,
                    border: Border.all(
                      color: AppColors.green.shade400,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            "${ApiService().baseUrl}${i.avatar}",
                            width: 44,
                            height: 44,
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
                          ),
                          const SizedBox(width: 12),
                          Text(
                            i.name,
                            style: TextStyle(
                              color: AppColors.green[25],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          if (i.isConnected == true)
                            CustomSvg(asset: "assets/icons/connections.svg"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Active Campaign: ${i.activeCampaigns}",
                        style: TextStyle(color: AppColors.green[50]),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Completed Campaign: ${i.completedCampaigns}",
                        style: TextStyle(color: AppColors.green[50]),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: CustomButton(
                          onTap: () {
                            if (i.isConnected != true) {
                              talent.addConnection(i.managerId).then((message) {
                                if (message == "success") {
                                  showSnackBar("${i.name} added as Manager");
                                } else {
                                  showSnackBar(message);
                                }
                              });
                            } else {
                              talent.removeConnection(i.managerId).then((
                                message,
                              ) {
                                if (message == "success") {
                                  showSnackBar("${i.name} removed");
                                } else {
                                  showSnackBar(message);
                                }
                              });
                            }
                          },
                          text:
                              i.isConnected == true
                                  ? "Remove Connection"
                                  : "Add Manager",

                          width: null,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
