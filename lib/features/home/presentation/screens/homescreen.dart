import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/app/app_paths.dart';
import 'package:craftybay/shared/presentation/widgets/category_card.dart';
import 'package:craftybay/features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AssetPaths.navLogoSvg),
        actions: [
          AppbarIconButton(onTap: () {}, icon: Icons.person),
          const SizedBox(width: 8),
          AppbarIconButton(onTap: () {}, icon: Icons.call),
          const SizedBox(width: 8),
          AppbarIconButton(onTap: () {}, icon: Icons.notifications),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              ProductSearchBar(),

              const SizedBox(height: 16),

              HomeCarouselSlider(),

              const SizedBox(height: 16),

              SectionHeader(name: "All Categories", onTapSeeAll: () {}),

              const SizedBox(height: 16),

              _buildCategoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: .horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => CategoryCard(),
        separatorBuilder: (_, _) => SizedBox(width: 8),
        itemCount: 10,
      ),
    );
  }
}
