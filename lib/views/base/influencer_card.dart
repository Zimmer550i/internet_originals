import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class InfluencerCard extends StatelessWidget {
  final String? status;
  final Widget? action;
  const InfluencerCard({super.key, this.status, this.action});

  @override
  Widget build(BuildContext context) {
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
                child: Image.network(
                  "https://picsum.photos/200/200",
                  height: 44,
                  width: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sophia Carter",
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
                      for (int i = 0; i < 4; i++)
                        CustomSvg(asset: AppIcons.starDark, size: 16),
                      for (int i = 0; i < 1; i++)
                        CustomSvg(asset: AppIcons.star, size: 16),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Social Handle: @SophiaVibes",
            style: TextStyle(fontSize: 14, height: 20 / 14),
          ),
          const SizedBox(height: 2),
          Text(
            "Followers: 85K",
            style: TextStyle(fontSize: 14, height: 20 / 14),
          ),
          const SizedBox(height: 2),
          handleStatus(),
          handleAction(),
        ],
      ),
    );
  }

  Widget handleStatus() {
    if (status != null) {
      return Row(
        children: [
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: Color(0xff00FF00),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4,),
          Text("Status: Metrix Submitted", style: TextStyle(
            fontSize: 12,
            height: 18/12,
          ),)
        ],
      );
    }
    return Container();
  }

  Widget handleAction() {
    if (action == null) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 16),
        child: Center(child: action),
      );
    }
  }
}
