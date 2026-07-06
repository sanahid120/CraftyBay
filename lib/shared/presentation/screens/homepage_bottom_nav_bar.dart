import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/cart/presentation/screens/cart_screen.dart';
import 'package:craftybay/features/category/presentaion/screens/category_screen.dart';
import 'package:craftybay/features/home/presentation/screens/HomeScreen.dart';
import 'package:craftybay/shared/presentation/provider/homepage_main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/wishlist/presentation/screens/wish_list_screen.dart';

class HomepageBottomNavBar extends StatefulWidget {
  const HomepageBottomNavBar({super.key});
  static const String name = "/HomepageBottomNavBar";

  @override
  State<HomepageBottomNavBar> createState() => _HomepageBottomNavBarState();
}

class _HomepageBottomNavBarState extends State<HomepageBottomNavBar> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    WishListScreen(),
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Wishlist",
              ),
            ],
          ),
        );
      },
    );
  }
}
