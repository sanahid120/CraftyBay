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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(fontSize: 24)),

        leading: IconButton(
          onPressed: () {
            context.read<HomepageMainNavProvider>().moveToHomepage();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),



    );
  }
}
