// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    colorScheme: const ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.indigo.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.indigo.shade800, opacity: 0.8),
  );
}

class TextStil {
  static final titleHead1 = GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static final titleHead2 = GoogleFonts.openSans(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  static final normalText = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final titleStyle = GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );

  static final headingStyle = GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );

  static final subtitleStyle = GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      // color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
    ),
  );
}
