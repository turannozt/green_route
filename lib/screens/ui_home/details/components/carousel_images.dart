// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImages extends StatefulWidget {
  final List<String> imagesListUrl;

  const CarouselImages(this.imagesListUrl, {Key? key}) : super(key: key);

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.35,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          autoPlay: false, // Auto oynatma ayarını burada kontrol edebilirsiniz.
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        items: widget.imagesListUrl.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                // ignore: prefer_const_constructors
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
