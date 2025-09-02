import 'package:flutter/material.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';

class InfluencerList extends StatelessWidget {
  const InfluencerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Influencer List"),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              // child: InfluencerCard(),
            );
          },
        ),
      ),
    );
  }
}
