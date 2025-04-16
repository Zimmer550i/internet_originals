import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/task_card.dart';

class TalentAllPendingTasks extends StatelessWidget {
  const TalentAllPendingTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pending Task"),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RefreshIndicator(
            color: AppColors.red,
            backgroundColor: AppColors.green[900],
            onRefresh: () async {
            },
            child: ListView.builder(
              itemCount: 6,
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              itemBuilder: (val, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TaskCard(
                    title: "Nike Air Max Campaign",
                    brandName: "Nike",
                    imageLink: "https://picsum.photos/200/200",
                    deadline: DateTime.now().add(Duration(days: 3)),
                    details: "Upload your Instagram reel & post",
                    requiredMatrics: {"Likes": "40K", "Comments": "5K"},
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
