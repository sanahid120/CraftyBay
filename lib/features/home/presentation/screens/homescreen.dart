import 'package:craftybay/app/app_paths.dart';
import 'package:craftybay/features/products/presentation/providers/product_list_provider.dart';
import 'package:craftybay/shared/presentation/provider/homepage_main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/home_category_list.dart';
import '../widgets/horizontal_product_list_view.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductListProvider _productListProvider = ProductListProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productListProvider.getProducts("6812518cea40bfc6edc67356");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productListProvider,


      child: Scaffold(
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
                SectionHeader(
                  name: "All Categories",
                  onTapSeeAll: () {
                    context.read<HomepageMainNavProvider>().moveToCategory();
                  },
                ),
                const SizedBox(height: 16),
                HomeCategoryList(),
                const SizedBox(height: 16),
                SectionHeader(name: "Popular", onTapSeeAll: () {}),
                const SizedBox(height: 8),
                HorizontalProductListView(),
                const SizedBox(height: 16),
                SectionHeader(name: "Special", onTapSeeAll: () {}),
                const SizedBox(height: 8),
                HorizontalProductListView(),
                const SizedBox(height: 16),
                SectionHeader(name: "New", onTapSeeAll: () {}),
                const SizedBox(height: 8),
                HorizontalProductListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
