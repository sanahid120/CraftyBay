import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';


class AddToCartBar extends StatelessWidget {
  const AddToCartBar({
    super.key,required this.price,required this.onTapAddToCart
  });
  final double price;
  final VoidCallback onTapAddToCart;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(
          color: AppColors.themeColor.withAlpha(30),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            children: [
              Text('Price',style: TextTheme.of(context).bodyLarge?.copyWith(color: AppColors.themeColor),),
              Text('${Constants.takaSing}$price', style: TextTheme.of(context).titleLarge?.copyWith(color: AppColors.themeColor),),
            ],
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                fixedSize: Size.fromWidth(120)
            ),

            onPressed: onTapAddToCart, child: Text("Add To Cart"), )
        ],
      ),
    );
  }
}
