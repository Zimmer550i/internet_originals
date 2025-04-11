import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/design_pattern.dart';

class AppRoutes {
  static String designPattern = "/design_pattern";

  static Map<String, Widget> routeWidgets = {
    designPattern: DesignPattern(),
  };

  static List<GetPage> pages = [
    ...routeWidgets.entries.map(
      (e) => GetPage(name: e.key, page: () => e.value),
    ),
  ];
}
