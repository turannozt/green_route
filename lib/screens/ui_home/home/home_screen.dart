import 'package:flutter/material.dart';
import 'package:green_route/screens/activity_add.dart';
import 'components/bottom_buttons.dart';
import 'components/categories.dart';
import 'components/custom_app_bar.dart';
import 'components/activity_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const CustomAppBar(),
              IconButton(
                icon: const Icon(Icons.cloud_circle),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddActivityPage(),
                )),
              ),
              const Categories(),
              const ActivityCards(),
            ],
          ),
          const BottomButtons(),
        ],
      ),
    );
  }
}
