import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            FadeAnimatedText('Green ROUTE!'),
            FadeAnimatedText('Activity JOIN!!'),
            FadeAnimatedText('Meet New  PEOPLE!!!'),
          ],
          onTap: () {
            debugPrint("Tap Event");
          },
        ),
      ),
    );
  }
}
