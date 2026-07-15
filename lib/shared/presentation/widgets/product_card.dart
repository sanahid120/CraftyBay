import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_paths.dart';
import '../../../app/constants.dart';
import '../../../features/products/data/model/product_model.dart';
import '../../../features/products/presentation/screens/product_details_screen.dart';
import 'fav_icon.dart';
import 'product_rating.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {super.key});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    double d = random.nextDouble()*5;

    return InkWell(
      onTap: () {
        onTapProduct(context, product);
      },
      child: Card(
        elevation: 4,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: .start,
          spacing: 2,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: AppColors.themeColor.withAlpha(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.photos.isEmpty
                      ? Image.asset(
                          AssetPaths.noImagePng,
                          fit: BoxFit.scaleDown,
                          cacheWidth: 240,
                          cacheHeight: 360,
                          width: double.infinity,
                    height:   340,
                        )
                      : Image.network(
                          product.photos[0],
                          cacheWidth: 240,
                          cacheHeight: 360,
                          height: 360,

                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AssetPaths.noImagePng,
                              fit: BoxFit.cover,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(child: CircularProgressIndicator());
                          },

                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${Constants.takaSing}${product.currentPrice}',
                    style: TextTheme.of(context).titleSmall?.copyWith(
                      color: AppColors.themeColor,
                      fontSize: 16,
                    ),
                  ),
                  ProductRating(rating: d.toStringAsFixed(1) ),
                  FavIcon(onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapProduct(BuildContext context, ProductModel product) {
    Navigator.of(
      context,
    ).pushNamed(ProductDetailsScreen.name, arguments: product);
  }
}
