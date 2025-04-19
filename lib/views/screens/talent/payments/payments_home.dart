import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/screens/talent/payments/earnings.dart';
import 'package:internet_originals/views/screens/talent/payments/paid_payment_item.dart';
import 'package:internet_originals/views/screens/talent/payments/pending_payment_item.dart';

class PaymentsHome extends StatefulWidget {
  const PaymentsHome({super.key});

  @override
  State<PaymentsHome> createState() => _PaymentsHomeState();
}

class _PaymentsHomeState extends State<PaymentsHome> {
  final List<String> _pageOptions = ["Pending", "Paid", "Earnings"];
  int selectedOption = 0;

  final List<Map<String, dynamic>> _pendingPayments = [
    {
      "imageUrl": 'https://picsum.photos/200/200',
      "title": 'Nike Air Max Campaign',
      "company": 'Nike',
      "dueDate": DateTime.now().millisecondsSinceEpoch,
      "amount": 1000,
      "status": PendingPaymentItemStatus.pending,
    },
    {
      "imageUrl": 'https://picsum.photos/200/200',
      "title": 'Coca-Cola Refreshing Moments',
      "company": 'Coca-Cola',
      "dueDate": DateTime.now().millisecondsSinceEpoch,
      "amount": 500,
      "status": PendingPaymentItemStatus.sent,
    },
  ];

  final List<Map<String, dynamic>> _paidPayments = [
    {
      "imageUrl": 'https://picsum.photos/200/200',
      "title": 'Nike Air Max Campaign',
      "company": 'Nike',
      "paidOn": DateTime.now().millisecondsSinceEpoch,
      "amount": 1000,
    },
    {
      "imageUrl": 'https://picsum.photos/200/200',
      "title": 'Coca-Cola Refreshing Moments',
      "company": 'Coca-Cola',
      "paidOn": DateTime.now().millisecondsSinceEpoch,
      "amount": 1000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.green[700],
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSvg(asset: AppIcons.logo),

              CustomSvg(asset: AppIcons.bellWithAlert),
            ],
          ),
        ),
      ),
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
                },
              ),
            ),
            if (selectedOption == 0)
              ..._pendingPayments.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PendingPaymentItem(
                    imageUrl: item['imageUrl'],
                    title: item['title'],
                    company: item['company'],
                    dueDate: item['dueDate'],
                    amount: item['amount'],
                    status: item['status'],
                  ),
                );
              }).toList(),
            if (selectedOption == 1)
              ..._paidPayments.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PaidPaymentItem(
                    imageUrl: item['imageUrl'],
                    title: item['title'],
                    company: item['company'],
                    paidOn: item['paidOn'],
                    amount: item['amount'],
                  ),
                );
              }).toList(),
            if (selectedOption == 2) Earnings(),
          ],
        ),
      ),
    );
  }
}
