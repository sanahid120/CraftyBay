import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/provider/homepage_main_nav_provider.dart';
import '../../../../shared/presentation/widgets/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = "/WishListScreen";

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) {
        onPressedBackButton();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("WishList"),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              onPressedBackButton();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: 40,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,

              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: .65,
            ),
            itemBuilder: (context, index) {
              // return ProductCard();
            },
          ),
        ),
      ),
    );
  }

  void onPressedBackButton() {
    context.read<HomepageMainNavProvider>().moveToHomepage();
  }
}
