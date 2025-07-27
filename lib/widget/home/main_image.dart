import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          'images/swiper.jpg', // Assuming the image is in the assets
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
