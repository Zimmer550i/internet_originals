import 'package:flutter/material.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/influencer_card.dart';

class PendingInfluencerDetails extends StatelessWidget {
  final UserModel influencer;

  const PendingInfluencerDetails({super.key, required this.influencer});

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
              InfluencerCard(influencer: influencer, showDetails: true),
            ],
          ),
        ),
      ),
    );
  }
}
