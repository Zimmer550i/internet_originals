import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_campaign_details.dart';

class TalentCampaign extends StatefulWidget {
  const TalentCampaign({super.key});

  @override
  State<TalentCampaign> createState() => _TalentCampaignState();
}

class _TalentCampaignState extends State<TalentCampaign> {
  int selectedTab = 0;
  List<String> status = ["pending", "active", "completed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: CustomTabBar(
                key: talentCampaignTabBarKey,
                options: ["Request", "Active", "Completed"],
                onChange: (val) {
                  setState(() {
                    selectedTab = val;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CampaignCard(
                      status: status[selectedTab],
                      onTap: () {
                        Get.to(() => TalentCampaignDetails(status: status[selectedTab],));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
