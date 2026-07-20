import 'package:craftybay/admin/presentation/screens/add_new_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../app/app_paths.dart';
import '../../../app/extensions/localization_extension.dart';
import '../../../features/category/presentaion/providers/category_list_provider.dart';
import '../../../features/home/presentation/widgets/appbar_widget.dart';
import '../../../features/home/presentation/widgets/home_carousel_slider.dart';
import '../../../features/home/presentation/widgets/home_category_list.dart';
import '../../../features/home/presentation/widgets/homepage_drawer.dart';
import '../../../features/home/presentation/widgets/horizontal_product_list_view.dart';
import '../../../features/home/presentation/widgets/product_search_bar.dart';
import '../../../features/home/presentation/widgets/section_header.dart';
import '../../../features/products/presentation/providers/product_list_provider.dart';
import '../../../features/products/presentation/screens/product_list_screen.dart';
import '../../../shared/presentation/provider/homepage_main_nav_provider.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  static const String name = "/AdminHomepage";

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadProducts();
    });
  }

  Future<void> loadProducts() async {
    final categoryProvider = context.read<CategoryListProvider>();

    if (categoryProvider.categories.isNotEmpty) {
      await Future.wait([
        context.read<ProductListProvider>().getProducts(
          categoryProvider.categories[8].id,
        ),
        Future.delayed(Duration(microseconds: 100)),
        context.read<ProductListProvider>().getProducts(
          categoryProvider.categories[7].id,
        ),
        Future.delayed(Duration(microseconds: 100)),
        context.read<ProductListProvider>().getProducts(
          categoryProvider.categories[6].id,
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello Admin 👋")),

      drawer: HomepageDrawer(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const ProductSearchBar(),
              const SizedBox(height: 16),
              const HomeCarouselSlider(),
              const SizedBox(height: 16),
              SectionHeader(
                name: context.localization.allCategories,
                onTapSeeAll: () =>
                    context.read<HomepageMainNavProvider>().moveToCategory(),
              ),
              const SizedBox(height: 16),
              const HomeCategoryList(),

              const SizedBox(height: 16),
              Consumer<CategoryListProvider>(
                builder: (context, categoryProvider, _) {
                  return SectionHeader(
                    name: context.localization.popular,
                    onTapSeeAll: () {
                      Navigator.pushNamed(
                        context,
                        ProductListScreen.name,
                        arguments: categoryProvider.categories[8],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              Consumer<CategoryListProvider>(
                builder: (context, categoryProvider, _) {
                  if (categoryProvider.categories.length < 9) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return HorizontalProductListView(
                    category: categoryProvider.categories[8],
                  );
                },
              ),

              const SizedBox(height: 16),
              Consumer<CategoryListProvider>(
                builder: (context, categoryProvider, _) {
                  return SectionHeader(
                    name: context.localization.special,
                    onTapSeeAll: () {
                      Navigator.pushNamed(
                        context,
                        ProductListScreen.name,
                        arguments: categoryProvider.categories[7],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              Consumer<CategoryListProvider>(
                builder: (context, categoryProvider, _) {
                  if (categoryProvider.categories.length < 9) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return HorizontalProductListView(
                    category: categoryProvider.categories[7],
                  );
                },
              ),

              const SizedBox(height: 16),
              Consumer<CategoryListProvider>(
                builder: (context, categoryProvider, _) {
                  return SectionHeader(
                    name: context.localization.newArrival,
                    onTapSeeAll: () {
                      Navigator.pushNamed(
                        context,
                        ProductListScreen.name,
                        arguments: categoryProvider.categories[5],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              Consumer<CategoryListProvider>(
                builder: (context, categoryProvider, _) {
                  if (categoryProvider.categories.length < 9) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return HorizontalProductListView(
                    category: categoryProvider.categories[5],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onPressedFloatingActionButton();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void onPressedFloatingActionButton() {
    Navigator.pushNamed(context, AddNewProduct.name);

  }
}
