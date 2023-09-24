import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({
    super.key,
  });

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1694875464499-334d2dc113a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1913&q=80'),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jhon',
              style: TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
                // color: kprimaryColor,
              ),
            ),
            Text(
              'bio',
              style: TextStyle(
                fontSize: ksmallFontSize,
                //color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
