import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/design_pattern.dart';
import 'package:internet_originals/views/screens/sub_admin/sub_admin_app.dart';
import 'package:internet_originals/views/screens/talent/talent_app.dart';

class AppRoutes {
  static String designPattern = "/design_pattern";
  static String talentApp = "/talent_home";
  static String subAdminApp = "/sub_admin_home";

  static Map<String, Widget> routeWidgets = {
    designPattern: DesignPattern(),
    talentApp: TalentApp(),
    subAdminApp: SubAdminApp()
  };

  static List<GetPage> pages = [
    ...routeWidgets.entries.map(
      (e) => GetPage(name: e.key, page: () => e.value),
    ),
  ];
}
