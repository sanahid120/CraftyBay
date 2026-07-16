import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../providers/add_to_cart_provider.dart';


class AddToCartBar extends StatelessWidget {
  const AddToCartBar({
    super.key,required this.price,required this.onTapAddToCart
  });
  final int price;
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
          Consumer<AddToCartProvider>(
            builder: (context, provider, _) {
              return Visibility(
                visible: provider.addToCartInProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: FilledButton(
                  
                  style: FilledButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      fixedSize: Size.fromWidth(120)
                  ),
                
                  onPressed: onTapAddToCart, child: Text("Add To Cart"), ),
              );
            }
          )
        ],
      ),
    );
  }
}
