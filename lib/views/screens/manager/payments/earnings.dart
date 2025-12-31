import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  final talent = Get.find<TalentController>();

  @override
  void initState() {
    super.initState();
    talent.getEarnings().then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Obx(
            () => talent.paymentLoading.value ? CustomLoading() : Container(),
          ),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\$ ",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 56,
                color: AppColors.red[500],
              ),
            ),
            Expanded(
              child: Obx(
                () => Text(
                  talent.totalEarning.value != null
                      ? addCommas(talent.totalEarning.value!)
                      : "_ _ _",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 56,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Paid Earnings",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColors.green[200],
                    ),
                  ),
                  SizedBox(height: 8),
                  Obx(
                    () => Text(
                      "\$ ${talent.paidEarning.value != null ? addCommas(talent.paidEarning.value!) : "_ _ _"}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 28,
                        color: AppColors.green[100],
                      ),
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
                  Obx(
                    () => Text(
                      "\$ ${talent.pendingPayments.value != null ? addCommas(talent.pendingPayments.value!) : "_ _ _"}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 28,
                        color: AppColors.green[100],
                      ),
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

  String addCommas(num number) {
    String numStr = number.toStringAsFixed(0);
    String reversed = numStr.split('').reversed.join('');

    List<String> parts = [];
    for (int i = 0; i < reversed.length; i += 3) {
      int end = (i + 3 < reversed.length) ? i + 3 : reversed.length;
      parts.add(reversed.substring(i, end));
    }

    return parts.join(',').split('').reversed.join('');
  }
}
