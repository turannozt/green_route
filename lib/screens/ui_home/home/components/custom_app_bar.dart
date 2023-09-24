import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(
        left: appPadding,
        right: appPadding,
        top: appPadding * 5,
      ),
      child: SizedBox(
        height: size.height * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Green Route',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ad Soyad',
                  style: TextStyle(
                    //color: black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Text(
                  'Hoşgeldin! Etkinliklere Katıl !',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
