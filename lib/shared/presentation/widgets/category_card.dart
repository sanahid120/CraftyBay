import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../features/products/presentation/screens/product_list_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTapCategory(context, 'Electronics' );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .center,
        spacing: 4,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.computer, size: 48, color: AppColors.themeColor),
          ),

          Text(
            "Electronics",
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w500,
              color: AppColors.themeColor,

            ),
          ),
        ],
      ),
    );
  }

  void onTapCategory(BuildContext context, String categoryName) {
    Navigator.of(context).pushNamed(ProductListScreen.name, arguments:categoryName );
  }
}
