import 'package:flutter/material.dart';
import 'components/custom_app_bar.dart';
import 'components/activity_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              CustomAppBar(),
              ActivityCards(),
            ],
          ),
        ],
      ),
    );
  }
}
