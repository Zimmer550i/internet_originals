import 'package:flutter/cupertino.dart';
import 'package:internet_originals/utils/app_colors.dart';

class Earnings extends StatelessWidget {
  const Earnings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Text(
          "Total Earnings",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColors.green[100],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 56,
                color: AppColors.red[500],
              ),
            ),
            Text(
              "5,200",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 56,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 56) / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.dark[600],
                border: Border.all(color: AppColors.dark[400]!, width: 1),
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    "Pending Payments",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColors.green[200],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\$ 1,200",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      color: AppColors.green[100],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: (MediaQuery.of(context).size.width - 56) / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.dark[600],
                border: Border.all(color: AppColors.dark[400]!, width: 1),
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    "Pending Payments",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColors.green[200],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\$ 4,000",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      color: AppColors.green[100],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
