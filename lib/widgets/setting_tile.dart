import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/setting.dart';
import '../provider/auth_provider.dart';
import '../screens/welcome_screen.dart';

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        if (setting.route == "/logout") {
          ap.userSignOut().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                ),
              );
        }
      }, // Navigation
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              //color: klightContentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(setting.icon),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              setting.title,
              style: GoogleFonts.openSans(
                //color: kprimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Icon(
              CupertinoIcons.chevron_forward,
            ),
          ),
        ],
      ),
    );
  }
}
