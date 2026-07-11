import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../features/products/presentation/screens/product_list_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.category, {super.key});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapCategory(context, category.title);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: .center,
        spacing: 4,
        children: [
          Container(
            width: 75,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              category.icon,
              cacheHeight: 50,
              cacheWidth: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: AppColors.themeColor);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),

          Text(
            category.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w500,
              color: AppColors.themeColor,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: .center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void onTapCategory(BuildContext context, String categoryName) {
    Navigator.of(
      context,
    ).pushNamed(ProductListScreen.name, arguments: categoryName);
  }
}
