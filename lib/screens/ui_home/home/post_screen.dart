import 'package:flutter/material.dart';

import '../widgets/post_appbar.dart';
import '../widgets/post_bottom_bar.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/house1.jpeg",
          ),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: PostAppBarWidget(),
        ),
        bottomNavigationBar: PostBottomBar(),
      ),
    );
  }
}
