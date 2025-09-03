import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/create_new_campaign.dart';

class CampaignsHome extends StatefulWidget {
  const CampaignsHome({super.key});

  @override
  State<CampaignsHome> createState() => _CampaignsHomeState();
}

class _CampaignsHomeState extends State<CampaignsHome> {
  final sub = Get.find<SubAdminController>();
  bool showingResult = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sub.getCampaigns();
  }

  void filterInfo(String val) {
    if (val.isNotEmpty) {
      sub.getCampaigns(searchText: val);
      setState(() {
        showingResult = true;
      });
    } else {
      setState(() {
        showingResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomSearchBar(
                hintText: "Search campaigns by name....",
                controller: searchController,
                onChanged: filterInfo,
              ),
              const SizedBox(height: 20),
              if (!showingResult)
                CustomButton(
                  text: "Create New Campaign",
                  leading: AppIcons.addCircle,
                  isSecondary: true,
                  onTap: () {
                    Get.to(() => CreateNewCampaign());
                  },
                ),
              if (!showingResult)
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 20),
                  child: CustomTabBar(
                    options: ["Active", "Completed"],
                    onChange: (int index) {
                      if (index == 1) {
                        sub.getCampaigns(showCompleted: true);
                      } else {
                        sub.getCampaigns();
                      }
                    },
                  ),
                ),

              Expanded(
                child: Obx(
                  () =>
                      sub.campaignLoading.value
                          ? CustomLoading()
                          : sub.campaigns.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No campaigns available",
                              style: TextStyle(color: AppColors.green.shade100),
                            ),
                          )
                          : ListView.builder(
                            itemCount: sub.campaigns.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: CampaignCard(
                                  campaign: sub.campaigns.elementAt(index),
                                ),
                              );
                            },
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
