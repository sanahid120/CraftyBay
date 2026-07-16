import 'package:craftybay/app/app_paths.dart';
import 'package:craftybay/app/providers/language_provider.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:craftybay/features/category/presentaion/providers/category_list_provider.dart';
import 'package:craftybay/features/products/presentation/providers/product_list_provider.dart';
import 'package:craftybay/shared/presentation/provider/homepage_main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_theme.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../../app/providers/theme_provider.dart';
import '../../../products/presentation/screens/product_list_screen.dart';
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
      appBar: AppBar(
        title: SvgPicture.asset(AssetPaths.navLogoSvg, height: 30),

        actions: [
          AppbarIconButton(icon: Icons.notifications, onTap: () {}),
          const SizedBox(width: 16),
        ],
      ),

      drawer: Drawer(
        child: Consumer2<ThemeProvider, LanguageProvider>(
          builder: (context, themeProvider, languageProvider, _) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey.withAlpha(50)),
                  child: AppLogo(),
                ),
                ListTile(
                  leading: themeProvider.currentTheme == AppTheme.lightTheme
                      ? const Icon(Icons.light_mode)
                      : Icon(Icons.dark_mode),
                  title: Text(context.localization.changeTheme),
                  trailing: Switch.adaptive(
                    value: themeProvider.currentTheme == AppTheme.lightTheme,
                    onChanged: (value) {
                      context.read<ThemeProvider>().currentTheme ==
                              AppTheme.lightTheme
                          ? context.read<ThemeProvider>().changeTheme(
                              AppTheme.darkTheme,
                            )
                          : context.read<ThemeProvider>().changeTheme(
                              AppTheme.lightTheme,
                            );
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.language),
                  title: Text(context.localization.changeYourLanguage),
                  trailing: DropdownButton<Locale>(
                    value: languageProvider.currentLocale,
                    onChanged: (locale) {
                      languageProvider.changeLocale(locale!);
                    },
                    items: [
                      DropdownMenuItem(
                        value: Locale('en'),
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: Locale('bn'),
                        child: Text('বাংলা'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),

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
    );
  }
}
