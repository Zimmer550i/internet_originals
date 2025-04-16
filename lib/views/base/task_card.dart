import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/screens/talent/home/talent_pending_task.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String brandName;
  final String imageLink;
  final DateTime deadline;
  final String details;
  final Map<String, String> requiredMatrics;
  const TaskCard({
    super.key,
    required this.title,
    required this.brandName,
    required this.imageLink,
    required this.deadline,
    required this.details,
    required this.requiredMatrics,
  });

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
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.network(
                  imageLink,
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
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Text(brandName, style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          Text(
            details,
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
                      "${deadline.difference(DateTime.now()).inDays.toString()} Days Left",
                      style: TextStyle(color: AppColors.red[900], fontSize: 14),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => TalentPendingTask());
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
