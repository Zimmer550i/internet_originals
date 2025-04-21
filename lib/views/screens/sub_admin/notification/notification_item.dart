import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';

enum NotificationType { soft, hard }

enum NotificationStatus { sent, scheduled }

class NotificationItem extends StatelessWidget {
  final NotificationType type;
  final NotificationStatus status;
  final int createdAt;
  final Function()? onTap;
  final String date;

  NotificationItem({
    super.key,
    required this.type,
    required this.status,
    required this.createdAt,
    this.onTap,
  }) : date = Formatter.prettyDate(createdAt, showTime: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.green[600],
          border: Border.all(color: AppColors.green[400]!, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${type == NotificationType.soft ? 'Soft' : 'Hard'} Reminder (${status == NotificationStatus.sent ? 'Sent' : 'Scheduled'})',
              style: TextStyle(
                color: AppColors.green[50],
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '10 Talents',
              style: TextStyle(
                color: AppColors.red[300],
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                CustomSvg(
                  asset: 'assets/icons/notification/calendar.svg',
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 8),
                Text(
                  date.split(', ')[1],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '|',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8),
                CustomSvg(
                  asset: 'assets/icons/notification/clock.svg',
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 8),
                Text(
                  date.split(', ')[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
