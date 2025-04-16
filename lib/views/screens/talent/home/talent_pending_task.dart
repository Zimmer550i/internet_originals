import 'package:flutter/material.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/task_card_detailed.dart';

class TalentPendingTask extends StatelessWidget {
  const TalentPendingTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pending Task"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                TaskCardDetailed(
                  title: "Nike Air Max Campaign",
                  brandName: "Nike",
                  imageLink: "https://picsum.photos/200/200",
                  deadline: DateTime.now().add(Duration(days: 3)),
                  details: "Upload your Instagram reel & post",
                  requiredMatrics: {"Likes": "40K", "Comments": "5K"},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
