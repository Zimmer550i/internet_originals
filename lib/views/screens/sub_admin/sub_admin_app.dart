import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class SubAdminApp extends StatefulWidget {
  const SubAdminApp({super.key});

  @override
  State<SubAdminApp> createState() => _SubAdminAppState();
}

class _SubAdminAppState extends State<SubAdminApp> {
  int index = 0;

  PageController controller = PageController();

  List<Widget> pages = [
    FlutterLogo(size: 50),
    FlutterLogo(size: 500),
    FlutterLogo(size: 50),
    FlutterLogo(size: 500),
    FlutterLogo(size: 900),
  ];

  List<String> labels = [
    "Campaigns",
    "Influencers",
    "Payments",
    "Notifications",
    "Settings",
  ];

  List<String> icons = [
    AppIcons.campaigns,
    AppIcons.influencers,
    AppIcons.payments,
    AppIcons.notifications,
    AppIcons.settings,
  ];

  List<String> iconsDark = [
    AppIcons.campaignsDark,
    AppIcons.influencersDark,
    AppIcons.paymentsDark,
    AppIcons.notificationsDark,
    AppIcons.settingsDark,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages[index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        selectedItemColor: AppColors.red[400],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [for (int i = 0; i < pages.length; i++) item(i)],
      ),
    );
  }

  BottomNavigationBarItem item(int index) {
    return BottomNavigationBarItem(
      icon: CustomSvg(asset: icons[index]),
      activeIcon: CustomSvg(asset: iconsDark[index]),
      label: labels[index],
    );
  }
}
