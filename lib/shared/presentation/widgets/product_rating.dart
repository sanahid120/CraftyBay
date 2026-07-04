import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({
    super.key, required this.rating
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: .center,
      children: [
        Icon(Icons.star, color: Colors.amber, size: 18),
        Text(
          "$rating",
          style: TextTheme.of(context).titleSmall
              ?.copyWith(color: AppColors.themeColor),
        ),
      ],
    );
  }
}
