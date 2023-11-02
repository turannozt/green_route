import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/setting.dart';
import '../../widgets/change_theme_button_widget.dart';
import '../../widgets/setting_tile.dart';
import 'widget/avatar_card.dart';
import 'widget/support_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, Theme.of(context).brightness),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AvatarCard(),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(
                    settings.length,
                    (index) => SettingTile(setting: settings[index]),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                Column(
                  children: List.generate(
                    settings2.length,
                    (index) => SettingTile(setting: settings2[index]),
                  ),
                ),
                const SizedBox(height: 10),
                const SupportCard()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Brightness brightness) {
    Color backgroundColor = brightness == Brightness.dark
        ? Colors.black.withOpacity(0.0)
        : Colors.white;

    Color textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return AppBar(
      actions: const [
        ChangeThemeButtonWidget(),
      ],
      backgroundColor: backgroundColor,
      title: Text(
        'Profile Screen',
        style: GoogleFonts.openSans(
            color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      //backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
