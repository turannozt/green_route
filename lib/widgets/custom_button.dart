import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        // backgroundColor:
        //     MaterialStateProperty.all<Color>(Colors.indigo.shade700),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(
            50.0,
          ), // Yüksekliği istediğiniz değeri burada ayarlayabilirsiniz
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
