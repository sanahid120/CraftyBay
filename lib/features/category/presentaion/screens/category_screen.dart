import 'package:craftybay/shared/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/provider/homepage_main_nav_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,_){
        onPressedBackButton();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Categories", style: TextStyle(fontSize: 24)),

          leading: IconButton(
            onPressed:onPressedBackButton,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: 40,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return FittedBox(child: CategoryCard());
            },
          ),
        ),
      ),
    );
  }
  void onPressedBackButton(){
    context.read<HomepageMainNavProvider>().moveToHomepage();
  }
}
