import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/approved_influencer_item.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/pending_influencer_item.dart';

class InfluencerHome extends StatefulWidget {
  const InfluencerHome({super.key});

  @override
  State<InfluencerHome> createState() => _InfluencerHomeState();
}

class _InfluencerHomeState extends State<InfluencerHome> {
  int selectedOption = 0;

  List<Map<String, dynamic>> pending = [
    {
      'name': 'Sophia Carter',
      'username': 'SophiaVibes',
      'followers': 1200,
      'avatar': 'https://picsum.photos/200/300',
      'rating': 4.5,
      'location': 'New York, USA',
      'created_at': 1745158111912,
    },
    {
      'name': 'Liam Thompson',
      'username': 'LiamEats',
      'followers': 503000,
      'avatar': 'https://picsum.photos/200/300',
      'rating': 3.2,
      'location': 'New York, USA',
      'created_at': 1745158111912,
    },
    {
      'name': 'Ella Rodriguez',
      'username': 'EllaBeautyX',
      'followers': 10500000,
      'avatar': 'https://picsum.photos/200/300',
      'rating': 5.0,
      'location': 'New York, USA',
      'created_at': 1745158111912,
    },
  ];

  List<Map<String, dynamic>> approved = [
    {
      'name': 'Sophia Carter',
      'username': 'SophiaVibes',
      'followers': 1200,
      'avatar': 'https://picsum.photos/200/300',
      'rating': 4.5,
    },
    {
      'name': 'Liam Thompson',
      'username': 'LiamEats',
      'followers': 503000,
      'avatar': 'https://picsum.photos/200/300',
      'rating': 3.2,
    },
    {
      'name': 'Ella Rodriguez',
      'username': 'EllaBeautyX',
      'followers': 10500000,
      'avatar': 'https://picsum.photos/200/300',
      'rating': 5.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(isHome: false),
      backgroundColor: AppColors.green[700],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              CustomTabBar(
                options: ['Pending', 'Approved'],
                onChange: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
              SizedBox(height: 12),
              if (selectedOption == 0)
                ...pending.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: PendingInfluencerItem(
                      name: item['name'],
                      avatar: item['avatar'],
                      followers: item['followers'],
                      rating: item['rating'],
                      username: item['username'],
                      location: item['location'],
                      createdAt: item['created_at'],
                    ),
                  );
                }),
              if (selectedOption == 1)
                CustomSearchBar(
                  hintText: 'Search by name or social handle',
                ),
              if (selectedOption == 1)
                ...approved.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ApprovedInfluencerItem(
                      name: item['name'],
                      avatar: item['avatar'],
                      followers: item['followers'],
                      rating: item['rating'],
                      username: item['username'],
                    ),
                  );
                }),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
