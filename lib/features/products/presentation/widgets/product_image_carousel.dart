import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_paths.dart';

class ProductDetailsImageSlider extends StatefulWidget {
  const ProductDetailsImageSlider({super.key});

  @override
  State<ProductDetailsImageSlider> createState() =>
      _ProductDetailsImageSliderState();
}

class _ProductDetailsImageSliderState extends State<ProductDetailsImageSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            viewportFraction: 1,
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

                      decoration: BoxDecoration(color: Colors.grey.withAlpha(50)),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0)),
                    );
                  },
                );
              }).toList(),
        ),

        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: .center,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      alignment: Alignment.center,
                      height: 10,
                      width: 10,
                      margin: EdgeInsets.only(right: 4),

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        color: value == i
                            ? Colors.blue
                            : Colors.white,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
