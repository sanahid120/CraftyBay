import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_paths.dart';

class ProductDetailsImageSlider extends StatefulWidget {
  const ProductDetailsImageSlider( {super.key,required this.photos});
  final List<String> photos;

  @override
  State<ProductDetailsImageSlider> createState() =>
      _ProductDetailsImageSliderState();
}

class _ProductDetailsImageSliderState extends State<ProductDetailsImageSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            autoPlay: widget.photos.length>1?true:false,
            autoPlayAnimationDuration: Duration(seconds: 3),
          ),

          items:
              widget.photos.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      alignment: .center,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),

                      decoration: BoxDecoration(color: Colors.grey.withAlpha(50)),
                      child: widget.photos.isEmpty? Image.asset(AssetPaths.noImagePng,fit: BoxFit.cover,): Image.network(i,
                        cacheWidth: 720,
                        cacheHeight: 480,
                        height: 220,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(AssetPaths.noImagePng,fit: BoxFit.cover,);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
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
                  for (int i = 0; i < widget.photos.length; i++)
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
