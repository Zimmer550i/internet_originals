import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/screens/sub_admin/payments/payment_details.dart';

enum AdminPaymentStatus { pending, processed }

class AdminPaymentItem extends StatefulWidget {
  final String name;
  final String avatar;
  final double rating;
  final String campaign;
  final int amount;
  final AdminPaymentStatus status;

  const AdminPaymentItem({
    super.key,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.campaign,
    required this.amount,
    required this.status,
  });

  @override
  State<AdminPaymentItem> createState() => _AdminPaymentItemState();
}

class _AdminPaymentItemState extends State<AdminPaymentItem> {
  late int starCount = widget.rating.toInt();

  Widget _stars() {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              starCount = index + 1;
            });
          },
          child: Icon(
            index < starCount ? Icons.star : Icons.star_border,
            color: index < starCount ? AppColors.red[400] : Colors.grey,
            size: 18,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.green[600],
        border: Border.all(color: AppColors.green[400]!, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  widget.avatar,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _stars(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Campaign: @${widget.campaign}',
            style: TextStyle(
              color: AppColors.green[50],
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Amount: \$${Formatter.formatNumberMagnitude(widget.amount.toDouble())}',
            style: TextStyle(
              color: AppColors.green[50],
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'View Details',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AdminPaymentDetails(
                          avatar: widget.avatar,
                          amount: widget.amount,
                          campaign: widget.campaign,
                          name: widget.name,
                          rating: widget.rating,
                          status: widget.status,
                        );
                      },
                    ),
                  );
                },
                width: null,
                height: 36,
                textSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
