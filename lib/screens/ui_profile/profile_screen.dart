import 'package:flutter/material.dart';
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
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Profile Screen",
        ),
        actions: const [
          ChangeThemeButtonWidget(),
        ],
        centerTitle: true,
      ),
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
}
