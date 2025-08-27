import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/screens/talent/payments/earnings.dart';
import 'package:internet_originals/views/screens/talent/payments/pending_payment_item.dart';

class PaymentsHome extends StatefulWidget {
  const PaymentsHome({super.key});

  @override
  State<PaymentsHome> createState() => _PaymentsHomeState();
}

class _PaymentsHomeState extends State<PaymentsHome> {
  final talent = Get.find<TalentController>();
  final List<String> _pageOptions = ["Pending", "Paid", "Earnings"];
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    if (selectedOption == 0) {
      talent.getPendingPayment().then((message) {
        if (message != "success") {
          showSnackBar(message);
        }
      });
    } else if (selectedOption == 1) {
      talent.getPaidPayment().then((message) {
        if (message != "success") {
          showSnackBar(message);
        }
      });
    } else {
      // talent.().then((message) {
      //   if (message != "success") {
      //     showSnackBar(message);
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(isHome: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CustomTabBar(
                options: _pageOptions,
                onChange: (index) {
                  setState(() {
                    selectedOption = index;
                  });
                  getData();
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (talent.paymentLoading.value) {
                  return CustomLoading();
                }

                if (selectedOption != 2) {
                  if (talent.payments.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "No payment info available",
                        style: TextStyle(color: AppColors.green.shade100),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: talent.payments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: PendingPaymentItem(
                          campaign: talent.payments.elementAt(index),
                        ),
                      );
                    },
                  );
                }

                return Earnings();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
