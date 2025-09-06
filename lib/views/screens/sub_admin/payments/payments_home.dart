import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/payments/payment_item.dart';

class AdminPaymentsHome extends StatefulWidget {
  const AdminPaymentsHome({super.key});

  @override
  State<AdminPaymentsHome> createState() => _AdminPaymentsHomeState();
}

class _AdminPaymentsHomeState extends State<AdminPaymentsHome> {
  final sub = Get.find<SubAdminController>();
  final scrollController = ScrollController();
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
    sub.getPayments("pending").then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        sub
            .getPayments(
              selectedOption == 0 ? "pending" : "paid",
              loadMore: true,
            )
            .then((message) {
              if (message != "success") {
                showSnackBar(message);
              }
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(isHome: false),
      backgroundColor: AppColors.green[700],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 12),
            CustomTabBar(
              options: ['Pending', 'Processed'],
              onChange: (value) {
                setState(() {
                  selectedOption = value;
                });

                sub.getPayments(selectedOption == 0 ? "pending" : "paid").then((
                  message,
                ) {
                  if (message != "success") {
                    showSnackBar(message);
                  }
                });
              },
            ),
            SizedBox(height: 12),
            Obx(
              () => SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    if (sub.payments.isEmpty && !sub.paymentLoading.value)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No payments available",
                          style: TextStyle(color: AppColors.green.shade100),
                        ),
                      ),
                    if (!sub.paymentLoading.value)
                      for (var i in sub.payments)
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: AdminPaymentItem(payment: i),
                        ),
                    if (sub.paymentLoading.value)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoading(),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 72),
          ],
        ),
      ),
    );
  }
}
