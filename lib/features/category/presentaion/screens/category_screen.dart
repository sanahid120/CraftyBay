import 'package:craftybay/shared/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../../shared/presentation/provider/homepage_main_nav_provider.dart';
import '../providers/category_list_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const String name = "/CategoryScreen";
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_loadCategories);
  }

  void _loadCategories() {
    if (_scrollController.position.extentAfter < 200) {
      context.read<CategoryListProvider>().getCategories();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) {
        onPressedBackButton();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.categories, style: TextStyle(fontSize: 24)),
          leading: IconButton(
            onPressed: onPressedBackButton,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Consumer<CategoryListProvider>(
          builder: (context, categoryListProvider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Visibility(
                    visible:
                        categoryListProvider.initialLoadInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: categoryListProvider.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 16,
                            ),
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            categoryListProvider.categories[index],
                          );
                        },
                      ),
                    ),
                  ),
                  if (categoryListProvider.loadMoreInProgress)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void onPressedBackButton() {
    context.read<HomepageMainNavProvider>().moveToHomepage();
  }
}
