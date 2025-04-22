import 'package:flutter/material.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';

class TalentCampaignDetails extends StatelessWidget {
  final String? status;
  final Widget? actions;
  const TalentCampaignDetails({super.key, required this.status, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Campaign Details"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                CampaignCard(isDetailed: true, status: status, action: actions),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
