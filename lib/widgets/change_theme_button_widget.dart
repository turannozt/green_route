import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      icon: themeProvider.isDarkMode
          ? const Icon(
              Icons.wb_sunny,
              color: Colors
                  .white, // Değişen kısım, dark mode için güneş simgesi rengi
            )
          : const Icon(
              Icons.nightlight_round,
              color: Colors
                  .black, // Değişen kısım, light mode için ay simgesi rengi
            ),
      onPressed: () {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(!themeProvider.isDarkMode);
      },
    );
  }
}
