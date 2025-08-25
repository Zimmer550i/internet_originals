import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:internet_originals/models/task_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/screens/talent/home/talent_pending_task.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.network(
                    ApiService().baseUrl + task.campaign.banner,
                    height: 44,
                    width: 44,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.campaign.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      task.campaign.brand,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            task.campaign.contentType,
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
                  Get.to(() => TalentPendingTask(task: task,));
                },
                child: CustomSvg(asset: AppIcons.redArrowRight, size: 35),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
