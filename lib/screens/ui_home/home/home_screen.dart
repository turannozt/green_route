import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/activity_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(context),
      body: const Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              //CustomAppBar(),
              ActivityCards(),
            ],
          ),
        ],
      ),
    );
  }
   _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Green Route',
        style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w500),
      ),
    );
  }
}
