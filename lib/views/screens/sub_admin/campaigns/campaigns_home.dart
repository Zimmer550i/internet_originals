import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
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
  int tabIndex = 0;
  TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    sub.getCampaigns();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        sub
            .getCampaigns(
              searchText: searchController.text,
              showCompleted: tabIndex == 1,
              loadMore: true,
            )
            .then((message) {
              if (message != "success") {
                showSnackBar(message);
              }
            });
      }
    });
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
                      sub.campaigns.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No campaigns available",
                              style: TextStyle(color: AppColors.green.shade100),
                            ),
                          )
                          : SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                if (sub.campaignLoading.value)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: CustomLoading()),
                                  ),
                                for (int i = 0; i < sub.campaigns.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16.0,
                                    ),
                                    child: CampaignCard(
                                      campaign: sub.campaigns.elementAt(i),
                                    ),
                                  ),
                                if (sub.campaignLoading.value)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: CustomLoading()),
                                  ),
                              ],
                            ),
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
