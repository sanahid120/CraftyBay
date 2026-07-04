import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_paths.dart';
import '../../../app/constants.dart';
import '../../../features/products/presentation/screens/product_details_screen.dart';
import 'fav_icon.dart';
import 'product_rating.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTapProduct(context);
      },
      child: Card(
        elevation: 4,
        color: Colors.white,

        child: SizedBox(
          width: 150,
          height: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              Flexible(
                child: Container(
                  padding: .all(4),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: AppColors.themeColor.withAlpha(30),
                  ),
                  child: Image.asset(AssetPaths.shoeImage, fit: .scaleDown),
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
                      style: TextTheme.of(
                        context,
                      ).titleSmall?.copyWith(color: AppColors.themeColor),
                    ),
                    ProductRating(rating: 4.5,),
                    FavIcon(onTap: (){},),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  void onTapProduct(BuildContext context) {
    Navigator.of(context).pushNamed(ProductDetailsScreen.name);
  }
}
