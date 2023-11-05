// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_route/screens/ui_home/home/components/activity_screen.dart';

import 'credit_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var category = ["Sport", "Party", "Developers", "Activity", "Comunities"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, Theme.of(context).brightness),
      body: Column(
        children: [
          //appBar(),
          _searchField(),
          const SizedBox(height: 10),
          _categoriesSection(),
          const ActivityScreen(),
        ],
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
      actions: [IconButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MySample(),));
      }, icon: const Icon(Icons.ads_click))],
      backgroundColor: backgroundColor,
      title: Text(
        'Green Route',
        style: GoogleFonts.openSans(
            color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      //backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }

  SingleChildScrollView _categoriesSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            for (int i = 0; i < 5; i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade700,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  category[i],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        )
      ]),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          //fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search Activity',
          hintStyle: GoogleFonts.openSans(fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              color: Colors.blueGrey.shade500,
            ),
          ),
          suffixIcon: SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    //color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/icons/Filter.svg',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
