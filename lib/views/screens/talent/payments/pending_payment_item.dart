import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_button.dart';

enum PendingPaymentItemStatus { pending, sent }

class PendingPaymentItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String company;
  final int amount;
  final int dueDate;
  final PendingPaymentItemStatus status;

  const PendingPaymentItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.amount,
    required this.dueDate,
    required this.status,
  });

  @override
  State<PendingPaymentItem> createState() => _PendingPaymentItemState();
}

class _PendingPaymentItemState extends State<PendingPaymentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.dark[600],
        border: Border.all(color: AppColors.dark[400]!, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  widget.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: AppColors.dark[50],
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.company,
                      style: TextStyle(
                        color: AppColors.dark[50],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Promote event on instagram',
            style: TextStyle(
              color: AppColors.dark[50],
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSvg(
                asset: 'assets/icons/payments/tag.svg',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 8),
              Text(
                '\$${widget.amount}',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSvg(
                asset: 'assets/icons/payments/calender.svg',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 8),
              Text(
                'Due Date: ${Formatter.prettyDate(widget.dueDate)}',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSvg(
                asset: 'assets/icons/payments/warning_circle.svg',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Expected Payout: Within ',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '30',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' days',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                textSize: 15,
                text:
                    widget.status == PendingPaymentItemStatus.pending
                        ? 'Send Payment Request'
                        : 'Payment Request Sent',
                onTap: () {
                  if (widget.status == PendingPaymentItemStatus.pending) {
                    Get.toNamed(AppRoutes.paymentSelection);
                  }
                },
                width: null,
                leading:
                    widget.status == PendingPaymentItemStatus.sent
                        ? 'assets/icons/payments/double_check.svg'
                        : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
