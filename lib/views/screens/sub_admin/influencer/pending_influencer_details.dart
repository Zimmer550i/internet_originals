import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class PendingInfluencerDetails extends StatefulWidget {
  final String name;
  final String username;
  final String avatar;
  final int followers;
  final double rating;
  final String location;
  final int createdAt;

  const PendingInfluencerDetails({
    super.key,
    required this.name,
    required this.avatar,
    required this.username,
    required this.followers,
    required this.rating,
    required this.location,
    required this.createdAt,
  });

  @override
  State<PendingInfluencerDetails> createState() =>
      _PendingInfluencerDetailsState();
}

class _PendingInfluencerDetailsState extends State<PendingInfluencerDetails> {
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
      appBar: CustomAppBar(title: 'Details'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Container(
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
                      'Social Handle: @${widget.username}',
                      style: TextStyle(
                        color: AppColors.green[50],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Followers: ${Formatter.formatNumberMagnitude(widget.followers.toDouble())}',
                      style: TextStyle(
                        color: AppColors.green[50],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Overall Rating: ${widget.rating}',
                      style: TextStyle(
                        color: AppColors.green[50],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Location: ${widget.location}',
                      style: TextStyle(
                        color: AppColors.green[50],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Requested on: ${Formatter.prettyDate(widget.createdAt)}',
                      style: TextStyle(
                        color: AppColors.green[50],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        CustomButton(
                          text: 'Decline',
                          onTap: () {},
                          width:
                              (MediaQuery.of(context).size.width -
                                      48 -
                                      24 -
                                      12) /
                                  2 -
                              2,
                          height: 36,
                          textSize: 14,
                          isSecondary: true,
                        ),
                        const SizedBox(width: 12),
                        CustomButton(
                          text: 'Approved',
                          onTap: () {},
                          width:
                              (MediaQuery.of(context).size.width -
                                  48 -
                                  24 -
                                  12) /
                              2,
                          height: 36,
                          textSize: 14,
                        ),
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
