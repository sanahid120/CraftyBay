import 'dart:math';

import 'package:craftybay/features/products/data/model/product_model.dart';
import 'package:craftybay/features/products/presentation/widgets/size_picker.dart';
import 'package:craftybay/shared/presentation/widgets/fav_icon.dart';
import 'package:craftybay/shared/presentation/widgets/inc_dec_button.dart';
import 'package:craftybay/shared/presentation/widgets/snackbar_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/controllers/auth_controller.dart';
import '../../../../shared/presentation/widgets/product_rating.dart';
import '../models/cart_model.dart';
import '../providers/add_to_cart_provider.dart';
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
  final AddToCartProvider _addToCartProvider = AddToCartProvider();
  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _addToCartProvider,
      child: Scaffold(
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
                              onColorSelected: (String color) {
                                _selectedColor = color;
                              },
                            ),
                            const SizedBox(height: 16),
                            SizePicker(
                              sizes: widget.productDetails.sizes,
                              onSizeSelected: (String size) {
                                _selectedSize = size;
                              },
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
              onTapAddToCart: () async {
                if (widget.productDetails.sizes.isNotEmpty) {
                  if (_selectedSize == null) {
                    showSnackBarMessage(context, "Please Select a Size");
                    return;
                  }
                }
                if (widget.productDetails.colors.isNotEmpty) {
                  if (_selectedColor == null) {
                    showSnackBarMessage(context, "Please Select a Color");
                    return;
                  }
                }

                if (mounted) {
                  bool isSuccess = await _addToCartProvider.addToCart(
                    CartModel(
                      product: widget.productDetails.id,
                      color: _selectedColor ?? '',
                      size: _selectedSize ?? '',
                      quantity: _quantity,
                    ),
                  );
                  if (isSuccess) {
                    showSnackBarMessage(context, "Product Added to Cart");
                  } else {
                    showSnackBarMessage(
                      context,
                      _addToCartProvider.errorMessage!,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitleSection(BuildContext context, String title) {
    Random random = Random();
    double randomNumber = random.nextDouble() * 5;
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
                  ProductRating(rating: randomNumber.toStringAsFixed(1)),
                  TextButton(
                    onPressed: () {
                      onPressedReviewButton(context);
                    },
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
        IncDecButton(
          onChange: (int quantity) {
            _quantity = quantity;
          },
        ),
      ],
    );
  }
}

Future<void> onPressedReviewButton(BuildContext context) async {
  if (await AuthController.isUserLoggedIn()) {
  } else {
    showSnackBarMessage(context, "Please Login First!");
  }
}
