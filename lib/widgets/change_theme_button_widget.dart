import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      icon: themeProvider.isDarkMode
          ? const Icon(Icons.wb_sunny) // Aydınlık tema için güneş simgesi
          : const Icon(Icons.nightlight_round), // Karanlık tema için ay simgesi
      onPressed: () {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(!themeProvider.isDarkMode);
      },
    );
  }
}
