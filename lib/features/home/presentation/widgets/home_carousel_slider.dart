import 'package:carousel_slider/carousel_slider.dart';
import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/app/app_paths.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 175,
            viewportFraction: 0.95,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 3),
          ),

          items:
              [
                AssetPaths.navLogoSvg,
                AssetPaths.logoSvg,
                AssetPaths.shoeImage,
                AssetPaths.noImagePng,
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      alignment: .center,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),

                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: .circular(12),
                      ),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0)),
                    );
                  },
                );
              }).toList(),
        ),

        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    alignment: Alignment.center,
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(right: 4),

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: value == i ? Colors.blue : Colors.white,
                      ),
                      shape: BoxShape.circle,
                      color: value == i
                          ? Colors.blue
                          : Colors.grey.withAlpha(50),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
