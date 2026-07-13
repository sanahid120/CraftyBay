import 'package:craftybay/app/constants.dart';
import 'package:craftybay/features/products/data/model/product_model.dart';
import 'package:craftybay/features/products/presentation/widgets/size_picker.dart';
import 'package:craftybay/shared/presentation/widgets/fav_icon.dart';
import 'package:craftybay/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../shared/presentation/widgets/product_rating.dart';
import '../widgets/add_to_cart_bar.dart';
import '../widgets/color_picker.dart';
import '../widgets/product_image_carousel.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productDetails});

  final ProductModel productDetails;
  static const String name = "/ProductDetailsScreen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductDetailsImageSlider(
                    photos: widget.productDetails.photos,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          buildTitleSection(
                            context,
                            widget.productDetails.title,
                          ),

                          const SizedBox(height: 16),
                          ColorPicker(
                            colors: widget.productDetails.colors,
                            onColorSelected: (String color) {},
                          ),
                          const SizedBox(height: 16),
                          SizePicker(
                            sizes: widget.productDetails.sizes,
                            onSizeSelected: (String size) {},
                          ),
                          const SizedBox(height: 16),
                          Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "Description",
                                style: TextTheme.of(context).titleMedium
                                    ?.copyWith(color: AppColors.themeColor),
                              ),
                              const SizedBox(height: 8),

                              Text(
                                widget.productDetails.description,
                                style: TextTheme.of(context).bodyMedium
                                    ?.copyWith(color: Colors.grey.shade600),
                                maxLines: 25,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          AddToCartBar(
            price: widget.productDetails.currentPrice,
            onTapAddToCart: () {},
          ),
        ],
      ),
    );
  }
}

Widget buildTitleSection(BuildContext context, String title) {
  return Row(
    spacing: 8,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextTheme.of(
                context,
              ).titleLarge?.copyWith(color: Colors.black87),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                ProductRating(rating: 4.7),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Reviews',
                    style: TextTheme.of(
                      context,
                    ).titleMedium?.copyWith(color: AppColors.themeColor),
                  ),
                ),

                FavIcon(onTap: () {}),
              ],
            ),
          ],
        ),
      ),
      IncDecButton(onChange: (int quantity) {}),
    ],
  );
}
