import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/compromised_notification_card.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/base/influencer_card.dart';
import 'package:internet_originals/views/base/notification_card.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome({super.key});

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  final sub = Get.find<SubAdminController>();
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    sub.getInfluencers().then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        switch (index) {
          case 0:
            sub
                .getInfluencers(
                  searchText:
                      searchController.text.isNotEmpty
                          ? searchController.text
                          : null,
                  loadMore: true,
                )
                .then((message) {
                  if (message != "success") {
                    showSnackBar(message);
                  }
                });
            break;
          case 1:
            sub.getScheduledNotifications(loadMore: true).then((message) {
              if (message != "success") {
                showSnackBar(message);
              }
            });
            break;
          case 2:
            sub.getSentNotifications(loadMore: true).then((message) {
              if (message != "success") {
                showSnackBar(message);
              }
            });
            break;
          case 3:
            sub.getCompromiseNotifications(loadMore: true).then((message) {
              if (message != "success") {
                showSnackBar(message);
              }
            });
            break;
          default:
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // CustomButton(
            //   text: "Send Notification",
            //   leading: "assets/icons/notification/send.svg",
            //   onTap: () => Get.to(() => SendNotification()),
            // ),
            // const SizedBox(height: 16),
            // CustomButton(
            //   text: "See Templates",
            //   leading: 'assets/icons/notification/template.svg',
            //   isSecondary: true,
            //   onTap:
            //       () => Get.to(() => NotificationTemplates(isEditable: true)),
            // ),
            // const SizedBox(height: 24),
            CustomTabBar(
              options: ["Influencers", "Scheduled", "Sent", "Compromise"],
              width: 24,
              onChange: (val) {
                setState(() {
                  index = val;
                });
                switch (index) {
                  case 0:
                    sub.getInfluencers();
                    break;

                  case 1:
                    sub.getScheduledNotifications();
                    break;

                  case 2:
                    sub.getSentNotifications();
                    break;

                  case 3:
                    sub.getCompromiseNotifications();
                    break;

                  default:
                }
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Obx(
                () =>
                    index != 0
                        ? sub.notificationLoading.value && sub.apiData.isEmpty
                            ? Center(child: CustomLoading())
                            : ListView.builder(
                              controller: scrollController,
                              itemCount: sub.apiData.length,
                              itemBuilder: (context, i) {
                                if (i == sub.apiData.length - 1) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        child:
                                            index == 3
                                                ? CompromisedNotificationCard(
                                                  data: sub.apiData.elementAt(
                                                    i,
                                                  ),
                                                )
                                                : NotificationCard(
                                                  data: sub.apiData.elementAt(
                                                    i,
                                                  ),
                                                ),
                                      ),
                                      if (sub.notificationLoading.value)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(child: CustomLoading()),
                                        ),
                                    ],
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child:
                                      index == 3
                                          ? CompromisedNotificationCard(
                                            data: sub.apiData.elementAt(i),
                                          )
                                          : NotificationCard(
                                            data: sub.apiData.elementAt(i),
                                          ),
                                );
                              },
                            )
                        : Column(
                          children: [
                            CustomSearchBar(
                              hintText: 'Search by name or social handle',
                              controller: searchController,
                              onChanged: (val) {
                                sub.getInfluencers(searchText: val).then((
                                  message,
                                ) {
                                  if (message != "success") {
                                    showSnackBar(message);
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: sub.influencers.length,
                                itemBuilder: (context, i) {
                                  if (i == sub.influencers.length - 1) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: InfluencerCard(
                                            influencer: sub.influencers
                                                .elementAt(i),
                                            sendNotification: true,
                                          ),
                                        ),
                                        if (sub.influencerLoading.value)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: CustomLoading(),
                                            ),
                                          ),
                                      ],
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: InfluencerCard(
                                      influencer: sub.influencers.elementAt(i),
                                      sendNotification: true,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
