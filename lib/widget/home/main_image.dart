import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  // 假设的图片列表
  static final List<String> imgList = [
    'lib/assets/bgImage/swiper.jpg',
    'lib/assets/bgImage/swiper.jpg',
    'lib/assets/bgImage/swiper.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          viewportFraction: 1.0, // 每个视图只显示一个完整的图片
        ),
        items: imgList
            .map(
              (item) => ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: 1000.0, // 提供一个大的宽度以确保填满
                  // 如果图片不存在，显示一个占位符
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
