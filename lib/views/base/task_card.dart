import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_networked_image.dart';
import 'package:internet_originals/views/base/profile_picture.dart';
import 'package:internet_originals/views/screens/manager/home/manager_pending_task.dart';
import 'package:internet_originals/views/screens/talent/home/talent_pending_task.dart';

class TaskCard extends StatelessWidget {
  final CampaignModel task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.green[600],
        border: Border.all(color: AppColors.green[400]!),
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CustomNetworkedImage(
                  url: ApiService().baseUrl + task.banner,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(task.brand, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          Text(
            task.contentType,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.left,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.red[200],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  children: [
                    CustomSvg(asset: AppIcons.clock),
                    const SizedBox(width: 4),
                    Text(
                      "${task.duration.difference(DateTime.now()).inDays.toString()} Days Left",
                      style: TextStyle(color: AppColors.red[900], fontSize: 14),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Get.find<UserController>().userInfo.value!.role ==
                      EUserRole.MANAGER) {
                    Get.to(() => ManagerPendingTask(task: task));
                  } else {
                    Get.to(() => TalentPendingTask(task: task));
                  }
                },
                child: CustomSvg(asset: AppIcons.redArrowRight, size: 35),
              ),
            ],
          ),
          if (task.influencer != null)
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
                        "${ApiService().baseUrl}${task.influencer?['avatar']}",
                    size: 24,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
