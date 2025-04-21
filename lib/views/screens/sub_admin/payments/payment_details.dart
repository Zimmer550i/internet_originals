import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/screens/sub_admin/payments/payment_item.dart';

class AdminPaymentDetails extends StatefulWidget {
  final String name;
  final String avatar;
  final double rating;
  final String campaign;
  final int amount;
  final AdminPaymentStatus status;

  const AdminPaymentDetails({
    super.key,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.campaign,
    required this.amount,
    required this.status,
  });

  @override
  State<AdminPaymentDetails> createState() => _AdminPaymentDetailsState();
}

class _AdminPaymentDetailsState extends State<AdminPaymentDetails> {
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
    return Scaffold(
      appBar: CustomAppBar(title: 'About Us'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.dark[600],
                  border: Border.all(color: AppColors.dark[400]!, width: 1),
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
                                fontSize: 18,
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
                    const SizedBox(height: 36),
                    Text(
                      'Performance Metrics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DetailsItem(
                      primaryText: 'Views: 12,500',
                      secondaryText: '(Goal: 10,000)',
                    ),
                    DetailsItem(
                      primaryText: 'Likes: 1,800',
                      secondaryText: '(Goal: 1,500)',
                    ),
                    DetailsItem(
                      primaryText: 'Shares: 280',
                      secondaryText: '(Goal: 300)',
                    ),
                    DetailsItem(
                      primaryText: 'View Link',
                      primaryTextColor: AppColors.red[300],
                      tailingIcon: 'assets/icons/payments/arrow_tr.svg',
                    ),
                    DetailsItem(
                      primaryText: 'Download Insight Screenshot',
                      primaryTextColor: AppColors.red[300],
                      tailingIcon: 'assets/icons/payments/arrow_down.svg',
                    ),
                    DetailsItem(
                      primaryText: 'Download Invoice',
                      primaryTextColor: AppColors.red[300],
                      tailingIcon: 'assets/icons/payments/arrow_down.svg',
                    ),
                    const SizedBox(height: 36),
                    if (widget.status == AdminPaymentStatus.pending)
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Cancel',
                              isSecondary: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: CustomButton(text: 'Approve')),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsItem extends StatelessWidget {
  final String primaryText;
  final String? secondaryText;
  final String? tailingIcon;
  final Function()? onTap;
  final Color? primaryTextColor;

  const DetailsItem({
    super.key,
    required this.primaryText,
    this.secondaryText,
    this.primaryTextColor,
    this.tailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.dark[400]!, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              primaryText,
              style: TextStyle(
                color: primaryTextColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (tailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomSvg(asset: tailingIcon!, width: 28),
              ),
            if (secondaryText != null)
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  secondaryText!,
                  style: TextStyle(
                    color: AppColors.green[200],
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
