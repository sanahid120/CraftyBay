import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/cart/presentation/screens/cart_screen.dart';
import 'package:craftybay/features/category/presentaion/providers/category_list_provider.dart';
import 'package:craftybay/features/category/presentaion/screens/category_screen.dart';
import 'package:craftybay/features/home/presentation/providers/home_slider_provider.dart';
import 'package:craftybay/features/home/presentation/screens/HomeScreen.dart';
import 'package:craftybay/shared/presentation/provider/homepage_main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/extensions/localization_extension.dart';

class HomepageBottomNavBar extends StatefulWidget {
  const HomepageBottomNavBar({super.key});
  static const String name = "/HomepageBottomNavBar";

  @override
  State<HomepageBottomNavBar> createState() => _HomepageBottomNavBarState();
}


class _HomepageBottomNavBarState extends State<HomepageBottomNavBar> {

  @override
  void initState() {
    // TODO: implement initState



    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeSliderProvider>().getSlidersData();
      context.read<CategoryListProvider>().getCategories();
    });
  }


  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    SizedBox()
  ];
  /*
  IndexedStack(
            index: 0,
            children: [SizedBox(),SizedBox(),SizedBox(),SizedBox(),],
          )
  * */
  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageMainNavProvider>(
      builder: (context, mainNavProvider, _) {
        return Scaffold(
          extendBody: false,

          body: _screens[mainNavProvider.selectedIndex],

          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              mainNavProvider.updateIndex(index);
            },

            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,

            backgroundColor: Colors.white,
            elevation: 5,
            currentIndex: mainNavProvider.selectedIndex,
            selectedItemColor: AppColors.themeColor,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: context.localization.home),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: context.localization.categories,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: context.localization.cart,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: context.localization.profile,
              ),

            ],
          ),
        );
      },
    );
  }
}
