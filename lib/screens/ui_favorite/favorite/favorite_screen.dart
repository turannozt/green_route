import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, Theme.of(context).brightness),
    );
  }

  AppBar appBar(BuildContext context, Brightness brightness) {
    Color backgroundColor = brightness == Brightness.dark
        ? Colors.black.withOpacity(0.0)
        : Colors.white;

    Color textColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        'Favorites',
        style: GoogleFonts.openSans(
            color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      //backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
