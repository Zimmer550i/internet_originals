import 'package:flutter/material.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const NotificationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(data['createdAt']);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.green[600],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.green[400]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['type'] == "SOFT" ? "Soft Notification" : "Hard Notification",
            style: TextStyle(
              fontSize: 12,
              height: 18 / 12,
              color: AppColors.red[300],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data['title'],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 20 / 14,
              color: AppColors.green[25],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data['body'],
            style: TextStyle(
              // color: AppColors.green[100],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.green.shade500,
              border: Border.all(color: AppColors.green.shade200),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                ClipRRect(
                  child:
                      data['recipientAvatar'] != null
                          ? Image.network(
                            ("${ApiService().baseUrl}${data['recipientAvatar']}"),
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          )
                          : SizedBox(height: 24, width: 24),
                ),
                Text(
                  data['recipientName'],
                  style: TextStyle(fontSize: 12, color: AppColors.green[25]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            spacing: 8,
            children: [
              CustomSvg(
                asset: AppIcons.calendar,
                size: 16,
                color: AppColors.red[300],
              ),
              Text(
                "${Formatter.monthName(dateTime.month, short: true)} ${dateTime.day}, ${dateTime.year} | ",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              CustomSvg(
                asset: AppIcons.clock,
                size: 16,
                color: AppColors.red[300],
              ),
              Text(
                Formatter.timeFormatter(dateTime: dateTime),
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
