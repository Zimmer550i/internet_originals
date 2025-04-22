import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/payments/payment_item.dart';

class AdminPaymentsHome extends StatefulWidget {
  const AdminPaymentsHome({super.key});

  @override
  State<AdminPaymentsHome> createState() => _AdminPaymentsHomeState();
}

class _AdminPaymentsHomeState extends State<AdminPaymentsHome> {
  int selectedOption = 0;

  List<Map<String, dynamic>> pending = [
    {
      'name': 'Sophia Carter',
      'avatar': 'https://picsum.photos/200/300',
      'rating': 4.5,
      'campaign': 'Samsung Galaxy Unpacked',
      'amount': 111912,
    },
    {
      'name': 'Liam Thompson',
      'avatar': 'https://picsum.photos/200/300',
      'rating': 3.2,
      'campaign': 'McDonalds, New York, USA',
      'amount': 912,
    },
    {
      'name': 'Ella Rodriguez',
      'avatar': 'https://picsum.photos/200/300',
      'rating': 5.0,
      'campaign': 'Starbucks, New York, USA',
      'amount': 58111912,
    },
  ];

  List<Map<String, dynamic>> processed = [
    {
      'name': 'Sophia Carter',
      'avatar': 'https://picsum.photos/200/300',
      'rating': 4.5,
      'campaign': 'Samsung Galaxy Unpacked',
      'amount': 111912,
    },
    {
      'name': 'Liam Thompson',
      'avatar': 'https://picsum.photos/200/300',
      'rating': 3.2,
      'campaign': 'McDonalds, New York, USA',
      'amount': 912,
    },
    {
      'name': 'Ella Rodriguez',
      'avatar': 'https://picsum.photos/200/300',
      'rating': 5.0,
      'campaign': 'Starbucks, New York, USA',
      'amount': 58111912,
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
      backgroundColor: AppColors.green[700],
      body: SingleChildScrollView(
        child: Padding(
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
                },
              ),
              SizedBox(height: 12),
              if (selectedOption == 0)
                ...pending.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: AdminPaymentItem(
                      name: item['name'],
                      avatar: item['avatar'],
                      rating: item['rating'],
                      campaign: item['campaign'],
                      amount: item['amount'],
                      status: AdminPaymentStatus.pending,
                    ),
                  );
                }),
              if (selectedOption == 1)
                ...processed.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: AdminPaymentItem(
                      name: item['name'],
                      avatar: item['avatar'],
                      rating: item['rating'],
                      campaign: item['campaign'],
                      amount: item['amount'],
                      status: AdminPaymentStatus.processed,
                    ),
                  );
                }),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
