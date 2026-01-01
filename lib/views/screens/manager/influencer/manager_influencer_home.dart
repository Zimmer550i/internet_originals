import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/manager_controller.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_modal.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/base/influencer_card.dart';

class ManagerInfluencerHome extends StatefulWidget {
  const ManagerInfluencerHome({super.key});

  @override
  State<ManagerInfluencerHome> createState() => _ManagerInfluencerHomeState();
}

class _ManagerInfluencerHomeState extends State<ManagerInfluencerHome> {
  int selectedOption = 0;
  final manager = Get.find<ManagerController>();
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    manager.getInfluencers(selectedOption).then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        manager
            .getInfluencers(
              selectedOption,
              searchText: searchController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(isHome: false),
      backgroundColor: AppColors.green[700],
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              CustomTabBar(
                options: ['All', 'Connected'],
                onChange: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                  manager.getInfluencers(selectedOption).then((message) {
                    if (message != "success") {
                      showSnackBar(message);
                    }
                  });
                },
              ),
              SizedBox(height: 12),
              if (selectedOption == 0)
                CustomSearchBar(
                  hintText: 'Search by name or social handle',
                  controller: searchController,
                  onChanged: (val) {
                    manager
                        .getInfluencers(selectedOption, searchText: val)
                        .then((message) {
                          if (message != "success") {
                            showSnackBar(message);
                          }
                        });
                  },
                ),

              Obx(
                () =>
                    manager.influencerLoading.value
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoading(),
                        )
                        : Column(
                          children: [
                            for (var i in manager.influencers)
                              Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: InfluencerCard(
                                  influencer: i,
                                  button: CustomButton(
                                    onTap: () => handleRequest(i),
                                    text:
                                        selectedOption == 1
                                            ? "Remove Connection"
                                            : manager.recentRequests.contains(
                                              i.id,
                                            )
                                            ? "Request Sent"
                                            : "Send Connection Request",
                                    isDisabled: manager.recentRequests.contains(
                                      i.id,
                                    ),
                                    width: null,
                                    height: 40,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    textSize: 14,
                                  ),
                                ),
                              ),
                            if (manager.influencers.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No influencers available",
                                  style: TextStyle(
                                    color: AppColors.green.shade100,
                                  ),
                                ),
                              ),
                          ],
                        ),
              ),
              // if (selectedOption == 1)
              //   ...approved.map((item) {
              //     return Padding(
              //       padding: const EdgeInsets.only(top: 12),
              //       child: ApprovedInfluencerItem(
              //         name: item['name'],
              //         avatar: item['avatar'],
              //         followers: item['followers'],
              //         rating: item['rating'],
              //         username: item['username'],
              //       ),
              //     );
              //   }),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }

  void handleRequest(UserModel influencer) async {
    if (selectedOption == 0) {
      showCustomModal(
        context: context,
        title: "Send connection request to",
        highlight: "${influencer.name}?",
        leftButtonText: "Cancel",
        rightButtonText: "Confirm",
        onLeftButtonClick: () => Get.back(),
        onRightButtonClick: () {
          Get.back();
          manager.sendConnectionRequest(influencer.id).then((message) {
            if (message == "success") {
              showSnackBar(
                "Connection request sent to ${influencer.name}",
                isError: false,
              );
            } else {
              showSnackBar(message);
            }
          });
        },
      );
    } else {
      showCustomModal(
        context: context,
        title: "Remove connection with",
        highlight: "${influencer.name}?",
        leftButtonText: "Cancel",
        rightButtonText: "Confirm",
        onLeftButtonClick: () => Get.back(),
        onRightButtonClick: () {
          Get.back();
          manager.removeConnection(influencer.id).then((message) {
            if (message == "success") {
              showSnackBar(
                "Removed connection with ${influencer.name}",
                isError: false,
              );
            } else {
              showSnackBar(message);
            }
          });
        },
      );
    }
  }
}
