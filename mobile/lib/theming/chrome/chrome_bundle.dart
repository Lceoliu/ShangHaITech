import 'package:flutter/material.dart';

enum ChromeStyleId { sunlitV1, terminalV1 }

class NavTabItem {
  const NavTabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.badgeCount,
  });
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final int? badgeCount;
}

typedef BottomNavBuilder = Widget Function(
  BuildContext context,
  int currentIndex,
  List<NavTabItem> items,
  ValueChanged<int> onTap,
);

class ChromeBundle {
  const ChromeBundle({required this.bottomNav});
  final BottomNavBuilder bottomNav;
}
