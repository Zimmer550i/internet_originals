import 'package:flutter/material.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_radio_options.dart';
import 'package:get/get.dart';

class PaymentSelection extends StatefulWidget {
  const PaymentSelection({super.key});

  @override
  State<PaymentSelection> createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  final List<String> _paymentOptions = [
    'Submit Invoice',
    'Receive Cash Payment',
  ];

  String _selectedPaymentOption = 'Submit Invoice';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Selection'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Text(
              'How would you like to receive your payment?',
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 36),
            CustomRadioOptions(
              options: _paymentOptions,
              selectedOption: _selectedPaymentOption,
              onChange: (selectedValue) {
                setState(() {
                  _selectedPaymentOption = selectedValue;
                });
              },
            ),
            SizedBox(height: 36),
            CustomButton(
              text: 'Continue',
              width: MediaQuery.of(context).size.width * 0.5,
              onTap: () {
                if (_selectedPaymentOption == 'Submit Invoice') {
                  Get.toNamed(AppRoutes.submitInvoice);
                } else {
                  Get.toNamed(AppRoutes.paymentTerms);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
