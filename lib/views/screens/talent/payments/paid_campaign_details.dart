import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';

class PaidCampaignDetails extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String company;
  final int amount;
  final int paidOn;

  const PaidCampaignDetails({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.amount,
    required this.paidOn,
  });

  @override
  State<PaidCampaignDetails> createState() => _PaidCampaignDetailsState();
}

class _PaidCampaignDetailsState extends State<PaidCampaignDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Paid Campaign Details'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Container(
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
                        'Due Date: ${Formatter.prettyDate(widget.paidOn)}',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Performance:',
                    style: TextStyle(
                      color: AppColors.dark[50],
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSvg(
                        asset: 'assets/icons/payments/eye.svg',
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Views: 15,200',
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
                        asset: 'assets/icons/payments/heart.svg',
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Likes: 2,100',
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
                        asset: 'assets/icons/payments/share.svg',
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Shares: 500',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
