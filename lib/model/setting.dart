import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Data",
    route: "/personal_data",
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Settings",
    route: "/settings",
    icon: Icons.settings,
  ),
  Setting(
    title: "Past Events",
    route: "/e-statements",
    icon: CupertinoIcons.doc_fill,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "FAQ",
    route: "/",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Help",
    route: "/",
    icon: CupertinoIcons.info_circle_fill,
  ),
  Setting(
    title: "Logout",
    route: "/logout",
    icon: CupertinoIcons.xmark_circle_fill,
  ),
];
