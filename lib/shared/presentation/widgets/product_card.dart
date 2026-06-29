
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_paths.dart';
import '../../../app/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,

      child: SizedBox(
        width: 140,
        child: Column(
          spacing: 2,
          children: [
            Container(
              width: 140,
              height: 140,
              padding: .all(4),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: AppColors.themeColor.withAlpha(30),
              ),
              child: Image.asset(
                AssetPaths.shoeImage,
                fit: .scaleDown,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'shoe hani jani me name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${Constants.takaSing}120',
                    style: TextTheme.of(context).titleSmall?.copyWith(
                      color: AppColors.themeColor,
                    ),
                  ),
                  Wrap(
                    crossAxisAlignment: .center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(
                        '4.5',
                        style: TextTheme.of(context).bodySmall
                            ?.copyWith(color: AppColors.themeColor),
                      ),
                    ],
                  ),
                  Container(
                    padding: .all(2),
                    decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: .circular(4),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
