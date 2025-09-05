import 'package:flutter/material.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';

class CompromisedNotificationCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const CompromisedNotificationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(data['sentDate']);
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child:
                    data['influencerAvatar'] != null
                        ? Image.network(
                          (ApiService().baseUrl + data['influencerAvatar']!),
                          height: 44,
                          width: 44,
                          fit: BoxFit.cover,
                        )
                        : SizedBox(height: 44, width: 44),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['influencerName'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.green[25],
                      height: 28 / 18,
                    ),
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      for (int i = 0; i < data['influencerRating'].round(); i++)
                        CustomSvg(asset: AppIcons.starDark, size: 16),
                      for (
                        int i = 0;
                        i < 5 - data['influencerRating'].round();
                        i++
                      )
                        CustomSvg(asset: AppIcons.star, size: 16),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            data['notificationTitle'],
            style: TextStyle(fontSize: 14, color: AppColors.green.shade100),
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
