import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
      //  color: ksecondryLightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          const Icon(
            Icons.support_agent,
            size: 50,
            //color: Colors.indigo,
          ),
          const SizedBox(width: 10),
          Text(
            "Feel Free to Ask, We Ready to Help",
            style: GoogleFonts.openSans(
              fontSize: ksmallFontSize,
             // color: Colors.indigo.shade500,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}