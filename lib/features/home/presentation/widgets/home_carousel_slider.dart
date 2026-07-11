import 'package:carousel_slider/carousel_slider.dart';
import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/app/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../providers/home_slider_provider.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSliderProvider>(
      builder: (context, homeSliderProvider, _) {
        return Visibility(
          visible: !homeSliderProvider.getHomeSlidersInProgress,
          replacement: SizedBox(
            height: 175,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.themeColor),
            ),
          ),
          child: Column(
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

                items: homeSliderProvider.homeSliders.map((slider) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        alignment: .center,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: double.maxFinite,
                        height: double.maxFinite,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            slider.photoUrl,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            height: double.maxFinite,
                            cacheHeight: 550,
                            cacheWidth: 1000,

                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.themeColor,
                                ),
                              );
                            },
                            errorBuilder: (context, child, loadingProgress) {
                              return Center(child: Icon(Icons.error_outline));
                            },
                          ),
                        ),
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
                      for (
                        int i = 0;
                        i < homeSliderProvider.homeSliders.length;
                        i++
                      )
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
          ),
        );
      },
    );
  }
}
