import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}
