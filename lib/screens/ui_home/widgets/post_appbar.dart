import 'package:flutter/material.dart';

class PostAppBarWidget extends StatefulWidget {
  const PostAppBarWidget({super.key});

  @override
  State<PostAppBarWidget> createState() => _PostAppBarWidgetState();
}

class _PostAppBarWidgetState extends State<PostAppBarWidget> {
  bool isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
    final String message =
        isFavorited ? 'Favorilere eklendi!' : 'Favorilerden kaldırıldı!';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black26.withOpacity(0.5)
                      : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _toggleFavorite();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                   color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black26.withOpacity(0.5)
                : Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.favorite,
                  color: isFavorited ? Colors.redAccent : null,
                  size: 28,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
