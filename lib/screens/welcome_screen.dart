import 'package:flutter/material.dart';
import 'package:green_route/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../widgets/custom_button.dart';
import 'ui_profile/profile_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/image1.png",
                    height: 300,
                  ),
                  const SizedBox(height: 20),
                  Text("Let's get started", style: TextStil.titleHead2),
                  const SizedBox(height: 10),
                  Text("Never a better time than now to start.",
                      style: TextStil.normalText),
                  const SizedBox(height: 20),
                  // custom button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () async {
                        if (ap.isSignedIn == true) {
                          await ap.getDataFromSP().whenComplete(
                                () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileScreen(),
                                  ),
                                ),
                              );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        }
                      },
                      text: "Get started",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
