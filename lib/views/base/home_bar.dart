import 'package:flutter/material.dart';

class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  const HomeBar({super.key, this.isHome = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      
    );
  }
}
