// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../model/house.dart';
import 'components/carousel_images.dart';
import 'components/custom_app_bar.dart';
import 'components/house_details.dart';

class DetailsScreen extends StatefulWidget {
  final House house;

  const DetailsScreen({Key? key, required this.house}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    CarouselImages(widget.house.moreImagesUrl),
                    const CustomAppBar(),
                  ],
                ),
                HouseDetails(widget.house),
              ],
            ),
          //  const BottomButtons(),
          ],
        ),
      ),
    );
  }
}
