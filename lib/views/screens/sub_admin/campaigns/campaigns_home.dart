import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/views/base/custom_button.dart';
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
  bool showingResult = false;
  TextEditingController searchController = TextEditingController();

  void filterInfo(String val) {
    if (val.isNotEmpty) {
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
                    onChange: (int index) {},
                  ),
                ),

              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      // child: CampaignCard(
                      //   onTap: () {
                      //     Get.to(
                      //       () => TalentCampaignDetails(
                      //         status: "",
                      //         actions: Row(
                      //           children: [
                      //             Expanded(
                      //               child: CustomButton(
                      //                 text: "Add Influencers",
                      //                 width: null,
                      //                 padding: EdgeInsets.symmetric(
                      //                   vertical: 10,
                      //                 ),
                      //                 isSecondary: true,
                      //                 onTap:
                      //                     () => Get.to(() => AddInfluencers()),
                      //               ),
                      //             ),
                      //             const SizedBox(width: 20),
                      //             Expanded(
                      //               child: CustomButton(
                      //                 text: "See Influencers",
                      //                 width: null,
                      //                 padding: EdgeInsets.symmetric(
                      //                   vertical: 10,
                      //                 ),
                      //                 isSecondary: true,
                      //                 onTap:
                      //                     () => Get.to(
                      //                       () => AssignedInfluencers(),
                      //                     ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
