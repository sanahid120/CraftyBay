import 'package:craftybay/app/constants.dart';
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
  const ProductDetailsScreen({super.key});
  static const String name = "/ProductDetailsScreen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> colors = [
      "Black",
      "Red",
      "Green",
      "Yellow",
      "Magenta",
      "Blue",
      "White",
    ];
    List<String> sizes = ["S", "M", "L", "XL", "XXL"];

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
            child: Column(
              children: [
                ProductDetailsImageSlider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildTitleSection(context),

                        const SizedBox(height: 16),
                        ColorPicker(
                          colors: colors,
                          onColorSelected: (String color) {},
                        ),
                        const SizedBox(height: 16),
                        SizePicker(
                          sizes: sizes,
                          onSizeSelected: (String color) {},
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Description",
                              style: TextTheme.of(context).titleMedium
                                  ?.copyWith(color: AppColors.themeColor),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                              style: TextTheme.of(context).bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 25,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          AddToCartBar(price: 120, onTapAddToCart: () {}),
        ],
      ),
    );
  }
}

Widget buildTitleSection(BuildContext context) {
  return Row(
    spacing: 8,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nike 2026- New Edition Shoe With Black Color',
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
